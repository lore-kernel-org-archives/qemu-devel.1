Received: from eggs.gnu.org ([209.51.188.92]:47568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpze-0003iS-AI
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpzc-00089C-33
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gjpzb-00086z-RQ
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:32:47 -0500
From: wexu@redhat.com
Date: Wed, 16 Jan 2019 13:31:19 -0500
Message-Id: <1547663480-547-15-git-send-email-wexu@redhat.com>
In-Reply-To: <1547663480-547-1-git-send-email-wexu@redhat.com>
References: <1547663480-547-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel]  [PATCH v2 14/15] vhost: enable packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, tiwei.bie@intel.com, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com

From: Wei Xu <wexu@redhat.com>

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/net/vhost_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index fb4b18f..f593086 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -53,6 +53,7 @@ static const int kernel_feature_bits[] = {
     VIRTIO_F_VERSION_1,
     VIRTIO_NET_F_MTU,
     VIRTIO_F_IOMMU_PLATFORM,
+    VIRTIO_F_RING_PACKED,
     VHOST_INVALID_FEATURE_BIT
 };
 
-- 
1.8.3.1
