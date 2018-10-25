Received: from eggs.gnu.org ([2001:4830:134:3::10]:57744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFTtG-0002Ea-NR
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFTtE-0004BV-St
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:52:46 -0400
Date: Wed, 24 Oct 2018 20:52:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181025005110.249256-2-mst@redhat.com>
References: <20181025005110.249256-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025005110.249256-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 01/28] virtio-blk: fix comment for
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
