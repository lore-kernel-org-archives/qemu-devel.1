Received: from eggs.gnu.org ([2001:4830:134:3::10]:55509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILwQ-0004Kb-CX
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILwO-00008l-Pp
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:38 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:44341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILwO-000085-Jc
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:36 -0400
Received: by mail-pg0-x242.google.com with SMTP id x145-v6so6070720pgx.11
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:27:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:27:14 -0700
Message-Id: <20180514222714.7982-14-richard.henderson@linaro.org>
In-Reply-To: <20180514222714.7982-1-richard.henderson@linaro.org>
References: <20180514222714.7982-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 13/13] target/openrisc: Merge disas_openrisc_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, peter.maydell@linaro.org

Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 1f87ad6b2e..e7c96ca990 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1373,14 +1373,6 @@ static bool trans_lf_sfle_s(DisasContext *dc, arg_ab *a, uint32_t insn)
     return true;
 }
 
-static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
-{
-    uint32_t insn = cpu_ldl_code(&cpu->env, dc->base.pc_next);
-    if (!decode(dc, insn)) {
-        gen_illegal_exception(dc);
-    }
-}
-
 static void openrisc_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
 {
     DisasContext *dc = container_of(dcb, DisasContext, base);
@@ -1435,8 +1427,11 @@ static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
+    uint32_t insn = cpu_ldl_code(&cpu->env, dc->base.pc_next);
 
-    disas_openrisc_insn(dc, cpu);
+    if (!decode(dc, insn)) {
+        gen_illegal_exception(dc);
+    }
     dc->base.pc_next += 4;
 
     /* delay slot */
-- 
2.17.0
