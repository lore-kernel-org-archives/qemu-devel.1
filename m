Received: from eggs.gnu.org ([2001:4830:134:3::10]:53241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQ8N3-0004jT-9d
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQ8Mz-00024M-IC
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:03:01 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:58807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eQ8Mz-0001yG-AD
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:02:57 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat, 16 Dec 2017 10:02:18 +0100
Message-Id: <20171216090228.28505-6-hpoussin@reactos.org>
In-Reply-To: <20171216090228.28505-1-hpoussin@reactos.org>
References: <20171216090228.28505-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/15] piix4: rename some variables in realize
 function
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

PIIX4 structure is now 's'
PCI device is now 'pci'
DeviceState is now 'dev'

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/isa/piix4.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 6b8bc3faf0..4f476dc7e6 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -87,16 +87,17 @@ static const VMStateDescription vmstate_piix4 = {
     }
 };
 
-static void piix4_realize(PCIDevice *dev, Error **errp)
+static void piix4_realize(PCIDevice *pci, Error **errp)
 {
-    PIIX4State *d = PIIX4_PCI_DEVICE(dev);
+    DeviceState *dev = DEVICE(pci);
+    PIIX4State *s = DO_UPCAST(PIIX4State, dev, pci);
 
-    if (!isa_bus_new(DEVICE(d), pci_address_space(dev),
-                     pci_address_space_io(dev), errp)) {
+    if (!isa_bus_new(dev, pci_address_space(pci),
+                     pci_address_space_io(pci), errp)) {
         return;
     }
-    piix4_dev = &d->dev;
-    qemu_register_reset(piix4_reset, d);
+    piix4_dev = pci;
+    qemu_register_reset(piix4_reset, s);
 }
 
 int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)
-- 
2.11.0
