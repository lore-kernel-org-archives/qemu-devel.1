Received: from eggs.gnu.org ([2001:4830:134:3::10]:37249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGchU-0001e3-MC
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGchU-0006Rj-01
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:24:48 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 19 Nov 2017 21:24:11 -0600
Message-Id: <20171120032420.9134-4-mdavidsaver@gmail.com>
In-Reply-To: <20171120032420.9134-1-mdavidsaver@gmail.com>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 03/12] e500: note possible bug with host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/pci-host/ppce500.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index f2d108bc8a..0e2833bd98 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -424,6 +424,9 @@ static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
     MemoryRegion *ccsr_mr = sysbus_mmio_get_region(ccsr, 0);
 
     pci_config_set_class(d->config, PCI_CLASS_BRIDGE_PCI);
+    /* BUG? identifies as PCI_HEADER_TYPE_BRIDGE but uses
+     * standard device config read/write
+     */
     d->config[PCI_HEADER_TYPE] =
         (d->config[PCI_HEADER_TYPE] & PCI_HEADER_TYPE_MULTI_FUNCTION) |
         PCI_HEADER_TYPE_BRIDGE;
-- 
2.11.0
