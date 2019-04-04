Received: from eggs.gnu.org ([209.51.188.92]:56098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <706701795@qq.com>) id 1hCPLb-0001Hs-Mp
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <706701795@qq.com>) id 1hCP65-0006iV-1B
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:41:36 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:36009)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <706701795@qq.com>) id 1hCP5z-0006bp-0S
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:41:30 -0400
From: lichun <706701795@qq.com>
Date: Thu,  4 Apr 2019 19:46:45 +0800
Message-Id: <1554378405-11640-1-git-send-email-706701795@qq.com>
Subject: [Qemu-devel] [PATCH] Fixed dump_buffer function parameter offset
 does not take effect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: lichun <706701795@qq.com>

Signed-off-by: lichun <706701795@qq.com>
---
 qemu-io-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 09750a2..8d93dc6 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -357,7 +357,7 @@ static void dump_buffer(const void *buffer, int64_t offset, int64_t len)
     int j;
     const uint8_t *p;
 
-    for (i = 0, p = buffer; i < len; i += 16) {
+    for (i = 0, p = buffer + offset; i < len; i += 16) {
         const uint8_t *s = p;
 
         printf("%08" PRIx64 ":  ", offset + i);
-- 
1.8.3.1
