Received: from eggs.gnu.org ([2001:4830:134:3::10]:41426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8GG-0005m8-SR
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8GA-0001V5-On
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:10:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eg8GA-0001UW-Ip
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:10:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE24418B241
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 12:10:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 29 Jan 2018 13:09:27 +0100
Message-Id: <20180129120932.12874-9-quintela@redhat.com>
In-Reply-To: <20180129120932.12874-1-quintela@redhat.com>
References: <20180129120932.12874-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 08/13] tests: Use consistent names for migration
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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/migration-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 3732682a29..ac4a916169 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -429,12 +429,12 @@ static void test_migrate_start(QTestState **from, QTestState **to,
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         init_bootfile_x86(bootpath);
         cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
-                                  " -name pcsource,debug-threads=on"
+                                  " -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
                                   " -drive file=%s,format=raw",
                                   accel, tmpfs, bootpath);
         cmd_dst = g_strdup_printf("-machine accel=%s -m 150M"
-                                  " -name pcdest,debug-threads=on"
+                                  " -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial"
                                   " -drive file=%s,format=raw"
                                   " -incoming %s",
@@ -447,12 +447,12 @@ static void test_migrate_start(QTestState **from, QTestState **to,
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
                                   " -incoming %s",
                                   accel, tmpfs, uri);
-- 
2.14.3
