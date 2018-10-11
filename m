Received: from eggs.gnu.org ([2001:4830:134:3::10]:35179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAWHp-00081C-Kx
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAWHo-00073v-VU
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 04:25:37 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Thu, 11 Oct 2018 16:25:08 +0800
Message-Id: <20181011082508.29014-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH] pci_bridge: fix typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 hw/pci/pci_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 90f7208856..da8daa3ff2 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -399,7 +399,7 @@ void pci_bridge_exitfn(PCIDevice *pci_dev)
 
 /*
  * before qdev initialization(qdev_init()), this function sets bus_name and
- * map_irq callback which are necessry for pci_bridge_initfn() to
+ * map_irq callback which are necessary for pci_bridge_initfn() to
  * initialize bus.
  */
 void pci_bridge_map_irq(PCIBridge *br, const char* bus_name,
-- 
2.17.1
