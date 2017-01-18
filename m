Received: from eggs.gnu.org ([2001:4830:134:3::10]:36966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytB-0006an-M6
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytB-0002oA-0E
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:33 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTytA-0002nr-Qb
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:32 -0500
Received: by mail-wm0-x242.google.com with SMTP id d140so7556941wmd.2
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:32 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:27 +0100
Message-Id: <1484779123-18968-15-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PULL 14/30] target-sparc: fix immediate UA2005 traps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, rth@twiddle.net, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 399a8ac..1099976 100644
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
2.7.2
