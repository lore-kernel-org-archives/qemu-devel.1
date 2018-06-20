Received: from eggs.gnu.org ([2001:4830:134:3::10]:49264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVePe-0000zw-8O
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVePd-0004zb-GC
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:48:46 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 20 Jun 2018 17:48:35 +0300
Message-Id: <20180620144837.19341-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180620144837.19341-1-vsementsov@virtuozzo.com>
References: <20180620144837.19341-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/3] qemu-img: allow compressed not-in-order
 writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, stefanha@gmail.com, pl@kamp.de, den@openvz.org, vsementsov@virtuozzo.com

No reason to forbid them, and they are needed to improve performance
with compress-threads in further patches.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-img.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index e1a506f7f6..7651d8172c 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2141,11 +2141,6 @@ static int img_convert(int argc, char **argv)
         goto fail_getopt;
     }
 
-    if (!s.wr_in_order && s.compressed) {
-        error_report("Out of order write and compress are mutually exclusive");
-        goto fail_getopt;
-    }
-
     if (tgt_image_opts && !skip_create) {
         error_report("--target-image-opts requires use of -n flag");
         goto fail_getopt;
-- 
2.11.1
