-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb_1nf
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb_1nf
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb_1nf` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema mydb_2nf
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb_2nf
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb_2nf` ;
-- -----------------------------------------------------
-- Schema mydb_3nf
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb_3nf
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb_3nf` ;
USE `mydb_1nf` ;

-- -----------------------------------------------------
-- Table `mydb_1nf`.`Requests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_1nf`.`Requests` (
  `Request_Num` INT NOT NULL,
  `Item_Name` VARCHAR(45) NOT NULL,
  `Item_Number` INT NOT NULL,
  `Client_Adress` VARCHAR(45) NOT NULL,
  `Request_Date` DATE NOT NULL,
  `Client_Name` VARCHAR(45) NOT NULL)
ENGINE = InnoDB;

USE `mydb_2nf` ;

-- -----------------------------------------------------
-- Table `mydb_2nf`.`Request_Dates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_2nf`.`Request_Dates` (
  `Request_id` INT NOT NULL,
  `Request_Date` DATE NOT NULL,
  PRIMARY KEY (`Request_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_2nf`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_2nf`.`Clients` (
  `Request_id` INT NOT NULL,
  `Client` VARCHAR(45) NOT NULL,
  `Client_Adress` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Request_id`),
  CONSTRAINT `Clients_Request_Dates`
    FOREIGN KEY (`Request_id`)
    REFERENCES `mydb_2nf`.`Request_Dates` (`Request_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_2nf`.`Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_2nf`.`Items` (
  `Request_id` INT NOT NULL,
  `Item_Name` VARCHAR(45) NOT NULL,
  `Item_Num` INT NOT NULL,
  CONSTRAINT `Items_Clients`
    FOREIGN KEY (`Request_id`)
    REFERENCES `mydb_2nf`.`Clients` (`Request_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb_3nf` ;

-- -----------------------------------------------------
-- Table `mydb_3nf`.`Adressess`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_3nf`.`Adressess` (
  `Client` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Client`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_3nf`.`Request_Dates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_3nf`.`Request_Dates` (
  `Request_id` INT NOT NULL,
  `Request_Date` DATE NOT NULL,
  PRIMARY KEY (`Request_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_3nf`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_3nf`.`Clients` (
  `Request_id` INT NOT NULL,
  `Client` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Request_id`),
  INDEX `fk_Clients_Adressess_idx` (`Client` ASC) VISIBLE,
  CONSTRAINT `fk_Clients_Adressess`
    FOREIGN KEY (`Client`)
    REFERENCES `mydb_3nf`.`Adressess` (`Client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clients_Request_Dates1`
    FOREIGN KEY (`Request_id`)
    REFERENCES `mydb_3nf`.`Request_Dates` (`Request_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_3nf`.`Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_3nf`.`Items` (
  `Request_id` INT NOT NULL,
  `Item_Name` VARCHAR(45) NOT NULL,
  `Item_Num` INT NOT NULL,
  INDEX `fk_Items_Clients1_idx` (`Request_id` ASC) VISIBLE,
  CONSTRAINT `fk_Items_Clients1`
    FOREIGN KEY (`Request_id`)
    REFERENCES `mydb_3nf`.`Clients` (`Request_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
