Received: from eggs.gnu.org ([2001:4830:134:3::10]:56582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEzPC-0005ys-5g
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEzPB-0000tG-8P
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:19:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44942 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEzPA-0000ra-T9
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:19:41 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 23 Oct 2018 18:18:15 +0200
Message-Id: <1540311509-23970-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540311509-23970-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540311509-23970-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 04/18] target/mips: Add and integrate MXU
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

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index fefe9ac..128cabe 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23844,6 +23844,12 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
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
@@ -26087,6 +26093,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
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
