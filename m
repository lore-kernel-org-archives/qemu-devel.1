Received: from eggs.gnu.org ([2001:4830:134:3::10]:47746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpL-0005yG-Am
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpG-0005hi-K3
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59407)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1derpG-0005gs-E8
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  7 Aug 2017 19:52:17 -0400
Message-Id: <1502149958-23381-2-git-send-email-cota@braap.org>
In-Reply-To: <1502149958-23381-1-git-send-email-cota@braap.org>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 01/22] disas/arm: fix 'instuction' typo in
 comment
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
