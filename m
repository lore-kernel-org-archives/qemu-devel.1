Received: from eggs.gnu.org ([2001:4830:134:3::10]:55105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0Xk-0001KU-UK
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0Xg-0005Na-NQ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:44:04 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46890 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gB0Xg-00059E-EU
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:44:00 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 12 Oct 2018 18:39:30 +0200
Message-Id: <1539362376-12010-23-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 22/28] target/mips: Add CP0 Config2 to
 DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Stefan Markovic <smarkovic@wavecomp.com>

Add field corresponding to CP0 Config2 to DisasContext. This is
needed for availability control via Config2 bits.

Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e7bc3d4..9e4aae5 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1449,6 +1449,7 @@ typedef struct DisasContext {
     uint32_t opcode;
     int insn_flags;
     int32_t CP0_Config1;
+    int32_t CP0_Config2;
     int32_t CP0_Config3;
     int32_t CP0_Config5;
     /* Routine used to access memory */
@@ -25517,6 +25518,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->saved_pc = -1;
     ctx->insn_flags = env->insn_flags;
     ctx->CP0_Config1 = env->CP0_Config1;
+    ctx->CP0_Config2 = env->CP0_Config2;
     ctx->CP0_Config3 = env->CP0_Config3;
     ctx->CP0_Config5 = env->CP0_Config5;
     ctx->btarget = 0;
-- 
2.7.4
