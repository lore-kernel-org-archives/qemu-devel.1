Received: from eggs.gnu.org ([2001:4830:134:3::10]:47806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fpaWJ-00058N-3Y
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fpaWF-00038t-T5
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:42:03 -0400
Date: Tue, 14 Aug 2018 16:41:44 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180814144144.slntd4f22eza5rru@toto>
References: <20180814124254.5229-1-peter.maydell@linaro.org>
	<20180814124254.5229-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180814124254.5229-3-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 02/10] target/arm: Add missing .cp = 15 to
 HMAIR1 and HAMAIR1 regdefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Luc Michel <luc.michel@greensocs.com>, edgari@xilinx.com

On Tue, Aug 14, 2018 at 01:42:46PM +0100, Peter Maydell wrote:
> ARMCPRegInfo structs will not default to .cp = 15 if they
                            ^^^
               I think you've got a typo here


Otherwise:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> are ARM_CP_STATE_BOTH, but not if they are ARM_CP_STATE_AA32
> (because a coprocessor number of 0 is valid for AArch32).
> We forgot to explicitly set .cp = 15 for the HMAIR1 and
> HAMAIR1 regdefs, which meant they would UNDEF when the guest
> tried to access them under cp15.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> A quick grep suggests these are the only ones we got wrong.
> ---
>  target/arm/helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 2c5e02c0b1a..466c8ae492e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3767,14 +3767,14 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
>        .access = PL2_RW, .type = ARM_CP_CONST,
>        .resetvalue = 0 },
>      { .name = "HMAIR1", .state = ARM_CP_STATE_AA32,
> -      .opc1 = 4, .crn = 10, .crm = 2, .opc2 = 1,
> +      .cp = 15, .opc1 = 4, .crn = 10, .crm = 2, .opc2 = 1,
>        .access = PL2_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
>      { .name = "AMAIR_EL2", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 4, .crn = 10, .crm = 3, .opc2 = 0,
>        .access = PL2_RW, .type = ARM_CP_CONST,
>        .resetvalue = 0 },
>      { .name = "HAMAIR1", .state = ARM_CP_STATE_AA32,
> -      .opc1 = 4, .crn = 10, .crm = 3, .opc2 = 1,
> +      .cp = 15, .opc1 = 4, .crn = 10, .crm = 3, .opc2 = 1,
>        .access = PL2_RW, .type = ARM_CP_CONST,
>        .resetvalue = 0 },
>      { .name = "AFSR0_EL2", .state = ARM_CP_STATE_BOTH,
> @@ -3917,7 +3917,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
>        .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.mair_el[2]),
>        .resetvalue = 0 },
>      { .name = "HMAIR1", .state = ARM_CP_STATE_AA32,
> -      .opc1 = 4, .crn = 10, .crm = 2, .opc2 = 1,
> +      .cp = 15, .opc1 = 4, .crn = 10, .crm = 2, .opc2 = 1,
>        .access = PL2_RW, .type = ARM_CP_ALIAS,
>        .fieldoffset = offsetofhigh32(CPUARMState, cp15.mair_el[2]) },
>      { .name = "AMAIR_EL2", .state = ARM_CP_STATE_BOTH,
> @@ -3926,7 +3926,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
>        .resetvalue = 0 },
>      /* HAMAIR1 is mapped to AMAIR_EL2[63:32] */
>      { .name = "HAMAIR1", .state = ARM_CP_STATE_AA32,
> -      .opc1 = 4, .crn = 10, .crm = 3, .opc2 = 1,
> +      .cp = 15, .opc1 = 4, .crn = 10, .crm = 3, .opc2 = 1,
>        .access = PL2_RW, .type = ARM_CP_CONST,
>        .resetvalue = 0 },
>      { .name = "AFSR0_EL2", .state = ARM_CP_STATE_BOTH,
> -- 
> 2.18.0
> 
