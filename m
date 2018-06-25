Received: from eggs.gnu.org ([2001:4830:134:3::10]:58164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fXXl2-0002fd-N5
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fXXl0-0002OD-W4
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:06:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:40248 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fXXl0-0002MP-Ns
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:06:38 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 25 Jun 2018 22:06:03 +0200
Message-Id: <1529957164-4744-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1529957164-4744-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1529957164-4744-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/9] target/mips: Fix data type for offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Yongbok Kim <yongbok.kim@mips.com>

Offset can be larger than 16 bit from nanoMIPS,
and immediate field can be larger than 16 bits as well.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 target/mips/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e923d27..20b43c0 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2112,7 +2112,7 @@ OP_ST_ATOMIC(scd,st64,ld64,0x7);
 #undef OP_ST_ATOMIC
=20
 static void gen_base_offset_addr (DisasContext *ctx, TCGv addr,
-                                  int base, int16_t offset)
+                                  int base, int offset)
 {
     if (base =3D=3D 0) {
         tcg_gen_movi_tl(addr, offset);
@@ -2140,7 +2140,7 @@ static target_ulong pc_relative_pc (DisasContext *c=
tx)
=20
 /* Load */
 static void gen_ld(DisasContext *ctx, uint32_t opc,
-                   int rt, int base, int16_t offset)
+                   int rt, int base, int offset)
 {
     TCGv t0, t1, t2;
     int mem_idx =3D ctx->mem_idx;
@@ -2337,7 +2337,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
=20
 /* Store */
 static void gen_st (DisasContext *ctx, uint32_t opc, int rt,
-                    int base, int16_t offset)
+                    int base, int offset)
 {
     TCGv t0 =3D tcg_temp_new();
     TCGv t1 =3D tcg_temp_new();
@@ -2505,7 +2505,7 @@ static void gen_cop1_ldst(DisasContext *ctx, uint32=
_t op, int rt,
=20
 /* Arithmetic with immediate operand */
 static void gen_arith_imm(DisasContext *ctx, uint32_t opc,
-                          int rt, int rs, int16_t imm)
+                          int rt, int rs, int imm)
 {
     target_ulong uimm =3D (target_long)imm; /* Sign extend to 32/64 bits=
 */
=20
--=20
2.7.4
