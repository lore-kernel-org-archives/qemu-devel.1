Received: from eggs.gnu.org ([2001:4830:134:3::10]:43072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmF-0006Ho-8v
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmE-0000aB-AL
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:47 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:26 +0200
Message-Id: <1499447335-6125-72-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 071/100] block/dirty-bitmap: fix comment for
 BlockDirtyBitmap.disabled field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170628120530.31251-10-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/dirty-bitmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index f502c45..a8fe149 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -43,7 +43,8 @@ struct BdrvDirtyBitmap {
     BdrvDirtyBitmap *successor; /* Anonymous child; implies frozen status */
     char *name;                 /* Optional non-empty unique ID */
     int64_t size;               /* Size of the bitmap (Number of sectors) */
-    bool disabled;              /* Bitmap is read-only */
+    bool disabled;              /* Bitmap is disabled. It ignores all writes to
+                                   the device */
     int active_iterators;       /* How many iterators are active */
     QLIST_ENTRY(BdrvDirtyBitmap) list;
 };
-- 
1.8.3.1
