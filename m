Received: from eggs.gnu.org ([2001:4830:134:3::10]:35359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fQx01-0007wW-Ka
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fQx00-00045r-7o
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:38:53 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Thu, 7 Jun 2018 18:38:11 +0300
Message-ID: <1528385894-19434-8-git-send-email-ari@tuxera.com>
In-Reply-To: <1528385894-19434-1-git-send-email-ari@tuxera.com>
References: <1528385894-19434-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 07/10] hw/block/nvme: Always apply block
 configuration to block driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ari Sundholm <ari@tuxera.com>, Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:nvme" <qemu-block@nongnu.org>

This allows the block driver to use the block configuration of the new
NVMe device. One use for this information is to set request limits
using this information.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 hw/block/nvme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 811084b..3b00dff 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1225,6 +1225,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
                                        false, errp)) {
         return;
     }
+    blkconf_apply_to_blkdrv(&n->conf);
 
     pci_conf = pci_dev->config;
     pci_conf[PCI_INTERRUPT_PIN] = 1;
-- 
2.7.4
