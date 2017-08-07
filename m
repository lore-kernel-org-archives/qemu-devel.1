Received: from eggs.gnu.org ([2001:4830:134:3::10]:47879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpR-0005yw-7N
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpJ-0005lI-LW
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43719)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1derpJ-0005kx-Hx
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  7 Aug 2017 19:52:37 -0400
Message-Id: <1502149958-23381-22-git-send-email-cota@braap.org>
In-Reply-To: <1502149958-23381-1-git-send-email-cota@braap.org>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 21/22] translate-all: remove tb_lock mention
 from cpu_restore_state_from_tb
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

tb_lock was needed when the function did retranslation. However,
since fca8a500d519 ("tcg: Save insn data and use it in
cpu_restore_state_from_tb") we don't do retranslation.

Get rid of the comment.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index dc19217..863b418 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -376,9 +376,7 @@ static int encode_search(TranslationBlock *tb, uint8_t *block)
     return p - block;
 }
 
-/* The cpu state corresponding to 'searched_pc' is restored.
- * Called with tb_lock held.
- */
+/* The cpu state corresponding to 'searched_pc' is restored */
 static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                      uintptr_t searched_pc)
 {
-- 
2.7.4
