Received: from eggs.gnu.org ([2001:4830:134:3::10]:42559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dZlJW-0001Qz-GP
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dZlJS-00035F-I6
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:54:54 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38451)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dZlJS-00034H-73
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:54:50 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 24 Jul 2017 17:54:49 -0400
Message-Id: <1500933289-19535-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH] disas/arm: fix 'instuction' typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 disas/arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/arm.c b/disas/arm.c
index 27396dd..a08bbbe 100644
--- a/disas/arm.c
+++ b/disas/arm.c
@@ -1651,7 +1651,7 @@ print_insn_coprocessor (bfd_vma pc, struct disassemble_info *info, long given,
 	}
       else
 	{
-	  /* Only match unconditional instuctions against unconditional
+	  /* Only match unconditional instructions against unconditional
 	     patterns.  */
 	  if ((given & 0xf0000000) == 0xf0000000)
 	    {
-- 
2.7.4
