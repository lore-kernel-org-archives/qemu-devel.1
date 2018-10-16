Received: from eggs.gnu.org ([2001:4830:134:3::10]:34110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gCPTh-0007lx-BI
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gCPTe-0001yC-5d
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:33:41 -0400
Received: from mail-sn1nam01on0092.outbound.protection.outlook.com
	([104.47.32.92]:40069
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1gCPTd-0001up-S7
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:33:38 -0400
References: <1539692044-15732-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1539692044-15732-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: Stefan Markovic <smarkovic@wavecomp.com>
Message-ID: <d1b38f48-2dfc-4f45-7529-6638e7e95592@wavecomp.com>
Date: Tue, 16 Oct 2018 15:33:24 +0200
MIME-Version: 1.0
In-Reply-To: <1539692044-15732-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/4] target/mips: Add assembler mnemonics
 list for MXU ASE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, jancraig@amazon.com, amarkovic@wavecomp.com, pjovanovic@wavecomp.com


On 16.10.18. 14:14, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add a comment that contains a list all MXU instructions,
> expressed in assembler mnemonics.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   target/mips/translate.c | 88 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 88 insertions(+)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 23e21c5..73d971e 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1402,6 +1402,94 @@ enum {
>    * MXU unit contains 17 registers called X0-X16. X0 is always zero, and=
 X16 is
>    * the control register.
>    *
> + * The notation used in MXU assembler mnemonics:
> + *
> + *   XRa, XRb, XRa, XRb - MXU registers


XRa and XRb duplicated. Did You mean XRc and XRd instead? Otherwise:

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>


> + *   Rb, Rc, Rd, Rs, Rt - general purpose MIPS registers
> + *   s12                - a subfield of an instruction code
> + *   strd2              - a subfield of an instruction code
> + *   eptn2              - a subfield of an instruction code
> + *   eptn3              - a subfield of an instruction code
> + *   optn2              - a subfield of an instruction code
> + *   optn3              - a subfield of an instruction code
> + *   sft4               - a subfield of an instruction code
> + *
> + * Load/Store instructions           Multiplication instructions
> + * -----------------------           ---------------------------
> + *
> + *  S32LDD XRa, Rb, s12               S32MADD XRa, XRd, Rs, Rt
> + *  S32STD XRa, Rb, s12               S32MADDU XRa, XRd, Rs, Rt
> + *  S32LDDV XRa, Rb, rc, strd2        S32SUB XRa, XRd, Rs, Rt
> + *  S32STDV XRa, Rb, rc, strd2        S32SUBU XRa, XRd, Rs, Rt
> + *  S32LDI XRa, Rb, s12               S32MUL XRa, XRd, Rs, Rt
> + *  S32SDI XRa, Rb, s12               S32MULU XRa, XRd, Rs, Rt
> + *  S32LDIV XRa, Rb, rc, strd2        D16MUL XRa, XRb, XRc, XRd, optn2
> + *  S32SDIV XRa, Rb, rc, strd2        D16MULE XRa, XRb, XRc, optn2
> + *  S32LDDR XRa, Rb, s12              D16MULF XRa, XRb, XRc, optn2
> + *  S32STDR XRa, Rb, s12              D16MAC XRa, XRb, XRc, XRd, aptn2, =
optn2
> + *  S32LDDVR XRa, Rb, rc, strd2       D16MACE XRa, XRb, XRc, XRd, aptn2,=
 optn2
> + *  S32STDVR XRa, Rb, rc, strd2       D16MACF XRa, XRb, XRc, XRd, aptn2,=
 optn2
> + *  S32LDIR XRa, Rb, s12              D16MADL XRa, XRb, XRc, XRd, aptn2,=
 optn2
> + *  S32SDIR XRa, Rb, s12              S16MAD XRa, XRb, XRc, XRd, aptn1, =
optn2
> + *  S32LDIVR XRa, Rb, rc, strd2       Q8MUL XRa, XRb, XRc, XRd
> + *  S32SDIVR XRa, Rb, rc, strd2       Q8MULSU XRa, XRb, XRc, XRd
> + *  S16LDD XRa, Rb, s10, eptn2        Q8MAC XRa, XRb, XRc, XRd, aptn2
> + *  S16STD XRa, Rb, s10, eptn2        Q8MACSU XRa, XRb, XRc, XRd, aptn2
> + *  S16LDI XRa, Rb, s10, eptn2        Q8MADL XRa, XRb, XRc, XRd, aptn2
> + *  S16SDI XRa, Rb, s10, eptn2
> + *  S8LDD XRa, Rb, s8, eptn3
> + *  S8STD XRa, Rb, s8, eptn3         Addition and subtraction instructio=
ns
> + *  S8LDI XRa, Rb, s8, eptn3         -----------------------------------=
--
> + *  S8SDI XRa, Rb, s8, eptn3
> + *  LXW Rd, Rs, Rt, strd2             D32ADD XRa, XRb, XRc, XRd, eptn2
> + *  LXH Rd, Rs, Rt, strd2             D32ADDC XRa, XRb, XRc, XRd
> + *  LXHU Rd, Rs, Rt, strd2            D32ACC XRa, XRb, XRc, XRd, eptn2
> + *  LXB Rd, Rs, Rt, strd2             D32ACCM XRa, XRb, XRc, XRd, eptn2
> + *  LXBU Rd, Rs, Rt, strd2            D32ASUM XRa, XRb, XRc, XRd, eptn2
> + *                                    S32CPS XRa, XRb, XRc
> + *                                    Q16ADD XRa, XRb, XRc, XRd, eptn2, =
optn2
> + * Comparison instructions            Q16ACC XRa, XRb, XRc, XRd, eptn2
> + * -----------------------            Q16ACCM XRa, XRb, XRc, XRd, eptn2
> + *                                    D16ASUM XRa, XRb, XRc, XRd, eptn2
> + *  S32MAX XRa, XRb, XRc              D16CPS XRa, XRb,
> + *  S32MIN XRa, XRb, XRc              D16AVG XRa, XRb, XRc
> + *  S32SLT XRa, XRb, XRc              D16AVGR XRa, XRb, XRc
> + *  S32MOVZ XRa, XRb, XRc             Q8ADD XRa, XRb, XRc, eptn2
> + *  S32MOVN XRa, XRb, XRc             Q8ADDE XRa, XRb, XRc, XRd, eptn2
> + *  D16MAX XRa, XRb, XRc              Q8ACCE XRa, XRb, XRc, XRd, eptn2
> + *  D16MIN XRa, XRb, XRc              Q8ABD XRa, XRb, XRc
> + *  D16SLT XRa, XRb, XRc              Q8SAD XRa, XRb, XRc, XRd
> + *  D16MOVZ XRa, XRb, XRc             Q8AVG XRa, XRb, XRc
> + *  D16MOVN XRa, XRb, XRc             Q8AVGR XRa, XRb, XRc
> + *  Q8MAX XRa, XRb, XRc               D8SUM XRa, XRb, XRc, XRd
> + *  Q8MIN XRa, XRb, XRc               D8SUMC XRa, XRb, XRc, XRd
> + *  Q8SLT XRa, XRb, XRc
> + *  Q8SLTU XRa, XRb, XRc
> + *  Q8MOVZ XRa, XRb, XRc             Shift instructions
> + *  Q8MOVN XRa, XRb, XRc             ------------------
> + *
> + *                                    D32SLL XRa, XRb, XRc, XRd, sft4
> + * Bitwise instructions               D32SLR XRa, XRb, XRc, XRd, sft4
> + * --------------------               D32SAR XRa, XRb, XRc, XRd, sft4
> + *                                    D32SARL XRa, XRb, XRc, sft4
> + *  S32NOR XRa, XRb, XRc              D32SLLV XRa, XRb, Rb
> + *  S32AND XRa, XRb, XRc              D32SLRV XRa, XRb, Rb
> + *  S32XOR XRa, XRb, XRc              D32SARV XRa, XRb, Rb
> + *  S32OR XRa, XRb, XRc               D32SARW XRa, XRb, XRc, Rb
> + *                                    Q16SLL XRa, XRb, XRc, XRd, sft4
> + *                                    Q16SLR XRa, XRb, XRc, XRd, sft4
> + * Miscelaneous instructions          Q16SAR XRa, XRb, XRc, XRd, sft4
> + * -------------------------          Q16SLLV XRa, XRb, Rb
> + *                                    Q16SLRV XRa, XRb, Rb
> + *  S32SFL XRa, XRb, XRc, XRd, optn2  Q16SARV XRa, XRb, Rb
> + *  S32ALN XRa, XRb, XRc, Rb
> + *  S32ALNI XRa, XRb, XRc, s3
> + *  S32LUI XRa, s8, optn3            Move instructions
> + *  S32EXTR XRa, XRb, Rb, bits5      -----------------
> + *  S32EXTRV XRa, XRb, Rs, Rt
> + *  Q16SCOP XRa, XRb, XRc, XRd        S32M2I XRa, Rb
> + *  Q16SAT XRa, XRb, XRc              S32I2M XRa, Rb
> + *
>    *   Compiled after:
>    *
>    *   "XBurst=C2=AE Instruction Set Architecture MIPS eXtension/enhanced=
 Unit
