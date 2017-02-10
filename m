Received: from eggs.gnu.org ([2001:4830:134:3::10]:46133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ccIyY-00086r-Mq
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 16:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ccIyV-0002e6-JG
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 16:43:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ccIyV-0002dz-DT
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 16:43:27 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 865C9C04BD21
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 21:43:27 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 10 Feb 2017 14:43:25 -0700
Message-ID: <20170210214310.22071.4158.stgit@gimli.home>
In-Reply-To: <20170210214127.22071.16525.stgit@gimli.home>
References: <20170210214127.22071.16525.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 2/3] hw/vfio/pci-quirks: Set category of the
 "vfio-pci-igd-lpc-bridge" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

The device has "bridge" in its name, so it should obviously be in
the category DEVICE_CATEGORY_BRIDGE.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci-quirks.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index ec0feca376f6..e9b493b939db 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1186,6 +1186,7 @@ static void vfio_pci_igd_lpc_bridge_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "VFIO dummy ISA/LPC bridge for IGD assignment";
     dc->hotpluggable = false;
     k->realize = vfio_pci_igd_lpc_bridge_realize;
