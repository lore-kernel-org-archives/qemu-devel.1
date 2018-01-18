Received: from eggs.gnu.org ([2001:4830:134:3::10]:50946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliangleo@didichuxing.com>) id 1ecA0Y-0004p4-QE
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliangleo@didichuxing.com>) id 1ecA0U-0001sS-J5
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:13:30 -0500
Received: from mx1.didichuxing.com ([111.202.154.82]:4256
	helo=BJEXMBX011.didichuxing.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liliangleo@didichuxing.com>)
	id 1ecA0U-0001pP-7m
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:13:26 -0500
Date: Thu, 18 Jan 2018 21:13:09 +0800
From: Liang Li <liliangleo@didichuxing.com>
Message-ID: <20180118131308.GA2181@liangdeMacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH resend] hbitmap: fix missing restore count when
 finish deserialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Weiping Zhang <zhangweiping@didichuxing.com>

The .count of HBitmap is forgot to set in function
hbitmap_deserialize_finish, let's set it to the right value.

Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Fam Zheng <famz@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: John Snow <jsnow@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Weiping Zhang <zhangweiping@didichuxing.com>
Signed-off-by: Liang Li <liliangleo@didichuxing.com>

---
 util/hbitmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/hbitmap.c b/util/hbitmap.c
index 289778a..58a2c93 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -630,6 +630,7 @@ void hbitmap_deserialize_finish(HBitmap *bitmap)
     }
 
     bitmap->levels[0][0] |= 1UL << (BITS_PER_LONG - 1);
+    bitmap->count = hb_count_between(bitmap, 0, bitmap->size - 1);
 }
 
 void hbitmap_free(HBitmap *hb)
-- 
1.8.3.1
