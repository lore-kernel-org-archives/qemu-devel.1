Received: from eggs.gnu.org ([2001:4830:134:3::10]:57909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fQyGu-0003Ob-E1
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fQyGp-0005uD-Pq
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:00:24 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  7 Jun 2018 17:59:54 +0100
Message-Id: <20180607165955.10232-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180607165955.10232-1-mark.cave-ayland@ilande.co.uk>
References: <20180607165955.10232-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/3] ppc: remove obsolete macio_init()
 definition from mac.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Commits b6712ea391 removed the macio_init() function but missed the header
prototype in mac.h. Remove it since it is no longer needed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index dac96317af..89fa8bbed7 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -91,9 +91,6 @@ typedef struct MACIOIDEState {
 void macio_ide_init_drives(MACIOIDEState *ide, DriveInfo **hd_table);
 void macio_ide_register_dma(MACIOIDEState *ide);
 
-void macio_init(PCIDevice *dev,
-                MemoryRegion *pic_mem);
-
 /* Grackle PCI */
 #define TYPE_GRACKLE_PCI_HOST_BRIDGE "grackle-pcihost"
 
-- 
2.11.0
