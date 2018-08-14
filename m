Received: from eggs.gnu.org ([2001:4830:134:3::10]:51523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpdtL-0003NR-Lq
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpdsq-0005tY-43
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:03 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50094 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpdsp-0005bf-Pk
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:17:32 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 14 Aug 2018 20:16:47 +0200
Message-Id: <1534270621-27332-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534270621-27332-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534270621-27332-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/19] target/mips: Fix two instances of shadow
 variables
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

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix two instances of shadow variables. This cleans up entire file
translate.c from shadow variables.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3dd66b6..2b70d1b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -13276,7 +13276,7 @@ static void gen_pool16c_r6_insn(DisasContext *ctx=
)
             gen_arith_imm(ctx, OPC_ADDIU, 29, 29, imm << 2);
         } else {
             /* JRC16 */
-            int rs =3D extract32(ctx->opcode, 5, 5);
+            rs =3D extract32(ctx->opcode, 5, 5);
             gen_compute_branch(ctx, OPC_JR, 2, rs, 0, 0, 0);
         }
         break;
@@ -15298,7 +15298,7 @@ static void decode_micromips32_opc(CPUMIPSState *=
env, DisasContext *ctx)
         } else {
             /* ADDIUPC */
             int reg =3D mmreg(ZIMM(ctx->opcode, 23, 3));
-            int offset =3D SIMM(ctx->opcode, 0, 23) << 2;
+            offset =3D SIMM(ctx->opcode, 0, 23) << 2;
=20
             gen_addiupc(ctx, reg, offset, 0, 0);
         }
--=20
2.7.4
