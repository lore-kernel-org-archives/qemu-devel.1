Received: from eggs.gnu.org ([2001:4830:134:3::10]:59985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dKroD-0001L7-A5
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dKroA-0000c5-95
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:49:01 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 13 Jun 2017 21:48:49 +0200
Message-Id: <1497383329-10393-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/pci-bridge/dec: Classify the DEC PCI bridge
 as bridge device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, qemu-trivial@nongnu.org

This way the bridge shows up in the correct section of the
"-device help" text.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/pci-bridge/dec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
index cca9362..eb275e1 100644
--- a/hw/pci-bridge/dec.c
+++ b/hw/pci-bridge/dec.c
@@ -62,6 +62,7 @@ static void dec_21154_pci_bridge_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     k->realize = dec_pci_bridge_realize;
     k->exit = pci_bridge_exitfn;
     k->vendor_id = PCI_VENDOR_ID_DEC;
@@ -118,6 +119,7 @@ static void dec_21154_pci_host_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     k->realize = dec_21154_pci_host_realize;
     k->vendor_id = PCI_VENDOR_ID_DEC;
     k->device_id = PCI_DEVICE_ID_DEC_21154;
-- 
1.8.3.1
