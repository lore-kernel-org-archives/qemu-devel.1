Received: from eggs.gnu.org ([2001:4830:134:3::10]:60082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcbMr-0007LS-Q8
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcbMr-0002vy-3M
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:58:37 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  9 Jul 2018 20:58:23 +0200
Message-Id: <20180709185828.4248-3-mreitz@redhat.com>
In-Reply-To: <20180709185828.4248-1-mreitz@redhat.com>
References: <20180709185828.4248-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] file-posix: Fix fd_open check in
 raw_co_copy_range_to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Fam Zheng <famz@redhat.com>

One of them is a typo. But update both to be more readable.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20180702025836.20957-3-famz@redhat.com
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 98987b80f1..349f77a3af 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2611,7 +2611,7 @@ static int coroutine_fn raw_co_copy_range_to(BlockDriverState *bs,
     }
 
     src_s = src->bs->opaque;
-    if (fd_open(bs) < 0 || fd_open(bs) < 0) {
+    if (fd_open(src->bs) < 0 || fd_open(dst->bs) < 0) {
         return -EIO;
     }
     return paio_submit_co_full(bs, src_s->fd, src_offset, s->fd, dst_offset,
-- 
2.17.1
