Received: from eggs.gnu.org ([2001:4830:134:3::10]:38639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gM02A-00085X-E1
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 19:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gM029-00014h-Hx
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 19:24:54 -0500
MIME-Version: 1.0
References: <20181109173553.22341-1-peter.maydell@linaro.org>
	<20181109173553.22341-3-peter.maydell@linaro.org>
In-Reply-To: <20181109173553.22341-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 01:24:22 +0100
Message-ID: <CAAdtpL5y_F01pnQz-t-8JiQEXxSrijYWuGQ6fWq8t80E_GheGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/2] target/arm/cpu: Give
 Cortex-A15 and -A7 the EL2 feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, adam.lackorzynski@kernkonzept.com, Patch Tracking <patches@linaro.org>

On Fri, Nov 9, 2018 at 6:42 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> The Cortex-A15 and Cortex-A7 both have EL2; now we've implemented

still PL2 there :)

> it properly we can enable the feature bit.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

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
>      cpu->kvm_target =3D QEMU_KVM_ARM_TARGET_CORTEX_A7;
>      cpu->midr =3D 0x410fc075;
> @@ -1633,6 +1634,7 @@ static void cortex_a15_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
>      set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
>      set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
> +    set_feature(&cpu->env, ARM_FEATURE_EL2);
>      set_feature(&cpu->env, ARM_FEATURE_EL3);
>      cpu->kvm_target =3D QEMU_KVM_ARM_TARGET_CORTEX_A15;
>      cpu->midr =3D 0x412fc0f1;
> --
> 2.19.1
>
>
