Received: from eggs.gnu.org ([209.51.188.92]:44643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAp-00005K-Qi
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAl-0001Kb-Rc
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:45 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0sAk-0000xX-1y
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:42 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  4 Mar 2019 13:17:22 -0500
Message-Id: <20190304181813.8075-23-cota@braap.org>
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
References: <20190304181813.8075-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 22/73] m68k: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>

Cc: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/m68k/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 76f439985a..9f717dfec1 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -237,7 +237,7 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
                 do_m68k_semihosting(env, env->dregs[0]);
                 return;
             }
-            cs->halted = 1;
+            cpu_halted_set(cs, 1);
             cs->exception_index = EXCP_HLT;
             cpu_loop_exit(cs);
             return;
-- 
2.17.1
