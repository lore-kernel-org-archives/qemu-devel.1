Received: from eggs.gnu.org ([2001:4830:134:3::10]:55035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPOG-0006fC-LI
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPOF-00014X-Rg
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:21:00 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cRPOF-00013M-LU
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:59 -0500
Received: by mail-wm0-x243.google.com with SMTP id l2so568801wml.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:20:59 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 11 Jan 2017 21:19:45 +0100
Message-Id: <6139718b8d11c9c893d6deb02431c615ef422d65.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH v2 14/30] target-sparc: fix immediate UA2005
 traps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7e399a3..23d4673 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3298,7 +3298,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
 
                 rs1 = GET_FIELD_SP(insn, 14, 18);
                 if (IS_IMM) {
-                    rs2 = GET_FIELD_SP(insn, 0, 6);
+                    rs2 = GET_FIELD_SP(insn, 0, 7);
                     if (rs1 == 0) {
                         tcg_gen_movi_i32(trap, (rs2 & mask) + TT_TRAP);
                         /* Signal that the trap value is fully constant.  */
-- 
1.8.3.1
