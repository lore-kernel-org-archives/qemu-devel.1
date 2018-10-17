Received: from eggs.gnu.org ([2001:4830:134:3::10]:44643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2p-0001ph-Rl
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2i-0006gJ-LQ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:23 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39442 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gCl2i-0006ek-6T
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:16 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 17 Oct 2018 14:33:39 +0200
Message-Id: <1539779635-15445-12-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/27] target/mips: Add organizational chart of
 MXU ASE
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

Add a comment that contains an organizational chart of MXU ASE
instructions.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 156 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 156 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 91f63f2..45ed1d9 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1490,6 +1490,162 @@ enum {
  *  Q16SCOP XRa, XRb, XRc, XRd        S32M2I XRa, Rb
  *  Q16SAT XRa, XRb, XRc              S32I2M XRa, Rb
  *
+ *
+ *              bits
+ *             05..00
+ *
+ *          =E2=94=8C=E2=94=80 000000 =E2=94=80 OPC_MXU_S32MADD
+ *          =E2=94=9C=E2=94=80 000001 =E2=94=80 OPC_MXU_S32MADDU
+ *          =E2=94=9C=E2=94=80 000010 =E2=94=80 <not assigned>
+ *          =E2=94=82                               20..18  (25..21 must=
 be 0)
+ *          =E2=94=9C=E2=94=80 000011 =E2=94=80 OPC_MXU__POOL00 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_S32MAX
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 001 =
=E2=94=80 OPC_MXU_S32MIN
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 010 =
=E2=94=80 OPC_MXU_D16MAX
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 011 =
=E2=94=80 OPC_MXU_D16MIN
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 100 =
=E2=94=80 OPC_MXU_Q8MAX
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 101 =
=E2=94=80 OPC_MXU_Q8MIN
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 110 =
=E2=94=80 OPC_MXU_Q8SLT
+ *          =E2=94=82                            =E2=94=94=E2=94=80 111 =
=E2=94=80 OPC_MXU_Q8SLTU
+ *          =E2=94=9C=E2=94=80 000100 =E2=94=80 OPC_MXU_S32MSUB
+ *          =E2=94=9C=E2=94=80 000101 =E2=94=80 OPC_MXU_S32MSUBU    20..=
18  (25..21 must be 0,
+ *          =E2=94=82                                         except for=
 Q8ADD)
+ *          =E2=94=9C=E2=94=80 000110 =E2=94=80 OPC_MXU__POOL01 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_S32SLT
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 001 =
=E2=94=80 OPC_MXU_D16SLT
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 010 =
=E2=94=80 OPC_MXU_D16AVG
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 011 =
=E2=94=80 OPC_MXU_D16AVGR
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 100 =
=E2=94=80 OPC_MXU_Q8AVG
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 101 =
=E2=94=80 OPC_MXU_Q8AVGR
+ *          =E2=94=82                            =E2=94=94=E2=94=80 111 =
=E2=94=80 OPC_MXU_Q8ADD
+ *          =E2=94=82
+ *          =E2=94=82                               20..18  (25..21 must=
 be 0)
+ *          =E2=94=9C=E2=94=80 000111 =E2=94=80 OPC_MXU__POOL02 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_S32CPS
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 010 =
=E2=94=80 OPC_MXU_D16CPS
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 100 =
=E2=94=80 OPC_MXU_Q8ABD
+ *          =E2=94=82                            =E2=94=94=E2=94=80 110 =
=E2=94=80 OPC_MXU_Q16SAT
+ *          =E2=94=9C=E2=94=80 001000 =E2=94=80 OPC_MXU_D16MUL
+ *          =E2=94=82                               25..24
+ *          =E2=94=9C=E2=94=80 001001 =E2=94=80 OPC_MXU__POOL03 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_D16MULF
+ *          =E2=94=82                            =E2=94=94=E2=94=80 01 =E2=
=94=80 OPC_MXU_D16MULE
+ *          =E2=94=9C=E2=94=80 001010 =E2=94=80 OPC_MXU_D16MAC
+ *          =E2=94=9C=E2=94=80 001011 =E2=94=80 OPC_MXU_D16MACF
+ *          =E2=94=9C=E2=94=80 001100 =E2=94=80 OPC_MXU_D16MADL
+ *          =E2=94=82                               25..24
+ *          =E2=94=9C=E2=94=80 001101 =E2=94=80 OPC_MXU__POOL04 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_S16MAD
+ *          =E2=94=82                            =E2=94=94=E2=94=80 01 =E2=
=94=80 OPC_MXU_S16MAD_1
+ *          =E2=94=9C=E2=94=80 001110 =E2=94=80 OPC_MXU_Q16ADD
+ *          =E2=94=9C=E2=94=80 001111 =E2=94=80 OPC_MXU_D16MACE
+ *          =E2=94=82                               23
+ *          =E2=94=9C=E2=94=80 010000 =E2=94=80 OPC_MXU__POOL05 =E2=94=80=
=E2=94=AC=E2=94=80 0 =E2=94=80 OPC_MXU_S32LDD
+ *          =E2=94=82                            =E2=94=94=E2=94=80 1 =E2=
=94=80 OPC_MXU_S32LDDR
+ *          =E2=94=82
+ *          =E2=94=82                               23
+ *          =E2=94=9C=E2=94=80 010001 =E2=94=80 OPC_MXU__POOL06 =E2=94=80=
=E2=94=AC=E2=94=80 0 =E2=94=80 OPC_MXU_S32STD
+ *          =E2=94=82                            =E2=94=94=E2=94=80 1 =E2=
=94=80 OPC_MXU_S32STDR
+ *          =E2=94=82
+ *          =E2=94=82                               13..10
+ *          =E2=94=9C=E2=94=80 010010 =E2=94=80 OPC_MXU__POOL07 =E2=94=80=
=E2=94=AC=E2=94=80 0000 =E2=94=80 OPC_MXU_S32LDDV
+ *          =E2=94=82                            =E2=94=94=E2=94=80 0001=
 =E2=94=80 OPC_MXU_S32LDDVR
+ *          =E2=94=82
+ *          =E2=94=82                               13..10
+ *          =E2=94=9C=E2=94=80 010011 =E2=94=80 OPC_MXU__POOL08 =E2=94=80=
=E2=94=AC=E2=94=80 0000 =E2=94=80 OPC_MXU_S32TDV
+ *          =E2=94=82                            =E2=94=94=E2=94=80 0001=
 =E2=94=80 OPC_MXU_S32TDVR
+ *          =E2=94=82
+ *          =E2=94=82                               23
+ *          =E2=94=9C=E2=94=80 010100 =E2=94=80 OPC_MXU__POOL09 =E2=94=80=
=E2=94=AC=E2=94=80 0 =E2=94=80 OPC_MXU_S32LDI
+ *          =E2=94=82                            =E2=94=94=E2=94=80 1 =E2=
=94=80 OPC_MXU_S32LDIR
+ *          =E2=94=82
+ *          =E2=94=82                               23
+ *          =E2=94=9C=E2=94=80 010101 =E2=94=80 OPC_MXU__POOL10 =E2=94=80=
=E2=94=AC=E2=94=80 0 =E2=94=80 OPC_MXU_S32SDI
+ *          =E2=94=82                            =E2=94=94=E2=94=80 1 =E2=
=94=80 OPC_MXU_S32SDIR
+ *          =E2=94=82
+ *          =E2=94=82                               13..10
+ *          =E2=94=9C=E2=94=80 010110 =E2=94=80 OPC_MXU__POOL11 =E2=94=80=
=E2=94=AC=E2=94=80 0000 =E2=94=80 OPC_MXU_S32LDIV
+ *          =E2=94=82                            =E2=94=94=E2=94=80 0001=
 =E2=94=80 OPC_MXU_S32LDIVR
+ *          =E2=94=82
+ *          =E2=94=82                               13..10
+ *          =E2=94=9C=E2=94=80 010111 =E2=94=80 OPC_MXU__POOL12 =E2=94=80=
=E2=94=AC=E2=94=80 0000 =E2=94=80 OPC_MXU_S32SDIV
+ *          =E2=94=82                            =E2=94=94=E2=94=80 0001=
 =E2=94=80 OPC_MXU_S32SDIVR
+ *          =E2=94=9C=E2=94=80 011000 =E2=94=80 OPC_MXU_D32ADD
+ *          =E2=94=82
+ *   MXU    =E2=94=9C=E2=94=80 011001 =E2=94=80 OPC_MXU__POOL13 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_D32ACC
+ * opcodes =E2=94=80=E2=94=A4                            =E2=94=9C=E2=94=
=80 01 =E2=94=80 OPC_MXU_D32ACCM
+ *          =E2=94=82                            =E2=94=94=E2=94=80 10 =E2=
=94=80 OPC_MXU_D32ASUM
+ *          =E2=94=9C=E2=94=80 011010 =E2=94=80 <not assigned>
+ *          =E2=94=82
+ *          =E2=94=9C=E2=94=80 011011 =E2=94=80 OPC_MXU__POOL14 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q16ACC
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 01 =E2=
=94=80 OPC_MXU_Q16ACCM
+ *          =E2=94=82                            =E2=94=94=E2=94=80 10 =E2=
=94=80 OPC_MXU_Q16ASUM
+ *          =E2=94=82
+ *          =E2=94=82
+ *          =E2=94=9C=E2=94=80 011100 =E2=94=80 OPC_MXU__POOL15 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q8ADDE
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 01 =E2=
=94=80 OPC_MXU_D8SUM
+ *          =E2=94=9C=E2=94=80 011101 =E2=94=80 OPC_MXU_Q8ACCE   =E2=94=94=
=E2=94=80 10 =E2=94=80 OPC_MXU_D8SUMC
+ *          =E2=94=9C=E2=94=80 011110 =E2=94=80 <not assigned>
+ *          =E2=94=9C=E2=94=80 011111 =E2=94=80 <not assigned>
+ *          =E2=94=9C=E2=94=80 100000 =E2=94=80 <not assigned>
+ *          =E2=94=9C=E2=94=80 100001 =E2=94=80 <not assigned>
+ *          =E2=94=9C=E2=94=80 100010 =E2=94=80 OPC_MXU_S8LDD
+ *          =E2=94=9C=E2=94=80 100011 =E2=94=80 OPC_MXU_S8STD
+ *          =E2=94=9C=E2=94=80 100100 =E2=94=80 OPC_MXU_S8LDI
+ *          =E2=94=9C=E2=94=80 100101 =E2=94=80 OPC_MXU_S8SDI
+ *          =E2=94=82
+ *          =E2=94=9C=E2=94=80 100110 =E2=94=80 OPC_MXU__POOL16 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_S32MUL
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 00 =E2=
=94=80 OPC_MXU_S32MULU
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 00 =E2=
=94=80 OPC_MXU_S32EXTR
+ *          =E2=94=82                            =E2=94=94=E2=94=80 00 =E2=
=94=80 OPC_MXU_S32EXTRV
+ *          =E2=94=82
+ *          =E2=94=82
+ *          =E2=94=9C=E2=94=80 100111 =E2=94=80 OPC_MXU__POOL17 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_D32SARW
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 001 =
=E2=94=80 OPC_MXU_S32ALN
+ *          =E2=94=9C=E2=94=80 101000 =E2=94=80 OPC_MXU_LXB      =E2=94=9C=
=E2=94=80 010 =E2=94=80 OPC_MXU_S32ALNI
+ *          =E2=94=9C=E2=94=80 101001 =E2=94=80 <not assigned>   =E2=94=9C=
=E2=94=80 011 =E2=94=80 OPC_MXU_S32NOR
+ *          =E2=94=9C=E2=94=80 101010 =E2=94=80 OPC_MXU_S16LDD   =E2=94=9C=
=E2=94=80 100 =E2=94=80 OPC_MXU_S32AND
+ *          =E2=94=9C=E2=94=80 101011 =E2=94=80 OPC_MXU_S16STD   =E2=94=9C=
=E2=94=80 101 =E2=94=80 OPC_MXU_S32OR
+ *          =E2=94=9C=E2=94=80 101100 =E2=94=80 OPC_MXU_S16LDI   =E2=94=9C=
=E2=94=80 110 =E2=94=80 OPC_MXU_S32XOR
+ *          =E2=94=9C=E2=94=80 101101 =E2=94=80 OPC_MXU_S16SDI   =E2=94=94=
=E2=94=80 111 =E2=94=80 OPC_MXU_S32LUI
+ *          =E2=94=9C=E2=94=80 101000 =E2=94=80 <not assigned>
+ *          =E2=94=9C=E2=94=80 101001 =E2=94=80 <not assigned>
+ *          =E2=94=9C=E2=94=80 101010 =E2=94=80 <not assigned>
+ *          =E2=94=9C=E2=94=80 101011 =E2=94=80 <not assigned>
+ *          =E2=94=9C=E2=94=80 101100 =E2=94=80 <not assigned>
+ *          =E2=94=9C=E2=94=80 101101 =E2=94=80 <not assigned>
+ *          =E2=94=9C=E2=94=80 101110 =E2=94=80 OPC_MXU_S32M2I
+ *          =E2=94=9C=E2=94=80 101111 =E2=94=80 OPC_MXU_S32I2M
+ *          =E2=94=9C=E2=94=80 110000 =E2=94=80 OPC_MXU_D32SLL
+ *          =E2=94=9C=E2=94=80 110001 =E2=94=80 OPC_MXU_D32SLR
+ *          =E2=94=9C=E2=94=80 110010 =E2=94=80 OPC_MXU_D32SARL
+ *          =E2=94=9C=E2=94=80 110011 =E2=94=80 OPC_MXU_D32SAR
+ *          =E2=94=9C=E2=94=80 110100 =E2=94=80 OPC_MXU_Q16SLL
+ *          =E2=94=9C=E2=94=80 110101 =E2=94=80 OPC_MXU_Q16SLR
+ *          =E2=94=9C=E2=94=80 110110 =E2=94=80 OPC_MXU__POOL18 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_D32SLLV
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 001 =
=E2=94=80 OPC_MXU_D32SLRV
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 010 =
=E2=94=80 OPC_MXU_D32SARV
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 011 =
=E2=94=80 OPC_MXU_Q16SLLV
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 100 =
=E2=94=80 OPC_MXU_Q16SLRV
+ *          =E2=94=82                            =E2=94=94=E2=94=80 101 =
=E2=94=80 OPC_MXU_Q16SARV
+ *          =E2=94=9C=E2=94=80 110111 =E2=94=80 OPC_MXU_Q16SAR
+ *          =E2=94=82
+ *          =E2=94=9C=E2=94=80 111000 =E2=94=80 OPC_MXU__POOL19 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q8MUL
+ *          =E2=94=82                            =E2=94=94=E2=94=80 01 =E2=
=94=80 OPC_MXU_Q8MULSU
+ *          =E2=94=82
+ *          =E2=94=82
+ *          =E2=94=9C=E2=94=80 111001 =E2=94=80 OPC_MXU__POOL20 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_Q8MOVZ
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 001 =
=E2=94=80 OPC_MXU_Q8MOVN
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 010 =
=E2=94=80 OPC_MXU_D16MOVZ
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 011 =
=E2=94=80 OPC_MXU_D16MOVN
+ *          =E2=94=82                            =E2=94=9C=E2=94=80 100 =
=E2=94=80 OPC_MXU_S32MOVZ
+ *          =E2=94=82                            =E2=94=94=E2=94=80 101 =
=E2=94=80 OPC_MXU_S32MOV
+ *          =E2=94=82
+ *          =E2=94=82
+ *          =E2=94=9C=E2=94=80 111010 =E2=94=80 OPC_MXU__POOL21 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q8MAC
+ *          =E2=94=82                            =E2=94=94=E2=94=80 10 =E2=
=94=80 OPC_MXU_Q8MACSU
+ *          =E2=94=9C=E2=94=80 111011 =E2=94=80 OPC_MXU_Q16SCOP
+ *          =E2=94=9C=E2=94=80 111100 =E2=94=80 OPC_MXU_Q8MADL
+ *          =E2=94=9C=E2=94=80 111101 =E2=94=80 OPC_MXU_S32SFL
+ *          =E2=94=9C=E2=94=80 111110 =E2=94=80 OPC_MXU_Q8SAD
+ *          =E2=94=94=E2=94=80 111111 =E2=94=80 <not assigned>
+ *
+ *
  *   Compiled after:
  *
  *   "XBurst=C2=AE Instruction Set Architecture MIPS eXtension/enhanced =
Unit
--=20
2.7.4
