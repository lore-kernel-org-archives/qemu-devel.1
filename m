Received: from eggs.gnu.org ([2001:4830:134:3::10]:36761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxm-0000XP-8L
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxj-0008G1-Vv
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:42 -0500
Received: from mail.kernel.org ([198.145.29.136]:56798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxj-0008Ei-Q8
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:39 -0500
Date: Thu, 19 Jan 2017 23:09:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484860116-25361-10-git-send-email-mst@redhat.com>
References: <1484860116-25361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484860116-25361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 09/17] virtio: drop an obsolete comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

virtio core has code to revert queue number
to maximum on reset. Drop TODO to add that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio-pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 8baaf2b..09230c0 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1316,7 +1316,6 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
         virtio_queue_set_vector(vdev, vdev->queue_sel, val);
         break;
     case VIRTIO_PCI_COMMON_Q_ENABLE:
-        /* TODO: need a way to put num back on reset. */
         virtio_queue_set_num(vdev, vdev->queue_sel,
                              proxy->vqs[vdev->queue_sel].num);
         virtio_queue_set_rings(vdev, vdev->queue_sel,
-- 
MST
