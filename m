Received: from eggs.gnu.org ([2001:4830:134:3::10]:59786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5Q-0003Zd-9l
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFgv3-00083Q-De
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:30 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45927)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFgv2-0007qD-N8
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:29 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:45:56 -0400
Message-Id: <20181025144644.15464-23-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 23/71] riscv: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <alistair23@gmail.com>

Cc: Michael Clark <mjc@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <alistair23@gmail.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/riscv/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index aec7558e1b..b5c32241dd 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -736,7 +736,7 @@ void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = CPU(riscv_env_get_cpu(env));
 
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cs->exception_index = EXCP_HLT;
     cpu_loop_exit(cs);
 }
-- 
2.17.1
