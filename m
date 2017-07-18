Received: from eggs.gnu.org ([2001:4830:134:3::10]:45379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXV7C-0004Tz-WE
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXV7A-0001yd-24
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:12:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dXV79-0001y8-SA
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:12:47 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Jul 2017 12:12:30 -0400
Message-Id: <20170718161230.21917-5-jsnow@redhat.com>
In-Reply-To: <20170718161230.21917-1-jsnow@redhat.com>
References: <20170718161230.21917-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] tests/ahci-test: Be mean with RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The migration tests used two VMs each with -m 1024 this caused
problems when run in some small, pessimistic test VMs (netbsd).
We can just be meaner with the amount of RAM in the test and use -m 384

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-id: 20170714152820.24034-1-dgilbert@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/ahci-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index ef17629..999121b 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -1132,9 +1132,9 @@ static void test_migrate_sanity(void)
     AHCIQState *src, *dst;
     char *uri = g_strdup_printf("unix:%s", mig_socket);
 
-    src = ahci_boot("-m 1024 -M q35 "
+    src = ahci_boot("-m 384 -M q35 "
                     "-drive if=ide,file=%s,format=%s ", tmp_path, imgfmt);
-    dst = ahci_boot("-m 1024 -M q35 "
+    dst = ahci_boot("-m 384 -M q35 "
                     "-drive if=ide,file=%s,format=%s "
                     "-incoming %s", tmp_path, imgfmt, uri);
 
@@ -1157,10 +1157,10 @@ static void ahci_migrate_simple(uint8_t cmd_read, uint8_t cmd_write)
     unsigned char *rx = g_malloc0(bufsize);
     char *uri = g_strdup_printf("unix:%s", mig_socket);
 
-    src = ahci_boot_and_enable("-m 1024 -M q35 "
+    src = ahci_boot_and_enable("-m 384 -M q35 "
                                "-drive if=ide,format=%s,file=%s ",
                                imgfmt, tmp_path);
-    dst = ahci_boot("-m 1024 -M q35 "
+    dst = ahci_boot("-m 384 -M q35 "
                     "-drive if=ide,format=%s,file=%s "
                     "-incoming %s", imgfmt, tmp_path, uri);
 
-- 
2.9.4
