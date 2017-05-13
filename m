Received: from eggs.gnu.org ([2001:4830:134:3::10]:38117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9fhp-0004Vo-CX
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9fhm-00071l-BY
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:40:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
	<1493122030-32191-11-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <793b8c30-6f1b-a104-b43f-3cac77dc23d4@amsat.org>
Date: Sat, 13 May 2017 19:40:01 -0300
MIME-Version: 1.0
In-Reply-To: <1493122030-32191-11-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 10/13] arm: All M profile cores
 are PMSA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, patches@linaro.org

On 04/25/2017 09:07 AM, Peter Maydell wrote:
> All M profile CPUs are PMSA, so set the feature bit.
> (We haven't actually implemented the M profile MPU register
> interface yet, but setting this feature bit gives us closer
> to correct behaviour for the MPU-disabled case.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 8e57498..df8b835 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -543,6 +543,14 @@ static void arm_cpu_post_init(Object *obj)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
>
> +    /* M profile implies PMSA. We have to do this here rather than
> +     * in realize with the other feature-implication checks because
> +     * we look at the PMSA bit to see if we should add some properties.
> +     */
> +    if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
> +        set_feature(&cpu->env, ARM_FEATURE_PMSA);
> +    }
> +
>      if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
>          arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
>          qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_cbar_property,
>
