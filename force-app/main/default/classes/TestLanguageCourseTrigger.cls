@isTest
private class TestLanguageCourseTrigger {

    @TestSetup
    static void setup() {
        Language_Course_Instructor__c instructor = new Language_Course_Instructor__c(
            Name = 'Test Instructor'
        );
        insert instructor;
    }

    @isTest
    static void testInsert() {
        Language_Course_Instructor__c instructor = [SELECT Id FROM Language_Course_Instructor__c LIMIT 1];

        Test.startTest();
        Language_Course__c course = new Language_Course__c(
            Name = 'Test Course',
            Course_Instructor__c = instructor.Id
        );
        insert course;
        Test.stopTest();

        System.assertNotEquals(null, [SELECT Id FROM Language_Course__c WHERE Id = :course.Id].Id);
    }

    @isTest
    static void testUpdate() {
        Language_Course_Instructor__c instructor = [SELECT Id FROM Language_Course_Instructor__c LIMIT 1];
        Language_Course__c course = new Language_Course__c(
            Name = 'Test Course',
            Course_Instructor__c = instructor.Id
        );
        insert course;

        Test.startTest();
        course.Name__c = 'Updated Course Name';
        update course;
        Test.stopTest();

        Language_Course__c updated = [SELECT Name__c FROM Language_Course__c WHERE Id = :course.Id];
        System.assertEquals('Updated Course Name', updated.Name__c);
    }

    @isTest
    static void testDelete() {
        Language_Course_Instructor__c instructor = [SELECT Id FROM Language_Course_Instructor__c LIMIT 1];
        Language_Course__c course = new Language_Course__c(
            Name = 'Test Course',
            Course_Instructor__c = instructor.Id
        );
        insert course;
        Id courseId = course.Id;

        Test.startTest();
        delete course;
        Test.stopTest();

        List<Language_Course__c> results = [SELECT Id FROM Language_Course__c WHERE Id = :courseId];
        System.assertEquals(0, results.size());
    }
}
