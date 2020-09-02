//
//  main.swift
//  TheRiddleOfEinstein
//
//  Created by Sergey Khmelow on 02.09.2020.
//  Copyright © 2020 Sergey Khmelow. All rights reserved.
//

import Foundation

enum Colors:Int{
    case Red
    case Green
    case Yellow
    case Blue
    case White
}

let ColorsStr = ["Red", "Green", "Yellow", "Blue", "White", "Nil"]

enum Pets:Int{
    case Dog
    case Snails
    case Fox
    case Horse
    case Zebra
}

let PetStr = ["Dog", "Snails", "Fox", "Horse", "Zebra", "Nil"]

enum Drinkables:Int{
    case Milk
    case Tea
    case Coffee
    case Juice
    case Water
}

let DrinkablesStr = ["Milk", "Tea", "Coffee", "Juice", "Water", "Nil"]


enum Nationalities:Int{
    case Englishman
    case Hispanic
    case Ukrainian
    case Norwegian
    case Japanese
}

let NationalitiesStr = ["Englishman", "Hispanic", "Ukrainian", "Norwegian", "Japanese", "Nil"]

enum CigaretteBrands:Int{
    case OldGold
    case Kool
    case Chesterfield
    case LuckyStrike
    case Parliament
}

let CigaretteBrandsStr = ["Old Gold", "Kool", "Chesterfield", "LuckyStrike", "Parliament", "Nil"]

enum Property:Int{
    case Color
    case Drink
    case Pet
    case Cigarettes
    case Nationality
}

let HouseCount = 5
let PropertyCount = 5

var matrix = [[5,5,5,5,5],
              [5,5,5,5,5],
              [5,5,5,5,5],
              [5,5,5,5,5],
              [5,5,5,5,5]]

func main(){
    
    if findSoulution(x: 0, y: 0) {
        printMatrix()
    }
    else{
        print("Решение не найдено!!!")
    }
}

func findSoulution(x:Int, y:Int) -> Bool{

    let tmp = matrix[x][y]
    
    for i in 0...4 {
        matrix[x][y] = i
//        print(matrix[x][y])
        if check(){
//            printMatrix()
            let newY = (y + 1) % PropertyCount
            let newX = x + (newY != 0 ? 0 : 1)
            if  newX >= HouseCount || findSoulution(x: newX, y: newY){
                return true
            }
        }
        
    }
    
//    print(matrix)
    matrix[x][y] = tmp
    return false
}

func check() -> Bool{
    
    for i in 0..<HouseCount {
        for j in 0..<PropertyCount {
            let property1 = matrix[i][j]
            let z = i + 1
            for k in z..<HouseCount {
//                if k == i {
//                    continue
//                }
                let property2 = matrix[k][j]
                if property1 != 5 && property2 != 5 && property1 == property2 {
                    return false
                }
            }
        }
    }
    
//    printMatrix()
    //1) На улице стоят 5 домов
    //Проверять нет смысла, матрица 5*5
    
    //2) Англичанин живёт в красном доме.
    for numberHouse in 0..<HouseCount {
        if matrix[numberHouse][Property.Nationality.rawValue] == Nationalities.Englishman.rawValue
            && matrix[numberHouse][Property.Color.rawValue] != 5
            && matrix[numberHouse][Property.Color.rawValue] != Colors.Red.rawValue {
            return false;
        }
    }

    //3) У испанца есть собака.
    for numberHouse in 0..<HouseCount {
        if matrix[numberHouse][Property.Nationality.rawValue] == Nationalities.Hispanic.rawValue
            && matrix[numberHouse][Property.Pet.rawValue] != 5
            && matrix[numberHouse][Property.Pet.rawValue] != Pets.Dog.rawValue {
//            printMatrix()
//            print(matrix)
            return false;
        }
    }

    //4) В зелёном доме пьют кофе.
    for numberHouse in 0..<HouseCount {
        if matrix[numberHouse][Property.Color.rawValue] == Colors.Green.rawValue
            && matrix[numberHouse][Property.Drink.rawValue] != 5
            && matrix[numberHouse][Property.Drink.rawValue] != Drinkables.Coffee.rawValue {
            return false;
        }
    }

    //5) Украинец пьёт чай.
    for numberHouse in 0..<HouseCount {
        if matrix[numberHouse][Property.Nationality.rawValue] == Nationalities.Ukrainian.rawValue
            && matrix[numberHouse][Property.Drink.rawValue] != 5
            && matrix[numberHouse][Property.Drink.rawValue] != Drinkables.Tea.rawValue {
            return false;
        }
    }

    //6) Зелёный дом стоит сразу справа от белого дома.
    for numberHouse in 0..<HouseCount {
        if matrix[numberHouse][Property.Color.rawValue] == Colors.White.rawValue
            && numberHouse == 4 {
            return false;
        }
        if matrix[numberHouse][Property.Color.rawValue] == Colors.Green.rawValue
            && numberHouse == 0{
            return false;
        }

        if matrix[numberHouse][Property.Color.rawValue] == Colors.White.rawValue
            && matrix[numberHouse + 1][Property.Color.rawValue] != 5
            && matrix[numberHouse + 1][Property.Color.rawValue] != Colors.Green.rawValue{
            return false;
        }
    }

    //7) Тот, кто курит Old Gold, разводит улиток
    for numberHouse in 0..<HouseCount {
        if matrix[numberHouse][Property.Cigarettes.rawValue] == CigaretteBrands.OldGold.rawValue
            && matrix[numberHouse][Property.Pet.rawValue] != 5
            && matrix[numberHouse][Property.Pet.rawValue] != Pets.Snails.rawValue {
            return false;
        }
    }

    //8) В жёлтом доме курят Kool
    for numberHouse in 0..<HouseCount {
        if matrix[numberHouse][Property.Color.rawValue] == Colors.Yellow.rawValue
            && matrix[numberHouse][Property.Cigarettes.rawValue] != 5
            && matrix[numberHouse][Property.Cigarettes.rawValue] != CigaretteBrands.Kool.rawValue {
            return false;
        }
    }
    
    //9) В центральном доме пьют молоко
    if matrix[2][Property.Drink.rawValue] != 5 && matrix[2][Property.Drink.rawValue] != Drinkables.Milk.rawValue{
        return false
    }
    
    //10) Норвежец живёт в первом доме
    if matrix[0][Property.Nationality.rawValue] != 5 && matrix[0][Property.Nationality.rawValue] != Nationalities.Norwegian.rawValue{
        return false
    }

    //11) Сосед того, кто курит Chesterfield, держит лису
    for numberHouse in 0..<HouseCount {
        if matrix[numberHouse][Property.Cigarettes.rawValue] == CigaretteBrands.Chesterfield.rawValue
            && !neighborOf(numberHouse: numberHouse, numberProperty: Property.Pet.rawValue, value: Pets.Fox.rawValue) {
            return false;
        }
    }
    
    //12) В доме по соседству с тем, в котором держат лошадь, курят Kool
    for numberHouse in 0..<HouseCount {
        if matrix[numberHouse][Property.Pet.rawValue] == Pets.Horse.rawValue
            && !neighborOf(numberHouse: numberHouse, numberProperty: Property.Cigarettes.rawValue, value: CigaretteBrands.Kool.rawValue) {
            return false;
        }
    }
    
    //13) Тот кто курит Lucky Strike, пьёт апельсиновый сок
    for numberHouse in 0..<HouseCount {
        if matrix[numberHouse][Property.Cigarettes.rawValue] == CigaretteBrands.LuckyStrike.rawValue
            && matrix[numberHouse][Property.Drink.rawValue] != 5
            && matrix[numberHouse][Property.Drink.rawValue] != Drinkables.Juice.rawValue {
            return false;
        }
    }

    //14) Японец курит Parliament
    for numberHouse in 0..<HouseCount {
        if matrix[numberHouse][Property.Nationality.rawValue] == Nationalities.Japanese.rawValue
            && matrix[numberHouse][Property.Cigarettes.rawValue] != 5
            && matrix[numberHouse][Property.Cigarettes.rawValue] != CigaretteBrands.Parliament.rawValue {
            return false;
        }
    }

    //15) Норвежец живёт рядом с синим домом
    for numberHouse in 0..<HouseCount {
        if matrix[numberHouse][Property.Nationality.rawValue] == Nationalities.Norwegian.rawValue
            && !neighborOf(numberHouse: numberHouse, numberProperty: Property.Color.rawValue, value: Colors.Blue.rawValue) {
            return false;
        }
    }
    
    return true
}

func printMatrix(){
    for numberHouse in 0..<HouseCount {
        print("""
            Номер дома: \(numberHouse + 1), Цвет: \(ColorsStr[matrix[numberHouse][Property.Color.rawValue]]) Питомец: \(PetStr[matrix[numberHouse][Property.Pet.rawValue]]) Напиток: \(DrinkablesStr[matrix[numberHouse][Property.Drink.rawValue]]) Национальность: \(NationalitiesStr[matrix[numberHouse][Property.Nationality.rawValue]]) Марка сигарет: \(CigaretteBrandsStr[matrix[numberHouse][Property.Cigarettes.rawValue]])
            """)
    }
}

func neighborOf(numberHouse:Int, numberProperty:Int, value:Int) -> Bool{
    return (numberHouse >= 1 && (matrix[numberHouse-1][numberProperty] == 5 || matrix[numberHouse-1][numberProperty] == value))
            ||
            (numberHouse < HouseCount-1 && (matrix[numberHouse+1][numberProperty] == 5 || matrix[numberHouse+1][numberProperty] == value))
}

main()

