Received: from eggs.gnu.org ([2001:4830:134:3::10]:38858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRMwA-0006fM-39
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 15:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRMw5-0004mI-6b
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 15:20:38 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  8 Jun 2018 22:20:25 +0300
Message-Id: <20180608192027.284601-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180608192027.284601-1-vsementsov@virtuozzo.com>
References: <20180608192027.284601-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/3] qemu-img: allow compressed not-in-order
 writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, stefanha@gmail.com, pl@kamp.de, vsementsov@virtuozzo.com, den@openvz.org

No reason to forbid them, and they are needed to improve performance
with compress-threads in further patches.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-img.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 75f1610aa0..df2657b9cb 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2122,11 +2122,6 @@ static int img_convert(int argc, char **argv)
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
