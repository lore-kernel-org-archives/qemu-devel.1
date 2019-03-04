Received: from eggs.gnu.org ([209.51.188.92]:44248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAO-000894-De
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAN-0000eu-Kc
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:20 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46699)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0sAN-0000dH-DH
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:19 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  4 Mar 2019 13:17:11 -0500
Message-Id: <20190304181813.8075-12-cota@braap.org>
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
References: <20190304181813.8075-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 11/73] hppa: convert to helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/hppa/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b4fd307b77..3c83a0c5b6 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2662,8 +2662,7 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf *a)
 
             /* Tell the qemu main loop to halt until this cpu has work.  */
             tmp = tcg_const_i32(1);
-            tcg_gen_st_i32(tmp, cpu_env, -offsetof(HPPACPU, env) +
-                                         offsetof(CPUState, halted));
+            gen_helper_cpu_halted_set(cpu_env, tmp);
             tcg_temp_free_i32(tmp);
             gen_excp_1(EXCP_HALTED);
             ctx->base.is_jmp = DISAS_NORETURN;
-- 
2.17.1
