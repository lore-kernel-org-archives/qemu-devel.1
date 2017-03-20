Received: from eggs.gnu.org ([2001:4830:134:3::10]:45653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvV-0003uk-OS
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvS-00070J-8o
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:45 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:1624)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvS-0006z0-2W
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:42 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Mon, 20 Mar 2017 13:00:18 +0000
Message-ID: <1490014826-4472-3-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
References: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for v2.9 02/10] target-mips: remove old &
 unuseful comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/translate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 8b4a072..1fe0ff3 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5137,7 +5137,6 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, i=
nt reg, int sel)
 //            gen_helper_mfc0_contextconfig(arg); /* SmartMIPS ASE */
             rn =3D "ContextConfig";
             goto cp0_unimplemented;
-//            break;
         case 2:
             CP0_CHECK(ctx->ulri);
             tcg_gen_ld32s_tl(arg, cpu_env,
@@ -5791,7 +5790,6 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, i=
nt reg, int sel)
 //            gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS =
ASE */
             rn =3D "ContextConfig";
             goto cp0_unimplemented;
-//            break;
         case 2:
             CP0_CHECK(ctx->ulri);
             tcg_gen_st_tl(arg, cpu_env,
@@ -6454,7 +6452,6 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
 //            gen_helper_dmfc0_contextconfig(arg); /* SmartMIPS ASE */
             rn =3D "ContextConfig";
             goto cp0_unimplemented;
-//            break;
         case 2:
             CP0_CHECK(ctx->ulri);
             tcg_gen_ld_tl(arg, cpu_env,
@@ -7092,7 +7089,6 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
 //           gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS A=
SE */
             rn =3D "ContextConfig";
             goto cp0_unimplemented;
-//           break;
         case 2:
             CP0_CHECK(ctx->ulri);
             tcg_gen_st_tl(arg, cpu_env,
--=20
2.7.4
