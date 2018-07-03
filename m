Received: from eggs.gnu.org ([2001:4830:134:3::10]:52662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faMm7-0008UW-Aq
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faMm6-00053i-LN
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:59:27 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  3 Jul 2018 16:59:11 +0200
Message-Id: <20180703145915.32607-2-kwolf@redhat.com>
In-Reply-To: <20180703145915.32607-1-kwolf@redhat.com>
References: <20180703145915.32607-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] qemu-img: allow compressed not-in-order
 writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

No reason to forbid them, and they are needed to improve performance
with compress-threads in further patches.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.13.6
