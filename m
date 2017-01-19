Received: from eggs.gnu.org ([2001:4830:134:3::10]:54078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUDsH-0000Ru-0p
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUDsG-0003eH-3g
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:39:37 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 19 Jan 2017 22:38:12 +0800
Message-Id: <20170119143816.21972-13-famz@redhat.com>
In-Reply-To: <20170119143816.21972-1-famz@redhat.com>
References: <20170119143816.21972-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v10 12/16] tests: Use null-co:// instead of
 /dev/null as the dummy image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, rjones@redhat.com

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/drive_del-test.c    | 2 +-
 tests/nvme-test.c         | 2 +-
 tests/usb-hcd-uhci-test.c | 2 +-
 tests/usb-hcd-xhci-test.c | 2 +-
 tests/virtio-blk-test.c   | 2 +-
 tests/virtio-scsi-test.c  | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 121b9c9..2175139 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -92,7 +92,7 @@ static void test_after_failed_device_add(void)
 static void test_drive_del_device_del(void)
 {
     /* Start with a drive used by a device that unplugs instantaneously */
-    qtest_start("-drive if=none,id=drive0,file=/dev/null,format=raw"
+    qtest_start("-drive if=none,id=drive0,file=null-co://,format=raw"
                 " -device virtio-scsi-pci"
                 " -device scsi-hd,drive=drive0,id=dev0");
 
diff --git a/tests/nvme-test.c b/tests/nvme-test.c
index c8bece4..7674a44 100644
--- a/tests/nvme-test.c
+++ b/tests/nvme-test.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/nvme/nop", nop);
 
-    qtest_start("-drive id=drv0,if=none,file=/dev/null,format=raw "
+    qtest_start("-drive id=drv0,if=none,file=null-co://,format=raw "
                 "-device nvme,drive=drv0,serial=foo");
     ret = g_test_run();
 
diff --git a/tests/usb-hcd-uhci-test.c b/tests/usb-hcd-uhci-test.c
index e956b9c..24c3ea9 100644
--- a/tests/usb-hcd-uhci-test.c
+++ b/tests/usb-hcd-uhci-test.c
@@ -78,7 +78,7 @@ int main(int argc, char **argv)
 {
     const char *arch = qtest_get_arch();
     const char *cmd = "-device piix3-usb-uhci,id=uhci,addr=1d.0"
-                      " -drive id=drive0,if=none,file=/dev/null,format=raw"
+                      " -drive id=drive0,if=none,file=null-co://,format=raw"
                       " -device usb-tablet,bus=uhci.0,port=1";
     int ret;
 
diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
index 22513e9..031764d 100644
--- a/tests/usb-hcd-xhci-test.c
+++ b/tests/usb-hcd-xhci-test.c
@@ -89,7 +89,7 @@ int main(int argc, char **argv)
     qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);
 
     qtest_start("-device nec-usb-xhci,id=xhci"
-                " -drive id=drive0,if=none,file=/dev/null,format=raw");
+                " -drive id=drive0,if=none,file=null-co://,format=raw");
     ret = g_test_run();
     qtest_end();
 
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 0e32e41..0fc7c99 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -63,7 +63,7 @@ static QOSState *pci_test_start(void)
     const char *arch = qtest_get_arch();
     char *tmp_path;
     const char *cmd = "-drive if=none,id=drive0,file=%s,format=raw "
-                      "-drive if=none,id=drive1,file=/dev/null,format=raw "
+                      "-drive if=none,id=drive1,file=null-co://,format=raw "
                       "-device virtio-blk-pci,id=drv0,drive=drive0,"
                       "addr=%x.%x";
 
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 69220ef..8c27641 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -35,7 +35,7 @@ typedef struct {
 static QOSState *qvirtio_scsi_start(const char *extra_opts)
 {
     const char *arch = qtest_get_arch();
-    const char *cmd = "-drive id=drv0,if=none,file=/dev/null,format=raw "
+    const char *cmd = "-drive id=drv0,if=none,file=null-co://,format=raw "
                       "-device virtio-scsi-pci,id=vs0 "
                       "-device scsi-hd,bus=vs0.0,drive=drv0 %s";
 
@@ -195,7 +195,7 @@ static void hotplug(void)
     QDict *response;
     QOSState *qs;
 
-    qs = qvirtio_scsi_start("-drive id=drv1,if=none,file=/dev/null,format=raw");
+    qs = qvirtio_scsi_start("-drive id=drv1,if=none,file=null-co://,format=raw");
     response = qmp("{\"execute\": \"device_add\","
                    " \"arguments\": {"
                    "   \"driver\": \"scsi-hd\","
-- 
2.9.3
