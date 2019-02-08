Received: from eggs.gnu.org ([209.51.188.92]:50603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gs9qw-0001vb-Mb
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:22:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gs9qv-0001Ke-L1
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:22:14 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  8 Feb 2019 17:22:01 +0000
Message-Id: <20190208172201.29001-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] mac_newworld: change default NIC to sungem for
 mac99 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, hsp.cat7@gmail.com

This model brings out-of-the-box networking for all of Linux, MacOS 9 and OS X
without requiring the installation of additional drivers.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac_newworld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 10be728c37..98461052ac 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -432,7 +432,7 @@ static void ppc_core99_init(MachineState *machine)
     }
 
     for (i = 0; i < nb_nics; i++) {
-        pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
+        pci_nic_init_nofail(&nd_table[i], pci_bus, "sungem", NULL);
     }
 
     /* The NewWorld NVRAM is not located in the MacIO device */
-- 
2.11.0
