Received: from eggs.gnu.org ([2001:4830:134:3::10]:58241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Matt.Redfearn@imgtec.com>) id 1dhd5c-0006oW-GU
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Matt.Redfearn@imgtec.com>) id 1dhd5X-00051o-Ho
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:45:04 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:60947)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Matt.Redfearn@imgtec.com>) id 1dhd5X-0004zJ-BT
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:44:59 -0400
From: Matt Redfearn <matt.redfearn@imgtec.com>
Date: Tue, 15 Aug 2017 15:44:17 +0100
Message-ID: <1502808257-17395-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] PCI: PCIe access should always be little endian
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Yongbok Kim <Yongbok.Kim@imgtec.com>, Matt Redfearn <matt.redfearn@imgtec.com>

PCIe busses are always little endian, so set the endianness of the
memory region to little endian rather than native such that operations
work as expected on big endian targets.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 hw/pci/pcie_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
index dcebf57ed45e..553db56778b6 100644
--- a/hw/pci/pcie_host.c
+++ b/hw/pci/pcie_host.c
@@ -81,7 +81,7 @@ static uint64_t pcie_mmcfg_data_read(void *opaque,
 static const MemoryRegionOps pcie_mmcfg_ops = {
     .read = pcie_mmcfg_data_read,
     .write = pcie_mmcfg_data_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void pcie_host_init(Object *obj)
-- 
2.7.4
