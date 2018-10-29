Received: from eggs.gnu.org ([2001:4830:134:3::10]:48648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH5gn-00087I-K2
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH5gi-0003Cv-1h
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:26:33 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:32792 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH5gf-000332-2Q
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:26:26 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 12:25:12 +0100
Message-Id: <1540812328-16163-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 04/20] target/mips: Add and integrate MXU
 decoding engine placeholder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, jancraig@amazon.com, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Provide the placeholder and add the invocation logic for MXU
decoding engine.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 9f6200a..265fac6 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23976,6 +23976,12 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+static void decode_opc_mxu(CPUMIPSState *env, DisasContext *ctx)
+{
+    MIPS_INVAL("decode_opc_mxu");
+    generate_exception_end(ctx, EXCP_RI);
+}
+
 static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd;
@@ -26219,6 +26225,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
     case OPC_SPECIAL2:
         if ((ctx->insn_flags & INSN_R5900) && (ctx->insn_flags & ASE_MMI)) {
             decode_tx79_mmi(env, ctx);
+        } else if (ctx->insn_flags & ASE_MXU) {
+            decode_opc_mxu(env, ctx);
         } else {
             decode_opc_special2_legacy(env, ctx);
         }
-- 
2.7.4
