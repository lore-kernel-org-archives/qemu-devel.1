Received: from eggs.gnu.org ([2001:4830:134:3::10]:55538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZ2-00080e-6J
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZ1-0006nb-K6
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:32 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVZ1-0006nO-HE
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:31 -0500
Received: by mail-qk0-x241.google.com with SMTP id u25so944038qki.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:31 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:55:50 -0800
Message-Id: <20170112025606.27332-15-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 14/30] target-sparc: fix immediate UA2005 traps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

From: Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <6139718b8d11c9c893d6deb02431c615ef422d65.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
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
2.9.3
