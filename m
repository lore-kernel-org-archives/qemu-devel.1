Received: from eggs.gnu.org ([2001:4830:134:3::10]:46388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7Gy-0007Ko-2Z
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7Gx-0002P2-0x
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:44:40 -0400
Date: Mon, 3 Jul 2017 22:44:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1499111049-13721-3-git-send-email-mst@redhat.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499111049-13721-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 02/21] hw/pci-bridge/dec: Classify the DEC PCI
 bridge as bridge device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

From: Thomas Huth <thuth@redhat.com>

This way the bridge shows up in the correct section of the
"-device help" text.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
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
MST
