Received: from eggs.gnu.org ([2001:4830:134:3::10]:47210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkCLj-0006oh-DC
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkCLi-0002aP-K3
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:52:51 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:44275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkCLi-0002Zy-Ej
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 13:52:50 -0400
Received: by mail-oi0-x243.google.com with SMTP id s198-v6so22871600oih.11
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 10:52:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180725085944.11856-5-stefanha@redhat.com>
References: <20180725085944.11856-1-stefanha@redhat.com>
	<20180725085944.11856-5-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 18:52:29 +0100
Message-ID: <CAFEAcA92R=_aLRSJ0Jqsir8kmcFExNUUhZgyw0PSDuSc--GD6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 4/7] target/arm: add "cortex-m0" CPU
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Alistair Francis <alistair@alistair23.me>, Liviu Ionescu <ilg@livius.net>, qemu-arm <qemu-arm@nongnu.org>, Julia Suvorova <jusual@mail.ru>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Steffen Gortz <qemu.ml@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>

On 25 July 2018 at 09:59, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Define a "cortex-m0" ARMv6-M CPU model.
>
> Most of the register reset values set by other CPU models are not
> relevant for the cut-down ARMv6-M architecture.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  target/arm/cpu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 3848ef46aa..7e477c0d23 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1255,6 +1255,15 @@ static void arm11mpcore_initfn(Object *obj)
>      cpu->reset_auxcr = 1;
>  }
>
> +static void cortex_m0_initfn(Object *obj)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    set_feature(&cpu->env, ARM_FEATURE_V6);
> +    set_feature(&cpu->env, ARM_FEATURE_M);
> +
> +    cpu->midr = 0x410cc200;
> +}

We have all the patches for turning off not-v6M bits of
behaviour either in master or in target-arm.for-3.1 already,
right?

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
