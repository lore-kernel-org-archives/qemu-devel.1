Received: from eggs.gnu.org ([2001:4830:134:3::10]:51148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhdy0-0002L6-U1
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhdxw-0005GE-LW
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:45:48 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 23 Jul 2018 18:45:30 +0200
Message-Id: <20180723164530.26599-8-kwolf@redhat.com>
In-Reply-To: <20180723164530.26599-1-kwolf@redhat.com>
References: <20180723164530.26599-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] block/vvfat: Disable debug message by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

From: Thomas Huth <thuth@redhat.com>

It's annoying to see this debug message every time you use vvfat.
Disable it with the DLOG() macro by default, as it is done with the
other debug messages in this file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index c7d2ed2d96..fc41841a5c 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1245,8 +1245,8 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
     s->fat2 = NULL;
     s->downcase_short_names = 1;
 
-    fprintf(stderr, "vvfat %s chs %d,%d,%d\n",
-            dirname, cyls, heads, secs);
+    DLOG(fprintf(stderr, "vvfat %s chs %d,%d,%d\n",
+                 dirname, cyls, heads, secs));
 
     s->sector_count = cyls * heads * secs - s->offset_to_bootsector;
 
-- 
2.13.6
