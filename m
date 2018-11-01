Received: from eggs.gnu.org ([2001:4830:134:3::10]:59434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIA9g-0004sa-F9
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gIA9Y-00039q-OW
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:61529)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gIA9Y-00034o-8P
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:24:40 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Thu,  1 Nov 2018 11:22:48 +0100
Message-Id: <20181101102303.16439-9-sameo@linux.intel.com>
In-Reply-To: <20181101102303.16439-1-sameo@linux.intel.com>
References: <20181101102303.16439-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 08/23] hw: i386: Move PCI host definitions
 to pci_host.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

The PCI hole properties are not pc or i386 specific. They belong to the
PCI host header instead.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 include/hw/i386/pc.h      | 5 -----
 include/hw/pci/pci_host.h | 6 ++++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index da0bd39741..2d648d77c8 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -182,11 +182,6 @@ void pc_acpi_init(const char *default_dsdt);
 
 void pc_guest_info_init(PCMachineState *pcms);
 
-#define PCI_HOST_PROP_PCI_HOLE_START   "pci-hole-start"
-#define PCI_HOST_PROP_PCI_HOLE_END     "pci-hole-end"
-#define PCI_HOST_PROP_PCI_HOLE64_START "pci-hole64-start"
-#define PCI_HOST_PROP_PCI_HOLE64_END   "pci-hole64-end"
-#define PCI_HOST_PROP_PCI_HOLE64_SIZE  "pci-hole64-size"
 #define PCI_HOST_BELOW_4G_MEM_SIZE     "below-4g-mem-size"
 #define PCI_HOST_ABOVE_4G_MEM_SIZE     "above-4g-mem-size"
 
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index ba31595fc7..e343f4d9ca 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -38,6 +38,12 @@
 #define PCI_HOST_BRIDGE_GET_CLASS(obj) \
      OBJECT_GET_CLASS(PCIHostBridgeClass, (obj), TYPE_PCI_HOST_BRIDGE)
 
+#define PCI_HOST_PROP_PCI_HOLE_START   "pci-hole-start"
+#define PCI_HOST_PROP_PCI_HOLE_END     "pci-hole-end"
+#define PCI_HOST_PROP_PCI_HOLE64_START "pci-hole64-start"
+#define PCI_HOST_PROP_PCI_HOLE64_END   "pci-hole64-end"
+#define PCI_HOST_PROP_PCI_HOLE64_SIZE  "pci-hole64-size"
+
 struct PCIHostState {
     SysBusDevice busdev;
 
-- 
2.19.1
