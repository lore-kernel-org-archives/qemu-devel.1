Received: from eggs.gnu.org ([2001:4830:134:3::10]:48426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52i-0000wz-7S
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52h-0008JQ-Hd
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dX52h-0008J4-B4
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:27 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jul 2017 20:21:44 +0800
Message-Id: <1500294105-13713-14-git-send-email-jasowang@redhat.com>
In-Reply-To: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
References: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 13/14] virtion-net: Prefer is_power_of_2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Michal Privoznik <mprivozn@redhat.com>

We have a function that checks if given number is power of two.
We should prefer it instead of expanding the check on our own.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5630a9e..657d099 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1942,7 +1942,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
      */
     if (n->net_conf.rx_queue_size < VIRTIO_NET_RX_QUEUE_MIN_SIZE ||
         n->net_conf.rx_queue_size > VIRTQUEUE_MAX_SIZE ||
-        (n->net_conf.rx_queue_size & (n->net_conf.rx_queue_size - 1))) {
+        !is_power_of_2(n->net_conf.rx_queue_size)) {
         error_setg(errp, "Invalid rx_queue_size (= %" PRIu16 "), "
                    "must be a power of 2 between %d and %d.",
                    n->net_conf.rx_queue_size, VIRTIO_NET_RX_QUEUE_MIN_SIZE,
-- 
2.7.4
