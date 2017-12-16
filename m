Received: from eggs.gnu.org ([2001:4830:134:3::10]:53174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQ8N1-0004ip-DM
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQ8N0-00025n-N6
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:02:59 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:58849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eQ8N0-00024r-Gv
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:02:58 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat, 16 Dec 2017 10:02:27 +0100
Message-Id: <20171216090228.28505-15-hpoussin@reactos.org>
In-Reply-To: <20171216090228.28505-1-hpoussin@reactos.org>
References: <20171216090228.28505-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 14/15] piix4: rename PIIX4 object to piix4-isa
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

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/isa/piix4.c       | 2 +-
 hw/mips/mips_malta.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 7358d7f5db..2e9aca6659 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -52,7 +52,7 @@ typedef struct PIIX4State {
     uint8_t rcr;
 } PIIX4State;
 
-#define TYPE_PIIX4_PCI_DEVICE "PIIX4"
+#define TYPE_PIIX4_PCI_DEVICE "piix4-isa"
 #define PIIX4_PCI_DEVICE(obj) \
     OBJECT_CHECK(PIIX4State, (obj), TYPE_PIIX4_PCI_DEVICE)
 
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index c0ee2ad0cd..5fc2890d03 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1187,7 +1187,7 @@ void mips_malta_init(MachineState *machine)
     ide_drive_get(hd, ARRAY_SIZE(hd));
 
     pci = pci_create_multifunction(pci_bus, PCI_DEVFN(10, 0),
-                                   true, "PIIX4");
+                                   true, "piix4-isa");
     dev = DEVICE(pci);
 
     /* Floppy */
-- 
2.11.0
