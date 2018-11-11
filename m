Received: from eggs.gnu.org ([2001:4830:134:3::10]:53317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHg-0003Jz-C2
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHd-0007IV-7V
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:52 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:35281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHc-00079n-TP
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:49 -0500
Received: by mail-wr1-x434.google.com with SMTP id z16-v6so7398825wrv.2
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 15:36:36 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 00:36:14 +0100
Message-Id: <20181111233622.8976-4-f4bug@amsat.org>
In-Reply-To: <20181111233622.8976-1-f4bug@amsat.org>
References: <20181111233622.8976-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 03/11] target/mips: Move the !ISA_MIPS32R6
 check out of decode_opc_special2_legacy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 60320cbe69..f5e8d0b4d2 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -25649,8 +25649,6 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     int rs, rt, rd;
     uint32_t op1;
 
-    check_insn_opc_removed(ctx, ISA_MIPS32R6);
-
     rs = (ctx->opcode >> 21) & 0x1f;
     rt = (ctx->opcode >> 16) & 0x1f;
     rd = (ctx->opcode >> 11) & 0x1f;
@@ -27890,6 +27888,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         } else if (ctx->insn_flags & ASE_MXU) {
             decode_opc_mxu(env, ctx);
         } else {
+            check_insn_opc_removed(ctx, ISA_MIPS32R6);
             decode_opc_special2_legacy(env, ctx);
         }
         break;
-- 
2.17.2
