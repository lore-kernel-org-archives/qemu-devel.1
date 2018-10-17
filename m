Received: from eggs.gnu.org ([2001:4830:134:3::10]:44575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2k-0001ia-9q
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2h-0006eN-6h
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:18 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39284 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gCl2g-0006cZ-RK
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:15 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 17 Oct 2018 14:33:37 +0200
Message-Id: <1539779635-15445-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/27] target/mips: Add basic description of MXU
 ASE
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

Add a comment that contains a basic description of MXU ASE.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index ab16cdb..46655bb 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1389,6 +1389,26 @@ enum {
     OPC_BINSRI_df   =3D (0x7 << 23) | OPC_MSA_BIT_09,
 };
=20
+
+/*
+ *    AN OVERVIEW OF MXU EXTENSION INSTRUCTION SET
+ *    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ *
+ * MXU (full name: MIPS eXtension/enhanced Unit) is an SIMD extension of=
 MIPS32
+ * instructions set. It is designed to fit the needs of signal, graphica=
l and
+ * video processing applications. MXU instruction set is used in Xburst =
family
+ * of microprocessors by Ingenic.
+ *
+ * MXU unit contains 17 registers called X0-X16. X0 is always zero, and =
X16 is
+ * the control register.
+ *
+ *   Compiled after:
+ *
+ *   "XBurst=C2=AE Instruction Set Architecture MIPS eXtension/enhanced =
Unit
+ *   Programming Manual", Ingenic Semiconductor Co, Ltd., 2017
+ */
+
+
 /* global register indices */
 static TCGv cpu_gpr[32], cpu_PC;
 static TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
--=20
2.7.4
