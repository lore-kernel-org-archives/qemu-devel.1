Received: from eggs.gnu.org ([2001:4830:134:3::10]:60138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcbMy-0007Oe-0Y
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcbMw-0002xe-Li
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:58:44 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  9 Jul 2018 20:58:25 +0200
Message-Id: <20180709185828.4248-5-mreitz@redhat.com>
In-Reply-To: <20180709185828.4248-1-mreitz@redhat.com>
References: <20180709185828.4248-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] raw: Drop superfluous semicolon
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

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20180702025836.20957-5-famz@redhat.com
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/raw-format.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index b78da564d4..8e648a5666 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -177,7 +177,7 @@ static inline int raw_adjust_offset(BlockDriverState *bs, uint64_t *offset,
         /* There's not enough space for the write, or the read request is
          * out-of-range. Don't read/write anything to prevent leaking out of
          * the size specified in options. */
-        return is_write ? -ENOSPC : -EINVAL;;
+        return is_write ? -ENOSPC : -EINVAL;
     }
 
     if (*offset > INT64_MAX - s->offset) {
-- 
2.17.1
