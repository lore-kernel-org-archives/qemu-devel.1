Received: from eggs.gnu.org ([209.51.188.92]:34492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUy5-00077o-8r
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUy1-00031C-4w
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUxx-0002rv-9I
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:42 -0500
Date: Tue, 15 Jan 2019 15:05:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-18-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 17/49] virtio-net: changed
 VIRTIO_NET_F_RSC_EXT to be 61
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

Allocated feature bit changed in spec draft per TC request.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9e5fb1ed62..3f319ef723 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -66,7 +66,7 @@
 #if !defined(VIRTIO_NET_HDR_F_RSC_INFO)
 
 #define VIRTIO_NET_HDR_F_RSC_INFO  4 /* rsc_ext data in csum_ fields */
-#define VIRTIO_NET_F_RSC_EXT       38
+#define VIRTIO_NET_F_RSC_EXT       61
 
 static inline __virtio16 *virtio_net_rsc_ext_num_packets(
     struct virtio_net_hdr *hdr)
-- 
MST
