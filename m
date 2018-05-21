Received: from eggs.gnu.org ([2001:4830:134:3::10]:57864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOu-0002eT-Pf
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOr-0005Z8-C2
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:36 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fKuOq-0005Xz-M7
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:33 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 21 May 2018 19:39:26 -0400
Message-Id: <1526945967-9687-17-git-send-email-cota@braap.org>
In-Reply-To: <1526945967-9687-1-git-send-email-cota@braap.org>
References: <1526945967-9687-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 16/17] translate-all: remove tb_lock mention
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
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

tb_lock was needed when the function did retranslation. However,
since fca8a500d519 ("tcg: Save insn data and use it in
cpu_restore_state_from_tb") we don't do retranslation.

Get rid of the comment.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 031060f..6cc7b94 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -355,7 +355,6 @@ static int encode_search(TranslationBlock *tb, uint8_t *block)
 }
 
 /* The cpu state corresponding to 'searched_pc' is restored.
- * Called with tb_lock held.
  * When reset_icount is true, current TB will be interrupted and
  * icount should be recalculated.
  */
-- 
2.7.4
