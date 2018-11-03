Received: from eggs.gnu.org ([2001:4830:134:3::10]:51142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gIy3F-0007p9-51
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 11:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gIy39-0001iK-CU
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 11:41:27 -0400
Received: from m12-11.163.com ([220.181.12.11]:47946)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gIy35-0001Fv-UL
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 11:41:21 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sat,  3 Nov 2018 08:41:04 -0700
Message-Id: <20181103154104.69228-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] hw: virtio-pci: drop DO_UPCAST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Use VIRTIO_PCI MACRO instead.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/virtio/virtio-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index a954799267..277dc20c81 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -597,7 +597,7 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwaddr addr,
 static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
                                 uint32_t val, int len)
 {
-    VirtIOPCIProxy *proxy = DO_UPCAST(VirtIOPCIProxy, pci_dev, pci_dev);
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
     struct virtio_pci_cfg_cap *cfg;
 
@@ -630,7 +630,7 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
 static uint32_t virtio_read_config(PCIDevice *pci_dev,
                                    uint32_t address, int len)
 {
-    VirtIOPCIProxy *proxy = DO_UPCAST(VirtIOPCIProxy, pci_dev, pci_dev);
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
     struct virtio_pci_cfg_cap *cfg;
 
     if (proxy->config_cap &&
-- 
2.17.1
