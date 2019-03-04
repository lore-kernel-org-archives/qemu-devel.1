Received: from eggs.gnu.org ([209.51.188.92]:44406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAZ-0008K9-B7
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAY-0000zT-KP
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:31 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:40093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0sAY-0000fD-AE
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:30 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  4 Mar 2019 13:17:14 -0500
Message-Id: <20190304181813.8075-15-cota@braap.org>
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
References: <20190304181813.8075-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 14/73] microblaze: convert to
 helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/microblaze/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 78ca265b04..008b84d456 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1233,9 +1233,7 @@ static void dec_br(DisasContext *dc)
             LOG_DIS("sleep\n");
 
             t_sync_flags(dc);
-            tcg_gen_st_i32(tmp_1, cpu_env,
-                           -offsetof(MicroBlazeCPU, env)
-                           +offsetof(CPUState, halted));
+            gen_helper_cpu_halted_set(cpu_env, tmp_1);
             tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc + 4);
             gen_helper_raise_exception(cpu_env, tmp_hlt);
             tcg_temp_free_i32(tmp_hlt);
-- 
2.17.1
