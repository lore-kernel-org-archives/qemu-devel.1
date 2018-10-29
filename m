Received: from eggs.gnu.org ([2001:4830:134:3::10]:34474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9Lh-0008TD-Tm
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9Lc-0003QS-HI
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:21:01 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39526 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH9Lc-0003IL-03
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:56 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 16:20:12 +0100
Message-Id: <1540826418-5501-22-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/27] target/mips: Amend MXU ASE overview note
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

Add prefix, suffix, operation descriptions, and other corrections
and amendments to the comment that describes MXU ASE.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 84 +++++++++++++++++++++++++++++++++++++++++++=
------
 1 file changed, 74 insertions(+), 10 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 280b489..60320cb 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1410,25 +1410,89 @@ enum {
  * MXU unit contains 17 registers called X0-X16. X0 is always zero, and =
X16 is
  * the control register.
  *
- * The notation used in MXU assembler mnemonics:
+ * The notation used in MXU assembler mnemonics
+ * --------------------------------------------
+ *
+ *  Registers:
  *
  *   XRa, XRb, XRc, XRd - MXU registers
  *   Rb, Rc, Rd, Rs, Rt - general purpose MIPS registers
- *   s12                - a subfield of an instruction code
- *   strd2              - a subfield of an instruction code
- *   eptn2              - a subfield of an instruction code
- *   eptn3              - a subfield of an instruction code
- *   optn2              - a subfield of an instruction code
- *   optn3              - a subfield of an instruction code
- *   sft4               - a subfield of an instruction code
+ *
+ *  Subfields:
+ *
+ *   aptn1              - 1-bit accumulate add/subtract pattern
+ *   aptn2              - 2-bit accumulate add/subtract pattern
+ *   eptn2              - 2-bit execute add/subtract pattern
+ *   optn2              - 2-bit operand pattern
+ *   optn3              - 3-bit operand pattern
+ *   sft4               - 4-bit shift amount
+ *   strd2              - 2-bit stride amount
+ *
+ *  Prefixes:
+ *
+ *   <Operation parallel level><Operand size>
+ *     S                         32
+ *     D                         16
+ *     Q                          8
+ *
+ *  Suffixes:
+ *
+ *   E - Expand results
+ *   F - Fixed point multiplication
+ *   L - Low part result
+ *   R - Doing rounding
+ *   V - Variable instead of immediate
+ *   W - Combine above L and V
+ *
+ *  Operations:
+ *
+ *   ADD   - Add or subtract
+ *   ADDC  - Add with carry-in
+ *   ACC   - Accumulate
+ *   ASUM  - Sum together then accumulate (add or subtract)
+ *   ASUMC - Sum together then accumulate (add or subtract) with carry-i=
n
+ *   AVG   - Average between 2 operands
+ *   ABD   - Absolute difference
+ *   ALN   - Align data
+ *   AND   - Logical bitwise 'and' operation
+ *   CPS   - Copy sign
+ *   EXTR  - Extract bits
+ *   I2M   - Move from GPR register to MXU register
+ *   LDD   - Load data from memory to XRF
+ *   LDI   - Load data from memory to XRF (and increase the address base=
)
+ *   LUI   - Load unsigned immediate
+ *   MUL   - Multiply
+ *   MULU  - Unsigned multiply
+ *   MADD  - 64-bit operand add 32x32 product
+ *   MSUB  - 64-bit operand subtract 32x32 product
+ *   MAC   - Multiply and accumulate (add or subtract)
+ *   MAD   - Multiply and add or subtract
+ *   MAX   - Maximum between 2 operands
+ *   MIN   - Minimum between 2 operands
+ *   M2I   - Move from MXU register to GPR register
+ *   MOVZ  - Move if zero
+ *   MOVN  - Move if non-zero
+ *   NOR   - Logical bitwise 'nor' operation
+ *   OR    - Logical bitwise 'or' operation
+ *   STD   - Store data from XRF to memory
+ *   SDI   - Store data from XRF to memory (and increase the address bas=
e)
+ *   SLT   - Set of less than comparison
+ *   SAD   - Sum of absolute differences
+ *   SLL   - Logical shift left
+ *   SLR   - Logical shift right
+ *   SAR   - Arithmetic shift right
+ *   SAT   - Saturation
+ *   SFL   - Shuffle
+ *   SCOP  - Calculate x=E2=80=99s scope (-1, means x<0; 0, means x=3D=3D=
0; 1, means x>0)
+ *   XOR   - Logical bitwise 'exclusive or' operation
  *
  * Load/Store instructions           Multiplication instructions
  * -----------------------           ---------------------------
  *
  *  S32LDD XRa, Rb, s12               S32MADD XRa, XRd, Rs, Rt
  *  S32STD XRa, Rb, s12               S32MADDU XRa, XRd, Rs, Rt
- *  S32LDDV XRa, Rb, rc, strd2        S32SUB XRa, XRd, Rs, Rt
- *  S32STDV XRa, Rb, rc, strd2        S32SUBU XRa, XRd, Rs, Rt
+ *  S32LDDV XRa, Rb, rc, strd2        S32MSUB XRa, XRd, Rs, Rt
+ *  S32STDV XRa, Rb, rc, strd2        S32MSUBU XRa, XRd, Rs, Rt
  *  S32LDI XRa, Rb, s12               S32MUL XRa, XRd, Rs, Rt
  *  S32SDI XRa, Rb, s12               S32MULU XRa, XRd, Rs, Rt
  *  S32LDIV XRa, Rb, rc, strd2        D16MUL XRa, XRb, XRc, XRd, optn2
--=20
2.7.4
