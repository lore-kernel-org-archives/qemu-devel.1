Received: from eggs.gnu.org ([2001:4830:134:3::10]:54353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEGdj-0008UZ-8u
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEGdi-0000If-Bm
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:59:27 -0400
MIME-Version: 1.0
References: <20180503115620.10596-1-edgar.iglesias@gmail.com>
	<20180503115620.10596-2-edgar.iglesias@gmail.com>
In-Reply-To: <20180503115620.10596-2-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 15:58:58 +0000
Message-ID: <CAKmqyKPqbSg4S0WWpsW+zWEwKt9_unhz7j6h=ausRui2nd0uEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/2] target-arm: Add the Cortex-R5F
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Iglesias <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>

On Thu, May 3, 2018 at 4:58 AM Edgar E. Iglesias <edgar.iglesias@gmail.com>
wrote:

> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

> Add the Cortex-R5F with the optional FPU enabled.

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/arm/cpu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index d175c5e94f..7a7035c037 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1341,6 +1341,14 @@ static void cortex_r5_initfn(Object *obj)
>       define_arm_cp_regs(cpu, cortexr5_cp_reginfo);
>   }

> +static void cortex_r5f_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    cortex_r5_initfn(obj);
> +    set_feature(&cpu->env, ARM_FEATURE_VFP3);
> +}
> +
>   static const ARMCPRegInfo cortexa8_cp_reginfo[] = {
>       { .name = "L2LOCKDOWN", .cp = 15, .crn = 9, .crm = 0, .opc1 = 1,
.opc2 = 0,
>         .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> @@ -1801,6 +1809,7 @@ static const ARMCPUInfo arm_cpus[] = {
>       { .name = "cortex-m33",  .initfn = cortex_m33_initfn,
>                                .class_init = arm_v7m_class_init },
>       { .name = "cortex-r5",   .initfn = cortex_r5_initfn },
> +    { .name = "cortex-r5f",  .initfn = cortex_r5f_initfn },
>       { .name = "cortex-a7",   .initfn = cortex_a7_initfn },
>       { .name = "cortex-a8",   .initfn = cortex_a8_initfn },
>       { .name = "cortex-a9",   .initfn = cortex_a9_initfn },
> --
> 2.14.1
