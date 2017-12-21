Received: from eggs.gnu.org ([2001:4830:134:3::10]:53553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRwBS-0008OR-Pt
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eRwBR-0007aG-Ur
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:26:30 -0500
Received: from chuckie.co.uk ([82.165.15.123]:43150
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eRwBR-0007ZF-Oh
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:26:29 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 21 Dec 2017 08:20:43 +0000
Message-Id: <20171221082045.14022-15-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
References: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv3 14/16] apb: replace OBIO interrupt numbers in
 pci_pbmA_map_irq() with constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

Following on from the previous commit, we can also do the same with
with legacy OBIO interrupts in pci_pbmA_map_irq().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/apb.c         | 4 ++--
 include/hw/pci-host/apb.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index cb24bb2108..d043193c44 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -523,10 +523,10 @@ static int pci_pbmA_map_irq(PCIDevice *pci_dev, int irq_num)
     switch (PCI_SLOT(pci_dev->devfn)) {
     case 1:
         /* Onboard NIC */
-        return 0x21;
+        return OBIO_NIC_IRQ;
     case 3:
         /* Onboard IDE */
-        return 0x20;
+        return OBIO_HDD_IRQ;
     default:
         /* Normal intno, fall through */
         break;
diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
index 09ebd53f60..6194c8cbad 100644
--- a/include/hw/pci-host/apb.h
+++ b/include/hw/pci-host/apb.h
@@ -53,6 +53,8 @@ typedef struct IOMMUState {
 #define MAX_IVEC 0x40
 
 /* OBIO IVEC IRQs */
+#define OBIO_HDD_IRQ         0x20
+#define OBIO_NIC_IRQ         0x21
 #define OBIO_LPT_IRQ         0x22
 #define OBIO_FDD_IRQ         0x27
 #define OBIO_KBD_IRQ         0x29
-- 
2.11.0
