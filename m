Received: from eggs.gnu.org ([2001:4830:134:3::10]:43801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFjT5-0006Ss-Ol
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFjT2-0006PP-Dr
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:30:47 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:32893)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gFjT1-0006M9-Qq
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:30:44 -0400
Date: Thu, 25 Oct 2018 19:30:32 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <a60d093678ab59a6a63c3d6e259f34363791be96.1540487815.git.noring@nocrew.org>
References: <cover.1540487815.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540487815.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH 02/11] target/mips: R5900 LQ and SQ also belong
 to the Toshiba MMI ASE
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
index 8547a6e6f6..18167df26d 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -26100,7 +26100,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_SPECIAL3:
-        if (ctx->insn_flags & INSN_R5900) {
+        if ((ctx->insn_flags & INSN_R5900) &&
+            (ctx->insn_flags & ASE_TOSHIBA_MMI)) {
             decode_tx79_sq(env, ctx);    /* TX79_SQ */
         } else {
             decode_opc_special3(env, ctx);
@@ -26764,7 +26765,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_MSA: /* OPC_MDMX */
-        if (ctx->insn_flags & INSN_R5900) {
+        if ((ctx->insn_flags & INSN_R5900) &&
+            (ctx->insn_flags & ASE_TOSHIBA_MMI)) {
             decode_tx79_lq(env, ctx);    /* TX79_LQ */
         } else {
             /* MDMX: Not implemented. */
-- 
2.18.1
