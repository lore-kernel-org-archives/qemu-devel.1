Received: from eggs.gnu.org ([2001:4830:134:3::10]:51199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNS1-0006TG-Sa
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNS1-00028r-0y
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:13 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNS0-000287-SJ
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:12 -0500
Received: by mail-qt0-x244.google.com with SMTP id 33so12077970qtv.1
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:46:12 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:31 -0300
Message-Id: <20180108024558.17983-3-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/29] pci/pci_host: move generic definitions
 out of i386/pc.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i386/pc.h      | 9 ---------
 include/hw/pci/pci_host.h | 8 ++++++++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6f77eb0665..780fa049d7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -218,15 +218,6 @@ void pc_acpi_init(const char *default_dsdt);
 
 void pc_guest_info_init(PCMachineState *pcms);
 
-#define PCI_HOST_PROP_PCI_HOLE_START   "pci-hole-start"
-#define PCI_HOST_PROP_PCI_HOLE_END     "pci-hole-end"
-#define PCI_HOST_PROP_PCI_HOLE64_START "pci-hole64-start"
-#define PCI_HOST_PROP_PCI_HOLE64_END   "pci-hole64-end"
-#define PCI_HOST_PROP_PCI_HOLE64_SIZE  "pci-hole64-size"
-#define PCI_HOST_BELOW_4G_MEM_SIZE     "below-4g-mem-size"
-#define PCI_HOST_ABOVE_4G_MEM_SIZE     "above-4g-mem-size"
-
-
 void pc_pci_as_mapping_init(Object *owner, MemoryRegion *system_memory,
                             MemoryRegion *pci_address_space);
 
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index ba31595fc7..5239adf7e6 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -56,6 +56,14 @@ typedef struct PCIHostBridgeClass {
     const char *(*root_bus_path)(PCIHostState *, PCIBus *);
 } PCIHostBridgeClass;
 
+#define PCI_HOST_PROP_PCI_HOLE_START   "pci-hole-start"
+#define PCI_HOST_PROP_PCI_HOLE_END     "pci-hole-end"
+#define PCI_HOST_PROP_PCI_HOLE64_START "pci-hole64-start"
+#define PCI_HOST_PROP_PCI_HOLE64_END   "pci-hole64-end"
+#define PCI_HOST_PROP_PCI_HOLE64_SIZE  "pci-hole64-size"
+#define PCI_HOST_BELOW_4G_MEM_SIZE     "below-4g-mem-size"
+#define PCI_HOST_ABOVE_4G_MEM_SIZE     "above-4g-mem-size"
+
 /* common internal helpers for PCI/PCIe hosts, cut off overflows */
 void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
                                   uint32_t limit, uint32_t val, uint32_t len);
-- 
2.15.1
