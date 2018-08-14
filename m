Received: from eggs.gnu.org ([2001:4830:134:3::10]:49306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fpabJ-0000o6-TY
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fpabG-0005GU-Nz
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:13 -0400
Date: Tue, 14 Aug 2018 16:46:56 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180814144656.ww3gmgmdknqsfp5x@toto>
References: <20180814124254.5229-1-peter.maydell@linaro.org>
	<20180814124254.5229-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180814124254.5229-5-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 04/10] target/arm: Implement AArch32 HVBAR
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

On Tue, Aug 14, 2018 at 01:42:48PM +0100, Peter Maydell wrote:
> Implement the AArch32 HVBAR register; we can do this just by
> making the existing VBAR_EL2 regdefs be STATE_BOTH.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  target/arm/helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 14fd78f587a..b6412fe9d1f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3750,7 +3750,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
>  
>  /* Used to describe the behaviour of EL2 regs when EL2 does not exist.  */
>  static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
> -    { .name = "VBAR_EL2", .state = ARM_CP_STATE_AA64,
> +    { .name = "VBAR_EL2", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 0, .opc2 = 0,
>        .access = PL2_RW,
>        .readfn = arm_cp_read_zero, .writefn = arm_cp_write_ignore },
> @@ -3899,7 +3899,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
>        .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 0,
>        .access = PL2_RW,
>        .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_HYP]) },
> -    { .name = "VBAR_EL2", .state = ARM_CP_STATE_AA64,
> +    { .name = "VBAR_EL2", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 0, .opc2 = 0,
>        .access = PL2_RW, .writefn = vbar_write,
>        .fieldoffset = offsetof(CPUARMState, cp15.vbar_el[2]),
> -- 
> 2.18.0
> 
