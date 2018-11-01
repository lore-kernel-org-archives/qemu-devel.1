Received: from eggs.gnu.org ([2001:4830:134:3::10]:55887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIHhA-0002XY-8J
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIHh8-0007j6-M0
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:27:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  1 Nov 2018 21:27:32 +0300
Message-Id: <20181101182738.70462-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181101182738.70462-1-vsementsov@virtuozzo.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/7] qcow2: use Z_OK instead of 0 for
 deflateInit2 return code check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Use appropriate macro, corresponding to deflateInit2 spec.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 30689b7688..3e9367c449 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3734,7 +3734,7 @@ static ssize_t qcow2_compress(void *dest, const void *src, size_t size)
     memset(&strm, 0, sizeof(strm));
     ret = deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED,
                        -12, 9, Z_DEFAULT_STRATEGY);
-    if (ret != 0) {
+    if (ret != Z_OK) {
         return -2;
     }
 
-- 
2.18.0
