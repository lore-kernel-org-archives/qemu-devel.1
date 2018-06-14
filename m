Received: from eggs.gnu.org ([2001:4830:134:3::10]:37239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyt-0007EL-CI
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyr-00063P-4u
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:27 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:35331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTXyq-000632-V4
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:25 -0400
Received: by mail-pl0-x243.google.com with SMTP id k1-v6so4083772plt.2
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:32:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Jun 2018 09:31:46 -1000
Message-Id: <20180614193147.29680-18-richard.henderson@linaro.org>
In-Reply-To: <20180614193147.29680-1-richard.henderson@linaro.org>
References: <20180614193147.29680-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 17/18] translate-all: remove tb_lock mention
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

tb_lock was needed when the function did retranslation. However,
since fca8a500d519 ("tcg: Save insn data and use it in
cpu_restore_state_from_tb") we don't do retranslation.

Get rid of the comment.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 41fbf1055a..dc36349fc7 100644
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
2.17.1
