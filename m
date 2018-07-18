Received: from eggs.gnu.org ([2001:4830:134:3::10]:42750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffo4B-0002Ov-Bn
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffo4A-0008Bw-Cs
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:08:35 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 18 Jul 2018 17:08:29 +0200
Message-Id: <1531926509-8280-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] block/vvfat: Disable debug message by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

It's annoying to see this debug message every time you use vvfat.
Disable it with the DLOG() macro by default, as it is done with the
other debug messages in this file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block/vvfat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index c7d2ed2..fc41841 100644
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
1.8.3.1
