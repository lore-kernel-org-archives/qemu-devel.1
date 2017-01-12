Received: from eggs.gnu.org ([2001:4830:134:3::10]:34576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=2EE3=Y2=redhat.com=mst@kernel.org>)
	id 1cRmyb-0005Co-Fl
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=2EE3=Y2=redhat.com=mst@kernel.org>)
	id 1cRmyW-0006Z7-K7
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:32:05 -0500
Received: from mail.kernel.org ([198.145.29.136]:39984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=2EE3=Y2=redhat.com=mst@kernel.org>)
	id 1cRmyW-0006YV-ET
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:32:00 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C702020426
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 21:31:57 +0000 (UTC)
Received: from redhat.com (nat-pool-bos-t.redhat.com [66.187.233.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A7B83203FB
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 21:31:56 +0000 (UTC)
Date: Thu, 12 Jan 2017 23:31:56 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484256713-10902-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] virtio: drop an obsolete comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

virtio core has code to revert queue number
to maximum on reset. Drop TODO to add that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
