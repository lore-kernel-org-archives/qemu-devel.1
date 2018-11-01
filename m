Received: from eggs.gnu.org ([2001:4830:134:3::10]:40983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIGs4-0002Rk-Db
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gIGrz-0000qK-Rh
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:35:04 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:54720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gIGrz-0000q4-KM
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:34:59 -0400
Date: Thu, 1 Nov 2018 18:34:44 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <a8655d209c470f972943cbed44a193d815f0afd7.1541093316.git.noring@nocrew.org>
References: <cover.1541093316.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1541093316.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v2 03/12] target/mips: R5900 LQ and SQ also
 belong to the Toshiba MMI ASE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6e5a8a2565..624e53644d 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -27992,7 +27992,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_SPECIAL3:
-        if (ctx->insn_flags & INSN_R5900) {
+        if ((ctx->insn_flags & INSN_R5900) &&
+            (ctx->insn_flags & ASE_MMI)) {
             decode_tx79_sq(env, ctx);    /* TX79_SQ */
         } else {
             decode_opc_special3(env, ctx);
@@ -28656,7 +28657,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_MSA: /* OPC_MDMX */
-        if (ctx->insn_flags & INSN_R5900) {
+        if ((ctx->insn_flags & INSN_R5900) &&
+            (ctx->insn_flags & ASE_MMI)) {
             decode_tx79_lq(env, ctx);    /* TX79_LQ */
         } else {
             /* MDMX: Not implemented. */
-- 
2.18.1
