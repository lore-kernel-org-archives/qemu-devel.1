Received: from eggs.gnu.org ([2001:4830:134:3::10]:53796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cRmGz-0007TC-Eo
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cRmGy-00015z-M8
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:47:01 -0500
Date: Thu, 12 Jan 2017 21:46:52 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170112204652.GA9606@toto>
References: <1484073849-32666-1-git-send-email-peter.maydell@linaro.org>
	<1484073849-32666-4-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484073849-32666-4-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 3/3] target/arm: Implement DBGVCR32_EL2
 system register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Tue, Jan 10, 2017 at 06:44:09PM +0000, Peter Maydell wrote:
> The DBGVCR_EL2 system register is needed to run a 32-bit
> EL1 guest under a Linux EL2 64-bit hypervisor. Its only
> purpose is to provide AArch64 with access to the state of
> the DBGVCR AArch32 register. Since we only have a dummy
> DBGVCR, implement a corresponding dummy DBGVCR32_EL2.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  target/arm/helper.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index dc90986..bda562d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4066,6 +4066,13 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
>        .cp = 14, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 0,
>        .access = PL1_RW, .accessfn = access_tda,
>        .type = ARM_CP_NOP },
> +    /* Dummy DBGVCR32_EL2 (which is only for a 64-bit hypervisor
> +     * to save and restore a 32-bit guest's DBGVCR)
> +     */
> +    { .name = "DBGVCR32_EL2", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 2, .opc1 = 4, .crn = 0, .crm = 7, .opc2 = 0,
> +      .access = PL2_RW, .accessfn = access_tda,
> +      .type = ARM_CP_NOP },
>      /* Dummy MDCCINT_EL1, since we don't implement the Debug Communications
>       * Channel but Linux may try to access this register. The 32-bit
>       * alias is DBGDCCINT.
> -- 
> 2.7.4
> 
