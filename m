Received: from eggs.gnu.org ([208.118.235.92]:48006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcoPH-0000pW-Bq
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcoPB-0003Hj-Gl
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:15 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49210 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcoPB-00034j-2K
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:09 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 28 Dec 2018 10:25:15 +0100
Message-Id: <1545989148-13582-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/41] target/mips: MXU: Improve the comment
 containing MXU overview
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

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Improve textual description of MXU extension. These are mostly
comment formatting changes.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 74 +++++++++++++++++++++++++++++--------------=
------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 74d16ce..e3a5a73 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1399,10 +1399,12 @@ enum {
=20
=20
 /*
- *    AN OVERVIEW OF MXU EXTENSION INSTRUCTION SET
- *    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  *
- * MXU (full name: MIPS eXtension/enhanced Unit) is an SIMD extension of=
 MIPS32
+ *       AN OVERVIEW OF MXU EXTENSION INSTRUCTION SET
+ *       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ *
+ *
+ * MXU (full name: MIPS eXtension/enhanced Unit) is a SIMD extension of =
MIPS32
  * instructions set. It is designed to fit the needs of signal, graphica=
l and
  * video processing applications. MXU instruction set is used in Xburst =
family
  * of microprocessors by Ingenic.
@@ -1410,39 +1412,31 @@ enum {
  * MXU unit contains 17 registers called X0-X16. X0 is always zero, and =
X16 is
  * the control register.
  *
- * The notation used in MXU assembler mnemonics
- * --------------------------------------------
  *
- *  Registers:
+ *     The notation used in MXU assembler mnemonics
+ *     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  Register operands:
  *
  *   XRa, XRb, XRc, XRd - MXU registers
  *   Rb, Rc, Rd, Rs, Rt - general purpose MIPS registers
  *
- *  Subfields:
+ *  Non-register operands:
  *
- *   aptn1              - 1-bit accumulate add/subtract pattern
- *   aptn2              - 2-bit accumulate add/subtract pattern
- *   eptn2              - 2-bit execute add/subtract pattern
- *   optn2              - 2-bit operand pattern
- *   optn3              - 3-bit operand pattern
- *   sft4               - 4-bit shift amount
- *   strd2              - 2-bit stride amount
+ *   aptn1 - 1-bit accumulate add/subtract pattern
+ *   aptn2 - 2-bit accumulate add/subtract pattern
+ *   eptn2 - 2-bit execute add/subtract pattern
+ *   optn2 - 2-bit operand pattern
+ *   optn3 - 3-bit operand pattern
+ *   sft4  - 4-bit shift amount
+ *   strd2 - 2-bit stride amount
  *
  *  Prefixes:
  *
- *   <Operation parallel level><Operand size>
- *     S                         32
- *     D                         16
- *     Q                          8
- *
- *  Suffixes:
- *
- *   E - Expand results
- *   F - Fixed point multiplication
- *   L - Low part result
- *   R - Doing rounding
- *   V - Variable instead of immediate
- *   W - Combine above L and V
+ *   Level of parallelism:                Operand size:
+ *    S - single operation at a time       32 - word
+ *    D - two operations in parallel       16 - half word
+ *    Q - four operations in parallel       8 - byte
  *
  *  Operations:
  *
@@ -1486,6 +1480,19 @@ enum {
  *   SCOP  - Calculate x=E2=80=99s scope (-1, means x<0; 0, means x=3D=3D=
0; 1, means x>0)
  *   XOR   - Logical bitwise 'exclusive or' operation
  *
+ *  Suffixes:
+ *
+ *   E - Expand results
+ *   F - Fixed point multiplication
+ *   L - Low part result
+ *   R - Doing rounding
+ *   V - Variable instead of immediate
+ *   W - Combine above L and V
+ *
+ *
+ *     The list of MXU instructions grouped by functionality
+ *     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
  * Load/Store instructions           Multiplication instructions
  * -----------------------           ---------------------------
  *
@@ -1563,6 +1570,13 @@ enum {
  *  Q16SAT XRa, XRb, XRc              S32I2M XRa, Rb
  *
  *
+ *     The opcode organization of MXU instructions
+ *     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * The bits 31..26 of all MXU instructions are equal to 0x1C (also refer=
red
+ * as opcode SPECIAL2 in the base MIPS ISA). The organization and meanin=
g of
+ * other bits up to the instruction level is as follows:
+ *
  *              bits
  *             05..00
  *
@@ -1700,7 +1714,7 @@ enum {
  *          =E2=94=82                            =E2=94=9C=E2=94=80 010 =
=E2=94=80 OPC_MXU_D16MOVZ
  *          =E2=94=82                            =E2=94=9C=E2=94=80 011 =
=E2=94=80 OPC_MXU_D16MOVN
  *          =E2=94=82                            =E2=94=9C=E2=94=80 100 =
=E2=94=80 OPC_MXU_S32MOVZ
- *          =E2=94=82                            =E2=94=94=E2=94=80 101 =
=E2=94=80 OPC_MXU_S32MOV
+ *          =E2=94=82                            =E2=94=94=E2=94=80 101 =
=E2=94=80 OPC_MXU_S32MOVN
  *          =E2=94=82
  *          =E2=94=82                               23..22
  *          =E2=94=9C=E2=94=80 111010 =E2=94=80 OPC_MXU__POOL21 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q8MAC
@@ -1712,10 +1726,10 @@ enum {
  *          =E2=94=94=E2=94=80 111111 =E2=94=80 <not assigned>   (overla=
ps with SDBBP)
  *
  *
- *   Compiled after:
+ * Compiled after:
  *
  *   "XBurst=C2=AE Instruction Set Architecture MIPS eXtension/enhanced =
Unit
- *   Programming Manual", Ingenic Semiconductor Co, Ltd., 2017
+ *   Programming Manual", Ingenic Semiconductor Co, Ltd., revision June =
2, 2017
  */
=20
 enum {
--=20
2.7.4
