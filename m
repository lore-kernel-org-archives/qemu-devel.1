Received: from eggs.gnu.org ([2001:4830:134:3::10]:59248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZx-0001Uw-1L
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZv-000218-UE
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:09 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:20:42 +1000
Message-Id: <20180427092126.24812-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/49] uninorth: move uninorth definitions into
 uninorth.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
[dwg: Added hw/hw.h #include as suggested by Philippe Mathieu-Daud=C3=A9]
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-host/uninorth.c         | 22 +-----------------
 include/hw/pci-host/uninorth.h | 51 ++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 52 insertions(+), 21 deletions(-)
 create mode 100644 include/hw/pci-host/uninorth.h

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 1d4d3f5705..600d675573 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -26,31 +26,11 @@
 #include "hw/ppc/mac.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
+#include "hw/pci-host/uninorth.h"
 #include "trace.h"
=20
 static const int unin_irq_line[] =3D { 0x1b, 0x1c, 0x1d, 0x1e };
=20
-#define TYPE_UNI_NORTH_PCI_HOST_BRIDGE "uni-north-pci-pcihost"
-#define TYPE_UNI_NORTH_AGP_HOST_BRIDGE "uni-north-agp-pcihost"
-#define TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE "uni-north-internal-pci-=
pcihost"
-#define TYPE_U3_AGP_HOST_BRIDGE "u3-agp-pcihost"
-
-#define UNI_NORTH_PCI_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_PCI_HOST_BRIDGE)
-#define UNI_NORTH_AGP_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_AGP_HOST_BRIDGE)
-#define UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRID=
GE)
-#define U3_AGP_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(UNINState, (obj), TYPE_U3_AGP_HOST_BRIDGE)
-
-typedef struct UNINState {
-    PCIHostState parent_obj;
-
-    MemoryRegion pci_mmio;
-    MemoryRegion pci_hole;
-} UNINState;
-
 static int pci_unin_map_irq(PCIDevice *pci_dev, int irq_num)
 {
     return (irq_num + (pci_dev->devfn >> 3)) & 3;
diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninort=
h.h
new file mode 100644
index 0000000000..0366376a3b
--- /dev/null
+++ b/include/hw/pci-host/uninorth.h
@@ -0,0 +1,51 @@
+/*
+ * QEMU Uninorth PCI host (for all Mac99 and newer machines)
+ *
+ * Copyright (c) 2006 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+
+#ifndef UNINORTH_H
+#define UNINORTH_H
+
+#include "hw/hw.h"
+
+#define TYPE_UNI_NORTH_PCI_HOST_BRIDGE "uni-north-pci-pcihost"
+#define TYPE_UNI_NORTH_AGP_HOST_BRIDGE "uni-north-agp-pcihost"
+#define TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE "uni-north-internal-pci-=
pcihost"
+#define TYPE_U3_AGP_HOST_BRIDGE "u3-agp-pcihost"
+
+#define UNI_NORTH_PCI_HOST_BRIDGE(obj) \
+    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_PCI_HOST_BRIDGE)
+#define UNI_NORTH_AGP_HOST_BRIDGE(obj) \
+    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_AGP_HOST_BRIDGE)
+#define UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE(obj) \
+    OBJECT_CHECK(UNINState, (obj), TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRID=
GE)
+#define U3_AGP_HOST_BRIDGE(obj) \
+    OBJECT_CHECK(UNINState, (obj), TYPE_U3_AGP_HOST_BRIDGE)
+
+typedef struct UNINState {
+    PCIHostState parent_obj;
+
+    MemoryRegion pci_mmio;
+    MemoryRegion pci_hole;
+} UNINState;
+
+#endif /* UNINORTH_H */
--=20
2.14.3
