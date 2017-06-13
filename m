Received: from eggs.gnu.org ([2001:4830:134:3::10]:50864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4W-0004QE-N5
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4V-0000S4-BF
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKp4V-0000Rx-4b
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:39 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 13:53:08 -0300
Message-Id: <20170613165313.20954-11-ehabkost@redhat.com>
In-Reply-To: <20170613165313.20954-1-ehabkost@redhat.com>
References: <20170613165313.20954-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 10/15] test-qapi-util: Use ERR_IS_* macros
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
index 374fa30078..fe232ef9ed 100644
--- a/tests/test-qapi-util.c
+++ b/tests/test-qapi-util.c
@@ -77,25 +77,25 @@ static void test_parse_qapi_name(void)
 
 static void successfn(Error **errp)
 {
-    g_assert(!errp || !*errp);
+    g_assert(ERR_IS_IGNORED(errp) || !ERR_IS_SET(errp));
 }
 
 static void fail1(Error **errp)
 {
-    g_assert(!errp || !*errp);
+    g_assert(ERR_IS_IGNORED(errp) || !ERR_IS_SET(errp));
 
     error_setg(errp, "error1");
 
-    g_assert(!errp || *errp);
+    g_assert(ERR_IS_IGNORED(errp) || ERR_IS_SET(errp));
 }
 
 static void fail2(Error **errp)
 {
-    g_assert(!errp || !*errp);
+    g_assert(ERR_IS_IGNORED(errp) || !ERR_IS_SET(errp));
 
     error_setg(errp, "error2");
 
-    g_assert(!errp || *errp);
+    g_assert(ERR_IS_IGNORED(errp) || ERR_IS_SET(errp));
 }
 
 static void multifn(Error **errp)
@@ -124,13 +124,13 @@ static void test_propagate(void (*fn)(Error **), Error **errp)
     bool failed;
     Error *local_err = NULL;
 
-    g_assert(!errp || !*errp);
+    g_assert(ERR_IS_IGNORED(errp) || !ERR_IS_SET(errp));
 
     fn(&local_err);
     failed = !!local_err;
     error_propagate(errp, local_err);
 
-    g_assert(!errp || (failed == !!*errp));
+    g_assert(ERR_IS_IGNORED(errp) || (failed == !!ERR_IS_SET(errp)));
 }
 
 static void test_error_api(void)
-- 
2.11.0.259.g40922b1
