Received: from eggs.gnu.org ([2001:4830:134:3::10]:38244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX7Fh-0004b7-HT
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX7Fe-0004iM-C3
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:11:45 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:34970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX7Fe-0004iC-5E
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:11:42 -0500
Received: by mail-wm0-x231.google.com with SMTP id r126so118839976wmr.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 06:11:42 -0800 (PST)
References: <1484247815-15279-1-git-send-email-peter.maydell@linaro.org>
	<1484247815-15279-2-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1484247815-15279-2-git-send-email-peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 14:11:39 +0000
Message-ID: <87wpdg8uec.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] stellaris: Document memory map and
 which SoC devices are unimplemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> Add a comment documenting the memory map of the SoC devices and which
> are not implemented.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/stellaris.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index 794a3ad..204502a 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -1220,6 +1220,37 @@ static void stellaris_init(const char *kernel_filename, const char *cpu_model,
>          0x40024000, 0x40025000, 0x40026000};
>      static const int gpio_irq[7] = {0, 1, 2, 3, 4, 30, 31};
>
> +    /* Memory map of SoC devices:

Can we at least have the title of the document these came from for
future reference?

> +     * 40000000 wdtimer (unimplemented)
> +     * 40002000 i2c (unimplemented)
> +     * 40004000 GPIO
> +     * 40005000 GPIO
> +     * 40006000 GPIO
> +     * 40007000 GPIO
> +     * 40008000 SSI
> +     * 4000c000 UART
> +     * 4000d000 UART
> +     * 4000e000 UART
> +     * 40020000 i2c
> +     * 40021000 i2c (unimplemented)
> +     * 40024000 GPIO
> +     * 40025000 GPIO
> +     * 40026000 GPIO
> +     * 40028000 PWM (unimplemented)
> +     * 4002c000 QEI (unimplemented)
> +     * 4002d000 QEI (unimplemented)
> +     * 40030000 gptimer
> +     * 40031000 gptimer
> +     * 40032000 gptimer
> +     * 40033000 gptimer
> +     * 40038000 ADC
> +     * 4003c000 analogue comparator (unimplemented)
> +     * 40048000 ethernet
> +     * 400fc000 hibernation module (unimplemented)
> +     * 400fd000 flash memory control (unimplemented)
> +     * 400fe000 system control
> +     */
> +
>      DeviceState *gpio_dev[7], *nvic;
>      qemu_irq gpio_in[7][8];
>      qemu_irq gpio_out[7][8];


--
Alex Bennée
