Received: from eggs.gnu.org ([2001:4830:134:3::10]:53183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cb5nz-0005ZR-GE
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cb5ny-0007qw-NS
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:27:35 -0500
From: Fam Zheng <famz@redhat.com>
Date: Tue,  7 Feb 2017 21:27:23 +0800
Message-Id: <20170207132723.13934-3-famz@redhat.com>
In-Reply-To: <20170207132723.13934-1-famz@redhat.com>
References: <20170207132723.13934-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] virtio-blk: Inline request init,
 complete and free functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

These are used in each request handling, inline them.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/block/virtio-blk.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 2858c31..1da9570 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -29,8 +29,8 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 
-static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
-                                    VirtIOBlockReq *req)
+static inline void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
+                                           VirtIOBlockReq *req)
 {
     req->dev = s;
     req->vq = vq;
@@ -40,12 +40,13 @@ static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
     req->mr_next = NULL;
 }
 
-static void virtio_blk_free_request(VirtIOBlockReq *req)
+static inline void virtio_blk_free_request(VirtIOBlockReq *req)
 {
     g_free(req);
 }
 
-static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
+static inline void virtio_blk_req_complete(VirtIOBlockReq *req,
+                                           unsigned char status)
 {
     VirtIOBlock *s = req->dev;
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
-- 
2.9.3
