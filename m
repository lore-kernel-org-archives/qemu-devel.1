Received: from eggs.gnu.org ([2001:4830:134:3::10]:46345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zJ-0004R3-5K
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zE-00030N-LT
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:41 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42129)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dU6zE-0002yx-5H
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Jul 2017 03:49:59 -0400
Message-Id: <1499586614-20507-8-git-send-email-cota@braap.org>
In-Reply-To: <1499586614-20507-1-git-send-email-cota@braap.org>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 07/22] tcg/i386: constify
 tcg_target_callee_save_regs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/i386/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 01e3b4e..06df01a 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2514,7 +2514,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     return NULL;
 }
 
-static int tcg_target_callee_save_regs[] = {
+static const int tcg_target_callee_save_regs[] = {
 #if TCG_TARGET_REG_BITS == 64
     TCG_REG_RBP,
     TCG_REG_RBX,
-- 
2.7.4
