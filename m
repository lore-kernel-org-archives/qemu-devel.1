Received: from eggs.gnu.org ([2001:4830:134:3::10]:35784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgbD-00059z-Ey
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgb9-0000yp-Gy
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:07 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:36093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fmgb9-0000y9-9Z
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:35:03 -0400
Received: by mail-ed1-x52f.google.com with SMTP id k15-v6so5262899edr.3
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:35:03 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  6 Aug 2018 16:33:59 +0200
Message-Id: <20180806143412.27722-22-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH v2 21/34] test/qgraph: virtio-serial test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Convert tests/virtio-serial-test in qgraph test node,
virtio-serial-test. This test consumes a virtio-serial interface
and checks that its function return the expected values.

Note that this test does not allocate any virtio-serial structure,
it's all done by the qtest walking graph mechanism

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include     |  4 +---
 tests/virtio-serial-test.c | 27 +++++++++------------------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6742f97058..f258a7778e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -205,7 +205,6 @@ check-qtest-virtio-y += tests/virtio-9p-test$(EXESUF)
 gcov-files-virtio-y += hw/9pfs/virtio-9p.c
 gcov-files-virtio-y += i386-softmmu/hw/9pfs/virtio-9p-device.c
 endif
-check-qtest-virtio-y += tests/virtio-serial-test$(EXESUF)
 gcov-files-virtio-y += i386-softmmu/hw/char/virtio-serial-bus.c
 check-qtest-virtio-y += $(check-qtest-virtioserial-y)
 gcov-files-virtio-y += $(gcov-files-virtioserial-y)
@@ -398,7 +397,6 @@ check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
 check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-ccw-test$(EXESUF)
 check-qtest-s390x-y += tests/virtio-balloon-test$(EXESUF)
-check-qtest-s390x-y += tests/virtio-serial-test$(EXESUF)
 check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
 
 check-qtest-generic-y += tests/machine-none-test$(EXESUF)
@@ -782,6 +780,7 @@ libqgraph-pci-obj-y += tests/libqos/e1000e.o
 libqgraph-tests-obj-y = $(libqgraph-pci-obj-y)
 libqgraph-tests-obj-y += tests/sdhci-test.o
 libqgraph-tests-obj-y += tests/e1000e-test.o
+libqgraph-tests-obj-y += tests/virtio-serial-test.o
 libqgraph-tests-obj-y += tests/virtio-console-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
@@ -832,7 +831,6 @@ tests/virtio-net-test$(EXESUF): tests/virtio-net-test.o $(libqos-pc-obj-y) $(lib
 tests/virtio-rng-test$(EXESUF): tests/virtio-rng-test.o $(libqos-pc-obj-y)
 tests/virtio-scsi-test$(EXESUF): tests/virtio-scsi-test.o $(libqos-virtio-obj-y)
 tests/virtio-9p-test$(EXESUF): tests/virtio-9p-test.o $(libqos-virtio-obj-y)
-tests/virtio-serial-test$(EXESUF): tests/virtio-serial-test.o $(libqos-virtio-obj-y)
 tests/tpci200-test$(EXESUF): tests/tpci200-test.o
 tests/display-vga-test$(EXESUF): tests/display-vga-test.o
 tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
diff --git a/tests/virtio-serial-test.c b/tests/virtio-serial-test.c
index 7cc7060264..1691811f85 100644
--- a/tests/virtio-serial-test.c
+++ b/tests/virtio-serial-test.c
@@ -9,33 +9,24 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/virtio.h"
+#include "libqos/virtio-serial.h"
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
-static void virtio_serial_nop(void)
+static void virtio_serial_nop(void *obj, void *data, QGuestAllocator *alloc)
 {
+    /* no operation */
 }
 
-static void hotplug(void)
+static void serial_hotplug(void *obj, void *data, QGuestAllocator *alloc)
 {
     qtest_qmp_device_add("virtserialport", "hp-port", NULL);
-
     qtest_qmp_device_del("hp-port");
 }
 
-int main(int argc, char **argv)
+static void virtio_serial_test(void)
 {
-    int ret;
-
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/virtio/serial/nop", virtio_serial_nop);
-    qtest_add_func("/virtio/serial/hotplug", hotplug);
-
-    global_qtest = qtest_startf("-device virtio-serial-%s",
-                                qvirtio_get_dev_type());
-    ret = g_test_run();
-
-    qtest_end();
-
-    return ret;
+    qos_add_test("serial-nop", "virtio-serial", virtio_serial_nop, NULL);
+    qos_add_test("serial-hotplug", "virtio-serial", serial_hotplug, NULL);
 }
+
+libqos_init(virtio_serial_test);
-- 
2.17.1
