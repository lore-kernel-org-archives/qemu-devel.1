Received: from eggs.gnu.org ([2001:4830:134:3::10]:46750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1daYUk-00064N-Dl
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1daYUf-0005ws-8s
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:25:46 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:61182)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1daYUe-0005uw-SB
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:25:41 -0400
From: Jiang Biao <jiang.biao2@zte.com.cn>
Date: Thu, 27 Jul 2017 10:36:23 +0800
Message-Id: <1501122983-20801-1-git-send-email-jiang.biao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] tcg/README: fix a description error.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, jiang.yong5@zte.com.cn, jiang.biao2@zte.com.cn, shi.zhongbing@zte.com.cn

The atomics.txt is not in the docs directory but in docs/devel/
instead.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 tcg/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/README b/tcg/README
index bf49e82..03bfb6a 100644
--- a/tcg/README
+++ b/tcg/README
@@ -446,7 +446,7 @@ when MTTCG is enabled.
 The guest translators should generate this opcode for all guest instructions
 which have ordering side effects.
 
-Please see docs/atomics.txt for more information on memory barriers.
+Please see docs/devel/atomics.txt for more information on memory barriers.
 
 ********* 64-bit guest on 32-bit host support
 
-- 
2.7.4
