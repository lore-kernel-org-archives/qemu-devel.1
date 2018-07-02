Received: from eggs.gnu.org ([2001:4830:134:3::10]:42324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fZp3R-0001LF-3k
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 22:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fZp3Q-0001lq-Eb
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 22:59:05 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon,  2 Jul 2018 10:58:36 +0800
Message-Id: <20180702025836.20957-5-famz@redhat.com>
In-Reply-To: <20180702025836.20957-1-famz@redhat.com>
References: <20180702025836.20957-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] raw: Drop superfluous semicolon
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

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
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
