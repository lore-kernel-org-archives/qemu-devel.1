Received: from eggs.gnu.org ([2001:4830:134:3::10]:46398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJg0K-0008JM-M0
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 09:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJg0J-0002d3-UC
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 09:00:36 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33407
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dJg0J-0002cz-NA
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 09:00:35 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 10 Jun 2017 14:00:16 +0100
Message-Id: <1497099616-2615-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1497099616-2615-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1497099616-2615-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/3] sun4u: expose NVRAM on ebus PCI IO address
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

To allow future changes to the sun4u PCI topology.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 19e64be..bf738f8 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -492,7 +492,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     /* Map NVRAM into I/O (ebus) space */
     nvram = m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
     s = SYS_BUS_DEVICE(nvram);
-    memory_region_add_subregion(get_system_io(), 0x2000,
+    memory_region_add_subregion(pci_address_space_io(ebus), 0x2000,
                                 sysbus_mmio_get_region(s, 0));
  
     initrd_size = 0;
-- 
1.7.10.4
