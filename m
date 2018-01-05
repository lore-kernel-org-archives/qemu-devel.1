Received: from eggs.gnu.org ([2001:4830:134:3::10]:38406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXZvE-0002P2-6z
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXZvB-0003ER-1o
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eXZvA-0003D7-NE
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:53:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7CC74E906
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 21:52:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  5 Jan 2018 22:52:39 +0100
Message-Id: <20180105215246.908-5-quintela@redhat.com>
In-Reply-To: <20180105215246.908-1-quintela@redhat.com>
References: <20180105215246.908-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v4 04/11] tests: Use consistent names and sizes
 for migration
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
 tests/migration-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index d81f22118b..f469235d0b 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -440,13 +440,13 @@ static void test_migrate_start(QTestState **from, QTestState **to,
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         init_bootfile_x86(bootpath);
-        cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
-                                  " -name pcsource,debug-threads=on"
+        cmd_src = g_strdup_printf("-machine accel=%s -m 256M"
+                                  " -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
                                   " -drive file=%s,format=raw",
                                   accel, tmpfs, bootpath);
-        cmd_dst = g_strdup_printf("-machine accel=%s -m 150M"
-                                  " -name pcdest,debug-threads=on"
+        cmd_dst = g_strdup_printf("-machine accel=%s -m 256M"
+                                  " -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial"
                                   " -drive file=%s,format=raw"
                                   " -incoming %s",
@@ -459,12 +459,12 @@ static void test_migrate_start(QTestState **from, QTestState **to,
         }
         init_bootfile_ppc(bootpath);
         cmd_src = g_strdup_printf("-machine accel=%s -m 256M"
-                                  " -name pcsource,debug-threads=on"
+                                  " -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
                                   " -drive file=%s,if=pflash,format=raw",
                                   accel, tmpfs, bootpath);
         cmd_dst = g_strdup_printf("-machine accel=%s -m 256M"
-                                  " -name pcdest,debug-threads=on"
+                                  " -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial"
                                   " -drive file=%s,if=pflash,format=raw"
                                   " -incoming %s",
-- 
2.14.3
