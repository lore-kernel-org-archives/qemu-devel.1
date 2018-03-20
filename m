Received: from eggs.gnu.org ([2001:4830:134:3::10]:50738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7m6-0006WY-8x
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7m5-00081c-Cw
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56974 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7m5-00081O-7y
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:21 -0400
Date: Tue, 20 Mar 2018 05:17:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-15-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 14/50] standard-headers: update virtio_net.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

include speed/duplex fields

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/standard-headers/linux/virtio_net.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index 30ff249..e9f255e 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -57,6 +57,8 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
+
 #ifndef VIRTIO_NET_NO_LEGACY
 #define VIRTIO_NET_F_GSO	6	/* Host handles pkts w/ any GSO type */
 #endif /* VIRTIO_NET_NO_LEGACY */
@@ -76,6 +78,17 @@ struct virtio_net_config {
 	uint16_t max_virtqueue_pairs;
 	/* Default maximum transmit unit advice */
 	uint16_t mtu;
+	/*
+	 * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
+	 * Any other value stands for unknown.
+	 */
+	uint32_t speed;
+	/*
+	 * 0x00 - half duplex
+	 * 0x01 - full duplex
+	 * Any other value stands for unknown.
+	 */
+	uint8_t duplex;
 } QEMU_PACKED;
 
 /*
-- 
MST
