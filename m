Received: from eggs.gnu.org ([2001:4830:134:3::10]:39597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exh0m-0005Xk-8V
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 18:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exh0l-0006Wx-95
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 18:42:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-16-git-send-email-alindsay@codeaurora.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b97cdeec-6cdb-022a-63a7-b7ebb005f066@amsat.org>
Date: Sun, 18 Mar 2018 23:42:40 +0100
MIME-Version: 1.0
In-Reply-To: <1521232280-13089-16-git-send-email-alindsay@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 15/22] target/arm: Add
 ARM_FEATURE_V7VE for v7 Virtualization Extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

On 03/16/2018 09:31 PM, Aaron Lindsay wrote:
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/cpu.c | 3 +++
>  target/arm/cpu.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index b0d032c..e544f1d 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -765,6 +765,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>      /* Some features automatically imply others: */
>      if (arm_feature(env, ARM_FEATURE_V8)) {
>          set_feature(env, ARM_FEATURE_V7);
> +        set_feature(env, ARM_FEATURE_V7VE);
>          set_feature(env, ARM_FEATURE_ARM_DIV);
>          set_feature(env, ARM_FEATURE_LPAE);
>      }
> @@ -1481,6 +1482,7 @@ static void cortex_a7_initfn(Object *obj)
>  
>      cpu->dtb_compatible = "arm,cortex-a7";
>      set_feature(&cpu->env, ARM_FEATURE_V7);
> +    set_feature(&cpu->env, ARM_FEATURE_V7VE);
>      set_feature(&cpu->env, ARM_FEATURE_VFP4);
>      set_feature(&cpu->env, ARM_FEATURE_NEON);
>      set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
> @@ -1526,6 +1528,7 @@ static void cortex_a15_initfn(Object *obj)
>  
>      cpu->dtb_compatible = "arm,cortex-a15";
>      set_feature(&cpu->env, ARM_FEATURE_V7);
> +    set_feature(&cpu->env, ARM_FEATURE_V7VE);
>      set_feature(&cpu->env, ARM_FEATURE_VFP4);
>      set_feature(&cpu->env, ARM_FEATURE_NEON);
>      set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index fb2f983..cc1e2fb 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1439,6 +1439,7 @@ enum arm_features {
>      ARM_FEATURE_OMAPCP, /* OMAP specific CP15 ops handling.  */
>      ARM_FEATURE_THUMB2EE,
>      ARM_FEATURE_V7MP,    /* v7 Multiprocessing Extensions */
> +    ARM_FEATURE_V7VE,    /* v7 with Virtualization Extensions */
>      ARM_FEATURE_V4T,
>      ARM_FEATURE_V5,
>      ARM_FEATURE_STRONGARM,
> 
