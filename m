Received: from eggs.gnu.org ([2001:4830:134:3::10]:41250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eafqc-0007xl-RP
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:49:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eafqc-00011H-2d
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:49:06 -0500
Received: from chuckie.co.uk ([82.165.15.123]:41905
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eafqb-0000oQ-TE
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 05:49:06 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 14 Jan 2018 10:47:44 +0000
Message-Id: <20180114104751.21965-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
References: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 04/11] apb: change pbm_pci_host prefix
 functions to use sabre_pci prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is the proper name for the PBM host bridge as referenced in the Sun
documentation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/apb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index d5c459a2df..98c5f344f7 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -472,7 +472,7 @@ static void sabre_init(Object *obj)
     sysbus_init_mmio(sbd, &s->pci_ioport);
 }
 
-static void sabre_pci_host_realize(PCIDevice *d, Error **errp)
+static void sabre_pci_realize(PCIDevice *d, Error **errp)
 {
     pci_set_word(d->config + PCI_COMMAND,
                  PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
@@ -481,12 +481,12 @@ static void sabre_pci_host_realize(PCIDevice *d, Error **errp)
                  PCI_STATUS_DEVSEL_MEDIUM);
 }
 
-static void sabre_pci_host_class_init(ObjectClass *klass, void *data)
+static void sabre_pci_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    k->realize = sabre_pci_host_realize;
+    k->realize = sabre_pci_realize;
     k->vendor_id = PCI_VENDOR_ID_SUN;
     k->device_id = PCI_DEVICE_ID_SUN_SABRE;
     k->class_id = PCI_CLASS_BRIDGE_HOST;
@@ -497,11 +497,11 @@ static void sabre_pci_host_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = false;
 }
 
-static const TypeInfo pbm_pci_host_info = {
+static const TypeInfo sabre_pci_info = {
     .name          = "pbm-pci",
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
-    .class_init    = sabre_pci_host_class_init,
+    .class_init    = sabre_pci_class_init,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -535,7 +535,7 @@ static const TypeInfo sabre_info = {
 static void sabre_register_types(void)
 {
     type_register_static(&sabre_info);
-    type_register_static(&pbm_pci_host_info);
+    type_register_static(&sabre_pci_info);
 }
 
 type_init(sabre_register_types)
-- 
2.11.0
