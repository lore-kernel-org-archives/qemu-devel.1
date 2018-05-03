Received: from eggs.gnu.org ([2001:4830:134:3::10]:52414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fEFJX-0008Ed-5r
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fEFJW-0008QB-7Z
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:34:31 -0400
References: <20180503115620.10596-1-edgar.iglesias@gmail.com>
	<20180503115620.10596-2-edgar.iglesias@gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <5af8086a-4ec6-f3fc-f8d4-8aab33f1cf78@adacore.com>
Date: Thu, 3 May 2018 16:34:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180503115620.10596-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/2] target-arm: Add the Cortex-R5F
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com



On 05/03/2018 01:56 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add the Cortex-R5F with the optional FPU enabled.
> 

Seems ok to me.

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>   target/arm/cpu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index d175c5e94f..7a7035c037 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1341,6 +1341,14 @@ static void cortex_r5_initfn(Object *obj)
>       define_arm_cp_regs(cpu, cortexr5_cp_reginfo);
>   }
>   
> +static void cortex_r5f_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    cortex_r5_initfn(obj);
> +    set_feature(&cpu->env, ARM_FEATURE_VFP3);
> +}
> +
>   static const ARMCPRegInfo cortexa8_cp_reginfo[] = {
>       { .name = "L2LOCKDOWN", .cp = 15, .crn = 9, .crm = 0, .opc1 = 1, .opc2 = 0,
>         .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
> @@ -1801,6 +1809,7 @@ static const ARMCPUInfo arm_cpus[] = {
>       { .name = "cortex-m33",  .initfn = cortex_m33_initfn,
>                                .class_init = arm_v7m_class_init },
>       { .name = "cortex-r5",   .initfn = cortex_r5_initfn },
> +    { .name = "cortex-r5f",  .initfn = cortex_r5f_initfn },
>       { .name = "cortex-a7",   .initfn = cortex_a7_initfn },
>       { .name = "cortex-a8",   .initfn = cortex_a8_initfn },
>       { .name = "cortex-a9",   .initfn = cortex_a9_initfn },
> 
