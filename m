Received: from eggs.gnu.org ([2001:4830:134:3::10]:58798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFY-0004bE-GS
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFX-00030v-5u
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:48 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33649)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFW-0002jk-Ko
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:05:36 -0400
Message-Id: <20181019010625.25294-8-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 07/56] target/m68k: rename cpu_halted to
 cpu_halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>

To avoid a name clash with the soon-to-be-defined cpu_halted() helper.

Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/m68k/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ae3651b867..86491048f8 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -43,7 +43,7 @@
 #undef DEFO32
 #undef DEFO64
 
-static TCGv_i32 cpu_halted;
+static TCGv_i32 cpu_halt;
 static TCGv_i32 cpu_exception_index;
 
 static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
@@ -79,7 +79,7 @@ void m68k_tcg_init(void)
 #undef DEFO32
 #undef DEFO64
 
-    cpu_halted = tcg_global_mem_new_i32(cpu_env,
+    cpu_halt = tcg_global_mem_new_i32(cpu_env,
                                         -offsetof(M68kCPU, env) +
                                         offsetof(CPUState, halted), "HALTED");
     cpu_exception_index = tcg_global_mem_new_i32(cpu_env,
@@ -4646,7 +4646,7 @@ DISAS_INSN(stop)
     ext = read_im16(env, s);
 
     gen_set_sr_im(s, ext, 0);
-    tcg_gen_movi_i32(cpu_halted, 1);
+    tcg_gen_movi_i32(cpu_halt, 1);
     gen_exception(s, s->pc, EXCP_HLT);
 }
 
-- 
2.17.1
