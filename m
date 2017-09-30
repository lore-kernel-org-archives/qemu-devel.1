Received: from eggs.gnu.org ([2001:4830:134:3::10]:46757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dyDKc-0000la-7o
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 04:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dyDKX-0003OS-Iz
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 04:41:06 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:54572 helo=mxct.zte.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiang.biao2@zte.com.cn>)
	id 1dyDKX-0003Lv-8H
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 04:41:01 -0400
From: Jiang Biao <jiang.biao2@zte.com.cn>
Date: Sat, 30 Sep 2017 17:00:42 +0800
Message-Id: <1506762042-32145-1-git-send-email-jiang.biao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] tcg/mips: delete commented out extern keyword.
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: aurelien@aurel32.net, rth@twiddle.net
Cc: qemu-devel@nongnu.org, zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn
List-ID: <qemu-devel.nongnu.org>

Delete commented out extern keyword on link_error().

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 tcg/mips/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index ce40306..3880984 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -36,7 +36,7 @@
 #else
 /* To assert at compile-time that these values are never used
    for TCG_TARGET_REG_BITS == 64.  */
-/* extern */ int link_error(void);
+int link_error(void);
 # define LO_OFF  link_error()
 # define HI_OFF  link_error()
 #endif
-- 
2.7.4
