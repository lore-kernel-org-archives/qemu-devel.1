Received: from eggs.gnu.org ([2001:4830:134:3::10]:52182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzh5c-0007b3-Ns
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzh5b-00046B-SB
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:39:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dzh5b-00045t-Ml
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:39:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1C3080E7A
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 10:39:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  4 Oct 2017 12:39:29 +0200
Message-Id: <20171004103933.7898-3-quintela@redhat.com>
In-Reply-To: <20171004103933.7898-1-quintela@redhat.com>
References: <20171004103933.7898-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 2/6] tests: Add basic migration precopy tcp test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index cd954caee4..8ef2b72459 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -466,6 +466,13 @@ static void test_precopy_unix(void)
     g_free(uri);
 }
 
+static void test_precopy_tcp(void)
+{
+    const char *uri = "tcp:0:44444";
+
+    test_precopy(uri);
+}
+
 int main(int argc, char **argv)
 {
     char template[] = "/tmp/migration-test-XXXXXX";
@@ -482,6 +489,7 @@ int main(int argc, char **argv)
     module_call_init(MODULE_INIT_QOM);
 
     qtest_add_func("/migration/precopy/unix", test_precopy_unix);
+    qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
 
     ret = g_test_run();
 
-- 
2.13.5
