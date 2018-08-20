Received: from eggs.gnu.org ([2001:4830:134:3::10]:44884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1froy8-0000xb-I9
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1frokz-0001fK-DQ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:18:28 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:51288 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1froky-0001UZ-LR
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:18:24 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 20 Aug 2018 20:16:32 +0200
Message-Id: <1534789014-8310-25-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v11 24/46] target/mips: Add CP0 Config3 and
 Config5 fields to DisasContext structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, dnikolic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Dimitrije Nikolic <dnikolic@wavecomp.com>

Add CP0_Config3 and CP0_Config5 to DisasContext structure. This is
needed for implementing availability control of various instructions.

Signed-off-by: "Aleksandar Markovic <amarkovic@wavecomp.com>"
---
 target/mips/translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 076f4bf..f0c50cb 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1449,6 +1449,8 @@ typedef struct DisasContext {
     uint32_t opcode;
     int insn_flags;
     int32_t CP0_Config1;
+    int32_t CP0_Config3;
+    int32_t CP0_Config5;
     /* Routine used to access memory */
     int mem_idx;
     TCGMemOp default_tcg_memop_mask;
@@ -23305,6 +23307,8 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->saved_pc = -1;
     ctx->insn_flags = env->insn_flags;
     ctx->CP0_Config1 = env->CP0_Config1;
+    ctx->CP0_Config3 = env->CP0_Config3;
+    ctx->CP0_Config5 = env->CP0_Config5;
     ctx->btarget = 0;
     ctx->kscrexist = (env->CP0_Config4 >> CP0C4_KScrExist) & 0xff;
     ctx->rxi = (env->CP0_Config3 >> CP0C3_RXI) & 1;
-- 
2.7.4
