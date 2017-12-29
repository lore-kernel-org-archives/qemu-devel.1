Received: from eggs.gnu.org ([2001:4830:134:3::10]:39276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eUvg7-0000Dl-Ec
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eUvg6-0006HX-G4
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:31 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:38296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eUvg6-0006Bs-AO
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:30 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Fri, 29 Dec 2017 15:29:21 +0100
Message-Id: <20171229142922.31701-16-hpoussin@reactos.org>
In-Reply-To: <20171229142922.31701-1-hpoussin@reactos.org>
References: <20171229142922.31701-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 15/16] piix4: rename PIIX4 object to
 piix4-isa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Other piix4 parts are already named piix4-ide and piix4-usb-uhci.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/isa/piix4.c       | 1 -
 hw/mips/mips_malta.c | 2 +-
 include/hw/isa/isa.h | 3 +++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index c6691a6914..8e99087c21 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -52,7 +52,6 @@ typedef struct PIIX4State {
     uint8_t rcr;
 } PIIX4State;
 
-#define TYPE_PIIX4_PCI_DEVICE "PIIX4"
 #define PIIX4_PCI_DEVICE(obj) \
     OBJECT_CHECK(PIIX4State, (obj), TYPE_PIIX4_PCI_DEVICE)
 
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 3d304a6e0a..93ec013ea2 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1178,7 +1178,7 @@ void mips_malta_init(MachineState *machine)
     ide_drive_get(hd, ARRAY_SIZE(hd));
 
     pci = pci_create_multifunction(pci_bus, PCI_DEVFN(10, 0),
-                                   true, "PIIX4");
+                                   true, TYPE_PIIX4_PCI_DEVICE);
     dev = DEVICE(pci);
 
     /* Floppy */
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 95593408ef..1f47692447 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -153,4 +153,7 @@ static inline ISABus *isa_bus_from_device(ISADevice *d)
 
 /* i8257.c */
 void DMA_init(ISABus *bus, int high_page_enable);
+
+#define TYPE_PIIX4_PCI_DEVICE "piix4-isa"
+
 #endif
-- 
2.11.0
