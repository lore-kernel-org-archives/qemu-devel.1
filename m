Received: from eggs.gnu.org ([2001:4830:134:3::10]:45333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dues1-0003MY-SL
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1duert-0001JJ-LW
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1duert-0001IJ-68
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0C5A25C29
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 10:50:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Sep 2017 12:50:26 +0200
Message-Id: <20170920105026.1458-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH] tests: Move postcopy migration test to
 migrate-set-parameters
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

migrate_set_speed and migrate_set_dowtime are deprecated since long ago.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/postcopy-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index 8142f2ab90..991b954a83 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -430,14 +430,14 @@ static void test_migrate(void)
      * machine, so also set the downtime.
      */
     global_qtest = from;
-    rsp = qmp("{ 'execute': 'migrate_set_speed',"
-              "'arguments': { 'value': 100000000 } }");
+    rsp = qmp("{ 'execute': 'migrate-set-parameters',"
+              "'arguments': { 'max-bandwidth': 100000000 } }");
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);
 
     /* 1ms downtime - it should never finish precopy */
-    rsp = qmp("{ 'execute': 'migrate_set_downtime',"
-              "'arguments': { 'value': 0.001 } }");
+    rsp = qmp("{ 'execute': 'migrate-set-parameters',"
+              "'arguments': { 'downtime-limit': 1 } }");
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);
 
-- 
2.13.5
