Received: from eggs.gnu.org ([209.51.188.92]:41307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goq2u-0004EB-G1
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goq2s-0007MA-Jk
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:36:52 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 30 Jan 2019 14:36:39 +0100
Message-Id: <1548855399-31273-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/ppc/spapr: Add support for "-vga cirrus"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org

The cirrus VGA card has been enabled in the PPC builds with
commit 29f9cef39eb1ae55e82c ("ppc: Include vga cirrus card into
the compiling process") last year. It also works on the pseries
machine, even SLOF contains support for this card, so we can
also support this for the "-vga" parameter here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/spapr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 71fe552..2323974 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1717,6 +1717,7 @@ static bool spapr_vga_init(PCIBus *pci_bus, Error **errp)
         return true;
     case VGA_STD:
     case VGA_VIRTIO:
+    case VGA_CIRRUS:
         return pci_vga_init(pci_bus) != NULL;
     default:
         error_setg(errp,
-- 
1.8.3.1
