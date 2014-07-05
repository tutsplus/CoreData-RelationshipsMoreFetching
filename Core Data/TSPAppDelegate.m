//
//  TSPAppDelegate.m
//  Core Data
//
//  Created by Bart Jacobs on 01/05/14.
//  Copyright (c) 2014 Tuts+. All rights reserved.
//

#import "TSPAppDelegate.h"

/*
@interface TSPAppDelegate ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
*/

@implementation TSPAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Initialize Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Configure Window
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    
    /*
    // Create Person
    NSEntityDescription *entityPerson = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    NSManagedObject *newPerson = [[NSManagedObject alloc] initWithEntity:entityPerson insertIntoManagedObjectContext:self.managedObjectContext];
    
    // Set First and Last Name
    [newPerson setValue:@"Bart" forKey:@"first"];
    [newPerson setValue:@"Jacobs" forKey:@"last"];
    [newPerson setValue:@44 forKey:@"age"];
    
    // Create Address
    NSEntityDescription *entityAddress = [NSEntityDescription entityForName:@"Address" inManagedObjectContext:self.managedObjectContext];
    NSManagedObject *newAddress = [[NSManagedObject alloc] initWithEntity:entityAddress insertIntoManagedObjectContext:self.managedObjectContext];
    
    // Set First and Last Name
    [newAddress setValue:@"Main Street" forKey:@"street"];
    [newAddress setValue:@"Boston" forKey:@"city"];
    
    // Add Address to Person
    [newPerson setValue:[NSSet setWithObject:newAddress] forKey:@"addresses"];
    
    // Create Address
    NSManagedObject *otherAddress = [[NSManagedObject alloc] initWithEntity:entityAddress insertIntoManagedObjectContext:self.managedObjectContext];
    
    // Set First and Last Name
    [otherAddress setValue:@"5th Avenue" forKey:@"street"];
    [otherAddress setValue:@"New York" forKey:@"city"];
    
    // Add Address to Person
    NSMutableSet *addresses = [newPerson mutableSetValueForKey:@"addresses"];
    [addresses addObject:otherAddress];
    
    // Delete Relationship
    [newPerson setValue:nil forKey:@"addresses"];
    
    // Create Another Person
    NSManagedObject *anotherPerson = [[NSManagedObject alloc] initWithEntity:entityPerson insertIntoManagedObjectContext:self.managedObjectContext];
    
    // Set First and Last Name
    [anotherPerson setValue:@"Jane" forKey:@"first"];
    [anotherPerson setValue:@"Doe" forKey:@"last"];
    [anotherPerson setValue:@42 forKey:@"age"];
    
    // Create Relationship
    [newPerson setValue:anotherPerson forKey:@"spouse"];
    
    NSManagedObject *spouse = [newPerson valueForKey:@"spouse"];
    // NSLog(@"%@ %@", [spouse valueForKey:@"first"], [spouse valueForKey:@"last"]);
    
    // Create a Child Person
    NSManagedObject *newChildPerson = [[NSManagedObject alloc] initWithEntity:entityPerson insertIntoManagedObjectContext:self.managedObjectContext];
    
    // Set First and Last Name
    [newChildPerson setValue:@"Jim" forKey:@"first"];
    [newChildPerson setValue:@"Doe" forKey:@"last"];
    [newChildPerson setValue:@21 forKey:@"age"];
    
    // Create Relationship
    NSMutableSet *children = [newPerson mutableSetValueForKey:@"children"];
    [children addObject:newChildPerson];
    
    // Create Another Child Person
    NSManagedObject *anotherChildPerson = [[NSManagedObject alloc] initWithEntity:entityPerson insertIntoManagedObjectContext:self.managedObjectContext];
    
    // Set First and Last Name
    [anotherChildPerson setValue:@"Lucy" forKey:@"first"];
    [anotherChildPerson setValue:@"Doe" forKey:@"last"];
    [anotherChildPerson setValue:@19 forKey:@"age"];
    
    // Create Relationship
    [anotherChildPerson setValue:newPerson forKeyPath:@"father"];
    
    // Save Managed Object Context
    NSError *error = nil;
    if (![newPerson.managedObjectContext save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    */
    
    // Fetching
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    
    // Create Predicate
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"last", @"Doe"];
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K >= %@", @"age", @(30)];
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS %@", @"first", @"j"];
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[c] %@", @"first", @"j"];
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[c] %@ AND %K < 30", @"first", @"j", @"age", @(30)];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"father.first", @"Bart"];
    [fetchRequest setPredicate:predicate];
    
    // Add Sort Descriptor
    NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"last" ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor1, sortDescriptor2]];
    
    // Execute Fetch Request
    NSError *fetchError = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    
    if (!fetchError) {
        for (NSManagedObject *managedObject in result) {
            NSLog(@"%@, %@", [managedObject valueForKey:@"first"], [managedObject valueForKey:@"last"]);
//            NSLog(@"%@, %@ (%@)", [managedObject valueForKey:@"first"], [managedObject valueForKey:@"last"], [managedObject valueForKey:@"age"]);
        }
        
    } else {
        NSLog(@"Error fetching data.");
        NSLog(@"%@, %@", fetchError, fetchError.localizedDescription);
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Core_Data" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Core_Data.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
