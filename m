Received: from eggs.gnu.org ([2001:4830:134:3::10]:52056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliangleo@didichuxing.com>) id 1ec8cP-0006SR-LI
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliangleo@didichuxing.com>) id 1ec8cM-0002RV-K5
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:44:29 -0500
Received: from mx1.didichuxing.com ([111.202.154.82]:7449
	helo=BJEXCAS002.didichuxing.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liliangleo@didichuxing.com>)
	id 1ec8cM-0002Is-8X
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:44:26 -0500
Date: Thu, 18 Jan 2018 18:58:41 +0800
From: Liang Li <liliangleo@didichuxing.com>
Message-ID: <20180118105841.GA1897@liangdeMacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] hbitmap: fix missing restore count when finish
 deserialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vsementsov@virtuozzo.com, famz@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org

The .count of HBitmap is forgot to set in function
hbitmap_deserialize_finish, let's set it to the right value.

Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Fam Zheng <famz@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: John Snow <jsnow@redhat.com>
Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
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
