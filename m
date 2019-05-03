Received: from eggs.gnu.org ([209.51.188.92]:35556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYQh-0007BC-Ve
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYQg-0007df-6x
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:40:47 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYQf-0007d6-Ot
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:40:46 -0400
Received: by mail-oi1-x244.google.com with SMTP id t70so4433293oif.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 06:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556774049.git.alistair@alistair23.me>
	<PSXP216MB027781B1165E352FF6150A09DD340@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB027781B1165E352FF6150A09DD340@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 14:40:33 +0100
Message-ID: <CAFEAcA_bjcpvDOq=p+er3Lo9G7UfVgoXCtP87SknWTr8W=3aaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/5] hw/misc: Add the STM32F4xx
 Sysconfig device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>

On Thu, 2 May 2019 at 06:40, Alistair Francis <alistair@alistair23.me> wrote:
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

> +static void stm32f4xx_syscfg_set_irq(void *opaque, int irq, int level)
> +{
> +    STM32F4xxSyscfgState *s = opaque;
> +    int icrreg = irq / 4;
> +    int startbit = (irq & 3) * 4;
> +    uint8_t config = config = irq / 16;;

Stray double-semicolon.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
