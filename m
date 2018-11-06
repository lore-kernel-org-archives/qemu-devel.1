Received: from eggs.gnu.org ([2001:4830:134:3::10]:34569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gJtLE-0007te-GR
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 23:51:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gJtKF-0001wj-Ic
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 23:50:52 -0500
From: Dongli Zhang <dongli.zhang@oracle.com>
Date: Tue,  6 Nov 2018 12:52:32 +0800
Message-Id: <1541479952-32355-1-git-send-email-dongli.zhang@oracle.com>
Subject: [Qemu-devel] [PATCH 1/1] virtio-blk: fix comment for
 virtio_blk_rw_complete as nalloc is initially -1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, mst@redhat.com
Cc: qemu-trivial@nongnu.org, stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com

The initial value of nalloc is -1, but not 1.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
This is based on git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

 hw/block/virtio-blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 83cf5c0..30999c3 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -96,7 +96,7 @@ static void virtio_blk_rw_complete(void *opaque, int ret)
         trace_virtio_blk_rw_complete(vdev, req, ret);
 
         if (req->qiov.nalloc != -1) {
-            /* If nalloc is != 1 req->qiov is a local copy of the original
+            /* If nalloc is != -1 req->qiov is a local copy of the original
              * external iovec. It was allocated in submit_requests to be
              * able to merge requests. */
             qemu_iovec_destroy(&req->qiov);
-- 
2.7.4
