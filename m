Received: from eggs.gnu.org ([2001:4830:134:3::10]:45519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFlv-0001Gn-9H
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFls-0002Xv-4D
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:36:07 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:47116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFlr-0002XL-Ss
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:36:04 -0400
Date: Sun, 21 Oct 2018 17:35:56 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <0ba3063224451c254c947a4056e23ae7c39f2eca.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 11/38] target/mips: Placeholder for R5900
 MMI LQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 19a8abad54..2318116d31 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24420,6 +24420,11 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+static void decode_tx79_lq(CPUMIPSState *env, DisasContext *ctx)
+{
+    generate_exception_end(ctx, EXCP_RI);    /* TODO: TX79_LQ */
+}
+
 static void gen_tx79_sq(DisasContext *ctx, int base, int rt, int offset)
 {
     generate_exception_end(ctx, EXCP_RI);    /* TODO: TX79_SQ */
@@ -26425,8 +26430,12 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_MSA: /* OPC_MDMX */
-        /* MDMX: Not implemented. */
-        gen_msa(env, ctx);
+        if (ctx->insn_flags & INSN_R5900) {
+            decode_tx79_lq(env, ctx);    /* TX79_LQ */
+        } else {
+            /* MDMX: Not implemented. */
+            gen_msa(env, ctx);
+        }
         break;
     case OPC_PCREL:
         check_insn(ctx, ISA_MIPS32R6);
-- 
2.18.1
