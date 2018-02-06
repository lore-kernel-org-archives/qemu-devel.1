Received: from eggs.gnu.org ([2001:4830:134:3::10]:43963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5Xe-0004DR-Ju
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5XY-0005v5-TI
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:52:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ej5XY-0005uU-N0
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:52:12 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  6 Feb 2018 15:49:30 +0000
Message-Id: <20180206154936.13565-9-dgilbert@redhat.com>
In-Reply-To: <20180206154936.13565-1-dgilbert@redhat.com>
References: <20180206154936.13565-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 08/14] tests: Use consistent names for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: peterx@redhat.com, lvivier@redhat.com, groug@kaod.org, ross.lagerwall@citrix.com, wei.w.wang@intel.com, danielhb@linux.vnet.ibm.com

From: Juan Quintela <quintela@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
