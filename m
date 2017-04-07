Received: from eggs.gnu.org ([2001:4830:134:3::10]:53442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <weiqi4@huawei.com>) id 1cwOCf-0000sX-6v
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <weiqi4@huawei.com>) id 1cwOCd-0007cC-9I
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:21:05 -0400
Received: from [45.249.212.188] (port=3414 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <weiqi4@huawei.com>) id 1cwOCc-0007H1-RL
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:21:03 -0400
From: weiqi <weiqi4@huawei.com>
Date: Fri, 7 Apr 2017 14:58:58 +0800
Message-ID: <1491548338-15128-1-git-send-email-weiqi4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/3] vnc: simple clean up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, Wei Qi <weiqi4@huawei.com>

From: Wei Qi <weiqi4@huawei.com>

It is unnecessary to assign 'packed_bytes' to 'estimated_bytes', because 'estimated_bytes' unused after assignment.

Signed-off-by: Wei Qi <weiqi4@huawei.com>
---
 ui/vnc-enc-zrle.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/vnc-enc-zrle.c b/ui/vnc-enc-zrle.c
index 5489870..fd63d4f 100644
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
1.8.3.1
