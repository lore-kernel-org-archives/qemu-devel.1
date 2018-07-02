Received: from eggs.gnu.org ([2001:4830:134:3::10]:42256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fZp3H-0001Fn-Qe
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 22:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fZp3H-0001dQ-6Y
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 22:58:55 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon,  2 Jul 2018 10:58:34 +0800
Message-Id: <20180702025836.20957-3-famz@redhat.com>
In-Reply-To: <20180702025836.20957-1-famz@redhat.com>
References: <20180702025836.20957-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] file-posix: Fix fd_open check in
 raw_co_copy_range_to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

One of them is a typo. But update both to be more readable.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 829ee538d8..e04e464e72 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2600,7 +2600,7 @@ static int coroutine_fn raw_co_copy_range_to(BlockDriverState *bs,
     }
 
     src_s = src->bs->opaque;
-    if (fd_open(bs) < 0 || fd_open(bs) < 0) {
+    if (fd_open(src->bs) < 0 || fd_open(dst->bs) < 0) {
         return -EIO;
     }
     return paio_submit_co_full(bs, src_s->fd, src_offset, s->fd, dst_offset,
-- 
2.17.1
