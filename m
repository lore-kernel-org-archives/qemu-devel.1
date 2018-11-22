Received: from eggs.gnu.org ([2001:4830:134:3::10]:37061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gPphD-0007JX-1P
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gPph9-0001SL-4l
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:11:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gPph8-0001PU-Uk
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:11:03 -0500
From: wexu@redhat.com
Date: Thu, 22 Nov 2018 09:06:20 -0500
Message-Id: <1542895581-10721-16-git-send-email-wexu@redhat.com>
In-Reply-To: <1542895581-10721-1-git-send-email-wexu@redhat.com>
References: <1542895581-10721-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel]  [PATCH v1 15/16] vhost: enable packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com

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
