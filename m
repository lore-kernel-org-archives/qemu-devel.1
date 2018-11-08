Received: from eggs.gnu.org ([2001:4830:134:3::10]:44777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gKjJg-0000g9-Mp
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:21:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gKjJa-0006iO-5c
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:21:43 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:55549)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gKjJU-0006cK-UL
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:21:33 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Thu,  8 Nov 2018 20:21:02 +0800
Message-Id: <20181108122102.9915-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH] pci_bridge: fix a typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel.apfelbaum@gmail.com, mst@redhat.com, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 hw/pci/pci_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index ee9dff2d3a..da8daa3ff2 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -310,7 +310,7 @@ void pci_bridge_reset(DeviceState *qdev)
 
     /*
      * the default values for base/limit registers aren't specified
-     * in the PCI-to-PCI-bridge spec. So we don't thouch them here.
+     * in the PCI-to-PCI-bridge spec. So we don't touch them here.
      * Each implementation can override it.
      * typical implementation does
      * zero base/limit registers or
-- 
2.17.1
