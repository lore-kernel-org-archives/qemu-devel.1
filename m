Received: from eggs.gnu.org ([2001:4830:134:3::10]:50818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4O-0004J3-3g
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4N-0000QV-BD
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKp4N-0000QP-4e
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 13:53:04 -0300
Message-Id: <20170613165313.20954-7-ehabkost@redhat.com>
In-Reply-To: <20170613165313.20954-1-ehabkost@redhat.com>
References: <20170613165313.20954-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 06/15] test-qapi-util: Use IGNORE_ERRORS instead
 of NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/test-qapi-util.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/test-qapi-util.c b/tests/test-qapi-util.c
index 3695034c32..374fa30078 100644
--- a/tests/test-qapi-util.c
+++ b/tests/test-qapi-util.c
@@ -25,7 +25,7 @@ static void test_qapi_enum_parse(void)
     g_assert_cmpint(ret, ==, QTYPE_NONE);
 
     ret = qapi_enum_parse(QType_lookup, "junk", QTYPE__MAX, -1,
-                          NULL);
+                          IGNORE_ERRORS);
     g_assert_cmpint(ret, ==, -1);
 
     ret = qapi_enum_parse(QType_lookup, "junk", QTYPE__MAX, -1,
@@ -137,14 +137,14 @@ static void test_error_api(void)
 {
     Error *err = NULL;
 
-    successfn(NULL);
-    test_propagate(successfn, NULL);
+    successfn(IGNORE_ERRORS);
+    test_propagate(successfn, IGNORE_ERRORS);
 
-    fail1(NULL);
-    test_propagate(fail1, NULL);
+    fail1(IGNORE_ERRORS);
+    test_propagate(fail1, IGNORE_ERRORS);
 
-    multifn(NULL);
-    test_propagate(multifn, NULL);
+    multifn(IGNORE_ERRORS);
+    test_propagate(multifn, IGNORE_ERRORS);
 
     successfn(&err);
     g_assert(!err);
-- 
2.11.0.259.g40922b1
