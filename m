Received: from eggs.gnu.org ([2001:4830:134:3::10]:36933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJy5-0000rg-Oe
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJy2-0000HT-Hg
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:10:01 -0500
Received: from mail.kernel.org ([198.145.29.136]:56958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJy2-0000G7-BB
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:58 -0500
Date: Thu, 19 Jan 2017 23:09:53 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484860116-25361-16-git-send-email-mst@redhat.com>
References: <1484860116-25361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484860116-25361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 15/17] vhost: drop VHOST_F_DEVICE_IOTLB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

Upstream does not have it, uses VIRTIO_F_IOMMU_PLATFORM
to signal support instead.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 linux-headers/linux/vhost.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
index ac7a1f1..1e86a3d 100644
--- a/linux-headers/linux/vhost.h
+++ b/linux-headers/linux/vhost.h
@@ -172,8 +172,6 @@ struct vhost_memory {
 #define VHOST_F_LOG_ALL 26
 /* vhost-net should add virtio_net_hdr for RX, and strip for TX packets. */
 #define VHOST_NET_F_VIRTIO_NET_HDR 27
-/* Vhost have device IOTLB */
-#define VHOST_F_DEVICE_IOTLB 63
 
 /* VHOST_SCSI specific definitions */
 
-- 
MST
