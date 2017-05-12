Received: from eggs.gnu.org ([2001:4830:134:3::10]:60885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996o-0002tE-86
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996n-00055J-5g
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d996m-00054z-VY
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:45 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 May 2017 13:51:34 +0200
Message-Id: <20170512115135.17379-10-kraxel@redhat.com>
In-Reply-To: <20170512115135.17379-1-kraxel@redhat.com>
References: <20170512115135.17379-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 09/10] vnc: simple clean up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Wei Qi <weiqi4@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Wei Qi <weiqi4@huawei.com>

It is unnecessary to assign 'packed_bytes' to 'estimated_bytes', because 'estimated_bytes' unused after assignment.

Signed-off-by: Wei Qi <weiqi4@huawei.com>
Reviewed-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc-enc-zrle.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/vnc-enc-zrle.c b/ui/vnc-enc-zrle.c
index 5489870e70..fd63d4f688 100644
--- a/ui/vnc-enc-zrle.c
+++ b/ui/vnc-enc-zrle.c
@@ -163,7 +163,6 @@ static void zrle_choose_palette_rle(VncState *vs, int w, int h,
             if (packed_bytes < estimated_bytes) {
                 *use_rle = false;
                 *use_palette = true;
-                estimated_bytes = packed_bytes;
             }
         }
     }
-- 
2.9.3
