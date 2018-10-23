Received: from eggs.gnu.org ([2001:4830:134:3::10]:51358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JC-0003Bg-SE
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JB-000865-94
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:41:58 -0400
Received: from [185.30.24.106] (port=13104
	helo=hotspot.internet-for-guests.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JA-0007ZN-IB
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:41:56 -0400
Date: Tue, 23 Oct 2018 19:41:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023234112.188140-2-mst@redhat.com>
References: <20181023234112.188140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023234112.188140-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 01/28] virtio-blk: fix comment for
 virtio_blk_rw_complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>

Here should be submit_requests, there is no submit_merged_requests
function.

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/virtio-blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 225fe44b7a..83cf5c01f9 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -97,8 +97,8 @@ static void virtio_blk_rw_complete(void *opaque, int ret)
 
         if (req->qiov.nalloc != -1) {
             /* If nalloc is != 1 req->qiov is a local copy of the original
-             * external iovec. It was allocated in submit_merged_requests
-             * to be able to merge requests. */
+             * external iovec. It was allocated in submit_requests to be
+             * able to merge requests. */
             qemu_iovec_destroy(&req->qiov);
         }
 
-- 
MST
