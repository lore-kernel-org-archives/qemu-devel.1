Received: from eggs.gnu.org ([2001:4830:134:3::10]:46367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cVw3w-0001HX-J5
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 03:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cVw3s-0003y8-Nq
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 03:02:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cVw3s-0003wn-I7
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 03:02:40 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1FD337EE7
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 08:02:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 24 Jan 2017 09:02:38 +0100
Message-Id: <1485244958-25911-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/vfio/pci-quirks: Set category of the
 "vfio-pci-igd-lpc-bridge" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org

The device has "bridge" in its name, so it should obviously be in
the category DEVICE_CATEGORY_BRIDGE.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/vfio/pci-quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 811eecd..4891b37 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1185,6 +1185,7 @@ static void vfio_pci_igd_lpc_bridge_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "VFIO dummy ISA/LPC bridge for IGD assignment";
     dc->hotpluggable = false;
     k->realize = vfio_pci_igd_lpc_bridge_realize;
-- 
1.8.3.1
