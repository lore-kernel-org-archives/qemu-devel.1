Received: from eggs.gnu.org ([2001:4830:134:3::10]:60698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07ab-000775-Tj
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aa-0003ia-5h
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:02:01 -0400
Received: from m12-15.163.com ([220.181.12.15]:52844)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aZ-0003eD-Bq
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:02:00 -0400
From: Li Qiang <liq3ea@163.com>
Date: Wed, 12 Sep 2018 09:01:15 -0700
Message-Id: <20180912160118.21158-6-liq3ea@163.com>
In-Reply-To: <20180912160118.21158-1-liq3ea@163.com>
References: <20180912160118.21158-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 5/8] hw: designware: add read memory region
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, lersek@redhat.com, marcandre.lureau@gmail.com, ehabkost@redhat.com, mst@redhat.com, peter.maydell@linaro.org, ppandit@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/pci-host/designware.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 29ea313798..f5641b5c8c 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -57,6 +57,12 @@ designware_pcie_root_to_host(DesignwarePCIERoot *root)
     return DESIGNWARE_PCIE_HOST(bus->parent);
 }
 
+static uint64_t designware_pcie_root_msi_read(void *opaque, hwaddr addr,
+                                              unsigned size)
+{
+    return 0;
+}
+
 static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
                                            uint64_t val, unsigned len)
 {
@@ -71,6 +77,7 @@ static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
 }
 
 static const MemoryRegionOps designware_pci_host_msi_ops = {
+    .read = designware_pcie_root_msi_read,
     .write = designware_pcie_root_msi_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
-- 
2.17.1
