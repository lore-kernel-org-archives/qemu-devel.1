Received: from eggs.gnu.org ([2001:4830:134:3::10]:60144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjPj-00076i-Cy
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjPd-00022N-AB
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:15:49 -0500
Date: Mon, 5 Nov 2018 13:15:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-6-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 05/33] virtio-blk: fix comment for
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
