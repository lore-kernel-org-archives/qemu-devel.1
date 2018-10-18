Received: from eggs.gnu.org ([2001:4830:134:3::10]:44539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDDMg-0000uP-5t
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDDMd-0005xT-F6
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:49:45 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56957 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gDDMd-0005eo-7L
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:49:43 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 18 Oct 2018 20:47:44 +0200
Message-Id: <1539888473-16340-20-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539888473-16340-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539888473-16340-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 19/28] target/mips: Add CP0 Config2 to
 DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add field corresponding to CP0 Config2 to DisasContext. This is
needed for availability control via Config2 bits.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 1f10f48..e26d54a 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1988,6 +1988,7 @@ typedef struct DisasContext {
     uint32_t opcode;
     uint64_t insn_flags;
     int32_t CP0_Config1;
+    int32_t CP0_Config2;
     int32_t CP0_Config3;
     int32_t CP0_Config5;
     /* Routine used to access memory */
@@ -25835,6 +25836,7 @@ static void mips_tr_init_disas_context(DisasConte=
xtBase *dcbase, CPUState *cs)
     ctx->saved_pc =3D -1;
     ctx->insn_flags =3D env->insn_flags;
     ctx->CP0_Config1 =3D env->CP0_Config1;
+    ctx->CP0_Config2 =3D env->CP0_Config2;
     ctx->CP0_Config3 =3D env->CP0_Config3;
     ctx->CP0_Config5 =3D env->CP0_Config5;
     ctx->btarget =3D 0;
--=20
2.7.4
