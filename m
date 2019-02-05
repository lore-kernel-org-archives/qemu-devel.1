Received: from eggs.gnu.org ([209.51.188.92]:57799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gr1Dc-0007vJ-7w
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gr1Db-00009Z-Hn
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:56:56 -0500
MIME-Version: 1.0
References: <20190205135129.19338-1-aaron@os.amperecomputing.com>
In-Reply-To: <20190205135129.19338-1-aaron@os.amperecomputing.com>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Tue, 5 Feb 2019 14:56:41 +0100
Message-ID: <CABoDooMLoo7X=L7X642TKNZFKnrY9S1xtHDSKGthR3mfVuyiAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Fix CRn to be 14 for
 PMEVTYPER/PMEVCNTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, Feb 5, 2019 at 2:51 PM Aaron Lindsay OS
<aaron@os.amperecomputing.com> wrote:
>
> This bug was introduced in:
>     commit 5ecdd3e47cadae83a62dc92b472f1fe163b56f59
>     target/arm: Finish implementation of PM[X]EVCNTR and PM[X]EVTYPER
>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
>  target/arm/helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index d070879894..ec2d17093c 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5855,25 +5855,25 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              char *pmevtyper_name = g_strdup_printf("PMEVTYPER%d", i);
>              char *pmevtyper_el0_name = g_strdup_printf("PMEVTYPER%d_EL0", i);
>              ARMCPRegInfo pmev_regs[] = {
> -                { .name = pmevcntr_name, .cp = 15, .crn = 15,
> +                { .name = pmevcntr_name, .cp = 15, .crn = 14,
>                    .crm = 8 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
>                    .access = PL0_RW, .type = ARM_CP_IO | ARM_CP_ALIAS,
>                    .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
>                    .accessfn = pmreg_access },
>                  { .name = pmevcntr_el0_name, .state = ARM_CP_STATE_AA64,
> -                  .opc0 = 3, .opc1 = 3, .crn = 15, .crm = 8 | (3 & (i >> 3)),
> +                  .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 8 | (3 & (i >> 3)),
>                    .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
>                    .type = ARM_CP_IO,
>                    .readfn = pmevcntr_readfn, .writefn = pmevcntr_writefn,
>                    .raw_readfn = pmevcntr_rawread,
>                    .raw_writefn = pmevcntr_rawwrite },
> -                { .name = pmevtyper_name, .cp = 15, .crn = 15,
> +                { .name = pmevtyper_name, .cp = 15, .crn = 14,
>                    .crm = 12 | (3 & (i >> 3)), .opc1 = 0, .opc2 = i & 7,
>                    .access = PL0_RW, .type = ARM_CP_IO | ARM_CP_ALIAS,
>                    .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
>                    .accessfn = pmreg_access },
>                  { .name = pmevtyper_el0_name, .state = ARM_CP_STATE_AA64,
> -                  .opc0 = 3, .opc1 = 3, .crn = 15, .crm = 12 | (3 & (i >> 3)),
> +                  .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 12 | (3 & (i >> 3)),
>                    .opc2 = i & 7, .access = PL0_RW, .accessfn = pmreg_access,
>                    .type = ARM_CP_IO,
>                    .readfn = pmevtyper_readfn, .writefn = pmevtyper_writefn,
> --
> 2.20.1
>
