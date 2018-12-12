Received: from eggs.gnu.org ([2001:4830:134:3::10]:43064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gX1Cv-0004NS-OV
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gX1Cu-0004IA-Lm
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:53:33 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 12 Dec 2018 09:52:52 +0000
Message-Id: <20181212095252.20349-3-stefanha@redhat.com>
In-Reply-To: <20181212095252.20349-1-stefanha@redhat.com>
References: <20181212095252.20349-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] virtio-blk: fix comment for
 virtio_blk_rw_complete as nalloc is initially -1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Dongli Zhang <dongli.zhang@oracle.com>

From: Dongli Zhang <dongli.zhang@oracle.com>

The initial value of nalloc is -1, but not 1.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-id: 1541479952-32355-1-git-send-email-dongli.zhang@oracle.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index fb0d74da07..f208c6ddb9 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -96,7 +96,7 @@ static void virtio_blk_rw_complete(void *opaque, int re=
t)
         trace_virtio_blk_rw_complete(vdev, req, ret);
=20
         if (req->qiov.nalloc !=3D -1) {
-            /* If nalloc is !=3D 1 req->qiov is a local copy of the orig=
inal
+            /* If nalloc is !=3D -1 req->qiov is a local copy of the ori=
ginal
              * external iovec. It was allocated in submit_requests to be
              * able to merge requests. */
             qemu_iovec_destroy(&req->qiov);
--=20
2.19.2
