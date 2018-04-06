Received: from eggs.gnu.org ([2001:4830:134:3::10]:58480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4GsN-0002Ga-2C
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f4GsL-0003X3-5U
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:13:14 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f4GsK-0003WY-Tw
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 22:13:12 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu,  5 Apr 2018 22:13:07 -0400
Message-Id: <1522980788-1252-17-git-send-email-cota@braap.org>
In-Reply-To: <1522980788-1252-1-git-send-email-cota@braap.org>
References: <1522980788-1252-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 16/17] translate-all: remove tb_lock mention
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

tb_lock was needed when the function did retranslation. However,
since fca8a500d519 ("tcg: Save insn data and use it in
cpu_restore_state_from_tb") we don't do retranslation.

Get rid of the comment.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 486c9df..62e5796 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -354,9 +354,7 @@ static int encode_search(TranslationBlock *tb, uint8_t *block)
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
