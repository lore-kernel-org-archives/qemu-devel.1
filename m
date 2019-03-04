Received: from eggs.gnu.org ([209.51.188.92]:44573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAm-0008Rx-01
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAk-0001HH-5U
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:43 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46737)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0sAj-0000xW-TH
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:42 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  4 Mar 2019 13:17:24 -0500
Message-Id: <20190304181813.8075-25-cota@braap.org>
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
References: <20190304181813.8075-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v7 24/73] riscv: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <alistair23@gmail.com>

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <alistair23@gmail.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/riscv/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index b7dc18a41e..7732b4ba32 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -135,7 +135,7 @@ void helper_wfi(CPURISCVState *env)
         get_field(env->mstatus, MSTATUS_TW)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
         cs->exception_index = EXCP_HLT;
         cpu_loop_exit(cs);
     }
-- 
2.17.1
