Received: from eggs.gnu.org ([209.51.188.92]:48892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0t-0003Yv-1a
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0s-0003oe-5S
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:47 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:45214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hCY0r-0003ks-KR
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:46 -0400
Received: by mail-qt1-f175.google.com with SMTP id v20so9301384qtv.12
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 16:12:45 -0700 (PDT)
Date: Fri, 5 Apr 2019 19:12:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190321161832.10533-1-yuval.shaia@oracle.com>
References: <20190405231225.30165-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405231225.30165-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] virtio-net: Fix typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yuval Shaia <yuval.shaia@oracle.com>, Jason Wang <jasowang@redhat.com>

From: Yuval Shaia <yuval.shaia@oracle.com>

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Message-Id: <20190321161832.10533-1-yuval.shaia@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7e2c2a6f6a..ffe0872fff 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2281,7 +2281,7 @@ static void virtio_net_change_num_queues(VirtIONet *n, int new_max_queues)
     /*
      * We always need to remove and add ctrl vq if
      * old_num_queues != new_num_queues. Remove ctrl_vq first,
-     * and then we only enter one of the following too loops.
+     * and then we only enter one of the following two loops.
      */
     virtio_del_queue(vdev, old_num_queues - 1);
 
-- 
MST
