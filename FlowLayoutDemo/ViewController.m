//
//  Copyright (c) 2013 Luke Scott
//  https://github.com/lukescott/DraggableCollectionView
//  Distributed under MIT license
//

#import "ViewController.h"
#import "NextViewController.h"
#import "Cell.h"

#define SECTION_COUNT 5
#define ITEM_COUNT 20

@interface ViewController ()
{
    NSMutableArray *sections;
}

@property NSMutableArray *theArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.theArray = [NSMutableArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", nil];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.theArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell *cell = (Cell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    cell.label.text = [self.theArray objectAtIndex:indexPath.item];

    return cell;
}

- (BOOL)collectionView:(LSCollectionViewHelper *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    return YES;
}

- (void)collectionView:(LSCollectionViewHelper *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    id object = [self.theArray objectAtIndex:fromIndexPath.row];
    [self.theArray removeObjectAtIndex:fromIndexPath.row];
    [self.theArray insertObject:object atIndex:toIndexPath.row];


    dispatch_async(dispatch_get_main_queue(), ^
    {

        [self.collectionView reloadData];

    });
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    NextViewController *nextVC = [segue destinationViewController];

    int theInt = (int) [[[self.collectionView indexPathsForSelectedItems] firstObject] row];

    NSLog(@"%@", [self.theArray objectAtIndex:theInt]);
}

@end
