Received: from eggs.gnu.org ([2001:4830:134:3::10]:43684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFjT3-0006QY-9i
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gFjSz-0006Na-TE
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:30:45 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35993)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gFjSx-0006Ip-SZ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:30:41 -0400
Date: Thu, 25 Oct 2018 19:30:11 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <658cb95479c9b6debebe43ec06ff498ebf624653.1540487815.git.noring@nocrew.org>
References: <cover.1540487815.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540487815.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH 01/11] target/mips: Rename ASE_MMI to
 ASE_TOSHIBA_MMI, with Toshiba namespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Several vendors have multimedia instruction (MMI) sets and other
extensions of various kinds. ASE vendor namespaces make it clear these
are not generic architectural features and also avoid name clashes.

Reported-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/mips-defs.h          | 2 +-
 target/mips/translate.c          | 3 ++-
 target/mips/translate_init.inc.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index 5177618615..30b07e0bde 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -68,7 +68,7 @@
 /*
  *   bits 56-63: vendor-specific ASEs
  */
-#define ASE_MMI           0x0100000000000000ULL
+#define ASE_TOSHIBA_MMI   0x0100000000000000ULL
 
 /* MIPS CPU defines. */
 #define		CPU_MIPS1	(ISA_MIPS1)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index c44a751be9..8547a6e6f6 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -26092,7 +26092,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         decode_opc_special(env, ctx);
         break;
     case OPC_SPECIAL2:
-        if ((ctx->insn_flags & INSN_R5900) && (ctx->insn_flags & ASE_MMI)) {
+        if ((ctx->insn_flags & INSN_R5900) &&
+            (ctx->insn_flags & ASE_TOSHIBA_MMI)) {
             decode_tx79_mmi(env, ctx);
         } else {
             decode_opc_special2_legacy(env, ctx);
diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index 85da4a269c..5cd968366b 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -466,7 +466,7 @@ const mips_def_t mips_defs[] =
 #endif /* !CONFIG_USER_ONLY */
         .SEGBITS = 32,
         .PABITS = 32,
-        .insn_flags = CPU_R5900 | ASE_MMI,
+        .insn_flags = CPU_R5900 | ASE_TOSHIBA_MMI,
         .mmu_type = MMU_TYPE_R4000,
     },
     {
-- 
2.18.1
