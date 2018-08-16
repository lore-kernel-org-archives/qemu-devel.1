Received: from eggs.gnu.org ([2001:4830:134:3::10]:55936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJkz-0005Kt-9p
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJkt-0000cP-0j
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:11 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58732 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqJkq-0008WC-7F
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:06 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 16 Aug 2018 16:56:57 +0200
Message-Id: <1534431497-1385-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 04/84] target/mips: Mark switch fallthroughs
 with interpretable comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Mark switch fallthroughs with comments, in cases fallthroughs
are intentional.

The comments "/* fall through */" are interpreted by compilers and
other tools, and they will not issue warnings in such cases. For gcc,
the warning is turnend on by -Wimplicit-fallthrough. With this patch,
there will be no such warnings in target/mips directory. If such
warning appears in future, it should be checked if it is intentional,
and, if yes, marked with a comment similar to those from this patch.

The comment must be just before next "case", otherwise gcc won't
understand it.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index b944ea2..3dd66b6 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -14290,8 +14290,8 @@ static void decode_micromips32_opc(CPUMIPSState *=
env, DisasContext *ctx)
         case SDP:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
-            /* Fallthrough */
 #endif
+            /* fall through */
         case LWP:
         case SWP:
             gen_ldst_pair(ctx, minor, rt, rs, SIMM(ctx->opcode, 0, 12));
@@ -14301,8 +14301,8 @@ static void decode_micromips32_opc(CPUMIPSState *=
env, DisasContext *ctx)
         case SDM:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
-            /* Fallthrough */
 #endif
+            /* fall through */
         case LWM32:
         case SWM32:
             gen_ldst_multiple(ctx, minor, rt, rs, SIMM(ctx->opcode, 0, 1=
2));
@@ -20087,6 +20087,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
         case OPC_MTHC1:
             check_cp1_enabled(ctx);
             check_insn(ctx, ISA_MIPS32R2);
+            /* fall through */
         case OPC_MFC1:
         case OPC_CFC1:
         case OPC_MTC1:
--=20
2.7.4
