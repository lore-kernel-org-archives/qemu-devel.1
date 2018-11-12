Received: from eggs.gnu.org ([2001:4830:134:3::10]:35742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gMA6j-0004Qo-Jw
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gMA6i-0003jU-MP
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:10:17 -0500
Date: Mon, 12 Nov 2018 12:10:07 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20181112111007.GD1148@toto>
References: <20181109173553.22341-1-peter.maydell@linaro.org>
	<20181109173553.22341-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109173553.22341-3-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm/cpu: Give Cortex-A15 and
 -A7 the EL2 feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Adam Lackorzynski <adam.lackorzynski@kernkonzept.com>

On Fri, Nov 09, 2018 at 05:35:53PM +0000, Peter Maydell wrote:
> The Cortex-A15 and Cortex-A7 both have EL2; now we've implemented
> it properly we can enable the feature bit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  target/arm/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 784a4c2dfcc..b7185234d85 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1587,6 +1587,7 @@ static void cortex_a7_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
>      set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
>      set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
> +    set_feature(&cpu->env, ARM_FEATURE_EL2);
>      set_feature(&cpu->env, ARM_FEATURE_EL3);
>      cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A7;
>      cpu->midr = 0x410fc075;
> @@ -1633,6 +1634,7 @@ static void cortex_a15_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
>      set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
>      set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
> +    set_feature(&cpu->env, ARM_FEATURE_EL2);
>      set_feature(&cpu->env, ARM_FEATURE_EL3);
>      cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A15;
>      cpu->midr = 0x412fc0f1;
> -- 
> 2.19.1
> 
