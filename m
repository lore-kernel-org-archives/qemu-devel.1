Received: from eggs.gnu.org ([2001:4830:134:3::10]:46746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1elEw2-0001Kk-Sg
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:18:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1elEvy-0003k0-VP
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:18:22 -0500
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:58976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1elEvy-0003fu-Np
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:18:18 -0500
Received: from player755.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 1814EA1C4E
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 15:18:16 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 12 Feb 2018 15:18:08 +0100
Message-ID: <151844508814.7999.5257918627784684957.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] virtio-pci: trivial fixes in error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/virtio/virtio-pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c20537f31de7..ae3e8e1ca9b8 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1585,7 +1585,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
     if (legacy) {
         if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
             error_setg(errp, "VIRTIO_F_IOMMU_PLATFORM was supported by"
-                       "neither legacy nor transitional device.");
+                       " neither legacy nor transitional device");
             return ;
         }
         /*
