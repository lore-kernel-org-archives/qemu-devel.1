Received: from eggs.gnu.org ([2001:4830:134:3::10]:33818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAg-00084z-3r
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAc-0005ou-0Q
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:34 -0500
Received: from mail.kernel.org ([198.145.29.136]:48316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAb-0005oN-QM
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:29 -0500
Date: Tue, 10 Jan 2017 07:40:25 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-27-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 26/41] net: vhost stop updates virtio queue state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yuri Benditovich <yuri.benditovich@daynix.com>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

Make virtio queue suitable for push operation from qemu
after vhost was stopped.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f7f7023..d396b22 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -993,6 +993,7 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
         virtio_queue_set_last_avail_idx(vdev, idx, state.num);
     }
     virtio_queue_invalidate_signalled_used(vdev, idx);
+    virtio_queue_update_used_idx(vdev, idx);
 
     /* In the cross-endian case, we need to reset the vring endianness to
      * native as legacy devices expect so by default.
-- 
MST
