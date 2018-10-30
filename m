Received: from eggs.gnu.org ([2001:4830:134:3::10]:36569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHUg8-0000Gb-Vh
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHUfz-0000yU-Py
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:07:30 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHUfy-0000we-5h
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:07:22 -0400
Received: by mail-ot1-x342.google.com with SMTP id o14so11189293oth.4
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:07:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181030114048.21527-3-philmd@redhat.com>
References: <20181030114048.21527-1-philmd@redhat.com>
	<20181030114048.21527-3-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 14:06:59 +0000
Message-ID: <CAFEAcA-4_fn19H9aCio4QKikdMBv_oicgWNrThCXshNJ3HOnig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] arm: exynos4: Add dma support for
 smdkc210
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 30 October 2018 at 11:40, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> From: Guenter Roeck <linux@roeck-us.net>
>
> QEMU already supports pl330. Instantiate it for smdkc210.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> [PMD: Do not set default qdev properties]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/arm/exynos4_boards.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

>  static void exynos4_boards_init_ram(Exynos4BoardState *s,
>                                      MemoryRegion *system_mem,
>                                      unsigned long ram_size)
> @@ -171,6 +187,14 @@ static void smdkc210_init(MachineState *machine)
>
>      lan9215_init(SMDK_LAN9118_BASE_ADDR,
>              qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(37, 1)]=
));
> +
> +    pl330_init(SMDK_PL330_BASE0_ADDR,
> +            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(35, 1)]=
), 32);
> +    pl330_init(SMDK_PL330_BASE1_ADDR,
> +            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(36, 1)]=
), 32);
> +    pl330_init(SMDK_PL330_BASE2_ADDR,
> +            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(34, 1)]=
), 1);
> +
>      arm_load_kernel(ARM_CPU(first_cpu), &exynos4_board_binfo);
>  }

Are the PL330s really on the board and not part of the SoC? The
layout of the dts files in the kernel suggests they're in the
SoC, in which case they would belong in hw/arm/exynos4210.c.

thanks
-- PMM
