Received: from eggs.gnu.org ([2001:4830:134:3::10]:32836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritQ-0005xG-LV
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fritP-0002aK-4T
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:02:44 -0400
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon, 20 Aug 2018 14:02:09 +0200
Message-Id: <20180820120213.11095-13-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
References: <20180820120213.11095-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH 12/16] test/qgraph: usb-hcd-ohci test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Keith Busch <keith.busch@intel.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Convert tests/usb-hcd-ohci-test in qgraph test node,
usb-hcd-ohci-test. Since it's a nop test, node creation and
initialization is made in the same file.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/Makefile.include    |  4 +---
 tests/usb-hcd-ohci-test.c | 46 +++++++++++++++++++++++++++++----------
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5b006b85d1..e60890adb9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -268,7 +268,6 @@ check-qtest-i386-y += tests/i82801b11-test$(EXESUF)
 gcov-files-i386-y += hw/pci-bridge/i82801b11.c
 check-qtest-i386-y += tests/ioh3420-test$(EXESUF)
 gcov-files-i386-y += hw/pci-bridge/ioh3420.c
-check-qtest-i386-y += tests/usb-hcd-ohci-test$(EXESUF)
 gcov-files-i386-y += hw/usb/hcd-ohci.c
 check-qtest-i386-y += tests/usb-hcd-uhci-test$(EXESUF)
 gcov-files-i386-y += hw/usb/hcd-uhci.c
@@ -331,7 +330,6 @@ check-qtest-ppc64-y += tests/pnv-xscom-test$(EXESUF)
 check-qtest-ppc64-y += tests/migration-test$(EXESUF)
 check-qtest-ppc64-y += tests/rtas-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
-check-qtest-ppc64-y += tests/usb-hcd-ohci-test$(EXESUF)
 gcov-files-ppc64-y += hw/usb/hcd-ohci.c
 check-qtest-ppc64-y += tests/usb-hcd-uhci-test$(EXESUF)
 gcov-files-ppc64-y += hw/usb/hcd-uhci.c
@@ -793,6 +791,7 @@ libqgraph-tests-obj-y += tests/ne2000-test.o
 libqgraph-tests-obj-y += tests/nvme-test.o
 libqgraph-tests-obj-y += tests/pcnet-test.o
 libqgraph-tests-obj-y += tests/spapr-phb-test.o
+libqgraph-tests-obj-y += tests/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
@@ -844,7 +843,6 @@ tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
 tests/es1370-test$(EXESUF): tests/es1370-test.o
 tests/intel-hda-test$(EXESUF): tests/intel-hda-test.o
 tests/ioh3420-test$(EXESUF): tests/ioh3420-test.o
-tests/usb-hcd-ohci-test$(EXESUF): tests/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
 tests/usb-hcd-uhci-test$(EXESUF): tests/usb-hcd-uhci-test.o $(libqos-usb-obj-y)
 tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-test.o $(libqos-usb-obj-y)
 tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb-obj-y)
diff --git a/tests/usb-hcd-ohci-test.c b/tests/usb-hcd-ohci-test.c
index 4758813d78..9796c1e02d 100644
--- a/tests/usb-hcd-ohci-test.c
+++ b/tests/usb-hcd-ohci-test.c
@@ -10,30 +10,52 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "libqos/usb.h"
+#include "libqos/qgraph.h"
 
+typedef struct QOhci_pci QOhci_pci;
 
-static void test_ohci_init(void)
-{
+struct QOhci_pci {
+    QOSGraphObject obj;
+};
 
+/* Tests only initialization so far. TODO: Replace with functional tests */
+static void test_ohci_init(void *obj, void *data, QGuestAllocator *alloc)
+{
 }
 
-static void test_ohci_hotplug(void)
+static void test_ohci_hotplug(void *obj, void *data, QGuestAllocator *alloc)
 {
     usb_test_hotplug("ohci", 1, NULL);
 }
 
-int main(int argc, char **argv)
+static void ohci_pci_destructor(QOSGraphObject *obj)
+{
+    QOhci_pci *ohci_pci = (QOhci_pci *)obj;
+    g_free(ohci_pci);
+}
+
+static void *ohci_pci_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
 {
-    int ret;
+    QOhci_pci *ohci_pci = g_new0(QOhci_pci, 1);
+    ohci_pci->obj.destructor = ohci_pci_destructor;
 
-    g_test_init(&argc, &argv, NULL);
+    return &ohci_pci->obj;
+}
 
-    qtest_add_func("/ohci/pci/init", test_ohci_init);
-    qtest_add_func("/ohci/pci/hotplug", test_ohci_hotplug);
+static void ohci_pci_register_nodes(void)
+{
+    qos_node_create_driver("pci-ohci", ohci_pci_create);
+    qos_node_consumes("pci-ohci", "pci-bus", &(QOSGraphEdgeOptions) {
+        .extra_device_opts = "id=ohci",
+    });
+}
 
-    qtest_start("-device pci-ohci,id=ohci");
-    ret = g_test_run();
-    qtest_end();
+libqos_init(ohci_pci_register_nodes);
 
-    return ret;
+static void register_ohci_pci_test(void)
+{
+    qos_add_test("ohci_pci-test-nop", "pci-ohci", test_ohci_init, NULL);
+    qos_add_test("ohci_pci-test-hotplug", "pci-ohci", test_ohci_hotplug, NULL);
 }
+
+libqos_init(register_ohci_pci_test);
-- 
2.17.1
