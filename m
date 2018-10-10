Received: from eggs.gnu.org ([2001:4830:134:3::10]:57905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAMQg-00018j-Mu
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAMQe-000183-9b
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:54:06 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:38138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAMQd-00017a-SH
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:54:04 -0400
Received: by mail-wm1-x329.google.com with SMTP id 193-v6so7245006wme.3
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 14:54:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 10 Oct 2018 23:53:53 +0200
Message-Id: <20181010215355.16221-2-f4bug@amsat.org>
In-Reply-To: <20181010215355.16221-1-f4bug@amsat.org>
References: <20181010215355.16221-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/3] hw/pci-bridge/xio3130: Remove unused
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Isaku Yamahata <yamahata@valinux.co.jp>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Introduced in 48ebf2f90f8 and faf1e708d5b, these functions
were never used. Remove them.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-bridge/xio3130_downstream.h | 11 -----------
 hw/pci-bridge/xio3130_upstream.h   | 10 ----------
 hw/pci-bridge/xio3130_downstream.c | 28 +---------------------------
 hw/pci-bridge/xio3130_upstream.c   | 24 +-----------------------
 4 files changed, 2 insertions(+), 71 deletions(-)
 delete mode 100644 hw/pci-bridge/xio3130_downstream.h
 delete mode 100644 hw/pci-bridge/xio3130_upstream.h

diff --git a/hw/pci-bridge/xio3130_downstream.h b/hw/pci-bridge/xio3130_downstream.h
deleted file mode 100644
index 8426d9ffa6..0000000000
--- a/hw/pci-bridge/xio3130_downstream.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef QEMU_XIO3130_DOWNSTREAM_H
-#define QEMU_XIO3130_DOWNSTREAM_H
-
-#include "hw/pci/pcie_port.h"
-
-PCIESlot *xio3130_downstream_init(PCIBus *bus, int devfn, bool multifunction,
-                                  const char *bus_name, pci_map_irq_fn map_irq,
-                                  uint8_t port, uint8_t chassis,
-                                  uint16_t slot);
-
-#endif /* QEMU_XIO3130_DOWNSTREAM_H */
diff --git a/hw/pci-bridge/xio3130_upstream.h b/hw/pci-bridge/xio3130_upstream.h
deleted file mode 100644
index d0ab7577e2..0000000000
--- a/hw/pci-bridge/xio3130_upstream.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef QEMU_XIO3130_UPSTREAM_H
-#define QEMU_XIO3130_UPSTREAM_H
-
-#include "hw/pci/pcie_port.h"
-
-PCIEPort *xio3130_upstream_init(PCIBus *bus, int devfn, bool multifunction,
-                                const char *bus_name, pci_map_irq_fn map_irq,
-                                uint8_t port);
-
-#endif /* QEMU_XIO3130_UPSTREAM_H */
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index b202657954..467bbabe4c 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -23,7 +23,7 @@
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
-#include "xio3130_downstream.h"
+#include "hw/pci/pcie_port.h"
 #include "qapi/error.h"
 
 #define PCI_DEVICE_ID_TI_XIO3130D       0x8233  /* downstream port */
@@ -127,32 +127,6 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
     pci_bridge_exitfn(d);
 }
 
-PCIESlot *xio3130_downstream_init(PCIBus *bus, int devfn, bool multifunction,
-                                  const char *bus_name, pci_map_irq_fn map_irq,
-                                  uint8_t port, uint8_t chassis,
-                                  uint16_t slot)
-{
-    PCIDevice *d;
-    PCIBridge *br;
-    DeviceState *qdev;
-
-    d = pci_create_multifunction(bus, devfn, multifunction,
-                                 "xio3130-downstream");
-    if (!d) {
-        return NULL;
-    }
-    br = PCI_BRIDGE(d);
-
-    qdev = DEVICE(d);
-    pci_bridge_map_irq(br, bus_name, map_irq);
-    qdev_prop_set_uint8(qdev, "port", port);
-    qdev_prop_set_uint8(qdev, "chassis", chassis);
-    qdev_prop_set_uint16(qdev, "slot", slot);
-    qdev_init_nofail(qdev);
-
-    return PCIE_SLOT(d);
-}
-
 static Property xio3130_downstream_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index bca2f9a5ea..b524908cf1 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -23,7 +23,7 @@
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
-#include "xio3130_upstream.h"
+#include "hw/pci/pcie_port.h"
 
 #define PCI_DEVICE_ID_TI_XIO3130U       0x8232  /* upstream port */
 #define XIO3130_REVISION                0x2
@@ -108,28 +108,6 @@ static void xio3130_upstream_exitfn(PCIDevice *d)
     pci_bridge_exitfn(d);
 }
 
-PCIEPort *xio3130_upstream_init(PCIBus *bus, int devfn, bool multifunction,
-                             const char *bus_name, pci_map_irq_fn map_irq,
-                             uint8_t port)
-{
-    PCIDevice *d;
-    PCIBridge *br;
-    DeviceState *qdev;
-
-    d = pci_create_multifunction(bus, devfn, multifunction, "x3130-upstream");
-    if (!d) {
-        return NULL;
-    }
-    br = PCI_BRIDGE(d);
-
-    qdev = DEVICE(d);
-    pci_bridge_map_irq(br, bus_name, map_irq);
-    qdev_prop_set_uint8(qdev, "port", port);
-    qdev_init_nofail(qdev);
-
-    return PCIE_PORT(d);
-}
-
 static const VMStateDescription vmstate_xio3130_upstream = {
     .name = "xio3130-express-upstream-port",
     .priority = MIG_PRI_PCI_BUS,
-- 
2.19.1
