Received: from eggs.gnu.org ([2001:4830:134:3::10]:42054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqKTc-0001JB-5v
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqKTZ-0001WW-FN
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:46:19 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqKTY-0001Vx-MN
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:46:16 -0400
Received: by mail-oi0-x244.google.com with SMTP id q11-v6so8796863oic.12
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:46:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180806100114.21410-2-contrib@steffen-goertz.de>
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
	<20180806100114.21410-2-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 16:45:54 +0100
Message-ID: <CAFEAcA9XLUz5qOXtRrYZ=K4zBPMc6QYGwiga0xQtSaf0P8MBaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] hw/misc/nrf51_rng: Add NRF51 random
 number generator peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Thomas Huth <thuth@redhat.com>

On 6 August 2018 at 11:01, Steffen G=C3=B6rtz <contrib@steffen-goertz.de> w=
rote:
> Add a model of the NRF51 random number generator peripheral.
> This is a simple random generator that continuously generates
> new random values after startup.
>
> Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> ---
>  hw/misc/Makefile.objs       |   1 +
>  hw/misc/nrf51_rng.c         | 273 ++++++++++++++++++++++++++++++++++++
>  include/hw/misc/nrf51_rng.h |  71 ++++++++++
>  3 files changed, 345 insertions(+)
>  create mode 100644 hw/misc/nrf51_rng.c
>  create mode 100644 include/hw/misc/nrf51_rng.h

> +static void update_irq(Nrf51RNGState *s)

See remark on other patch about consistency of struct naming.

> +{
> +    bool irq =3D false;
> +    irq |=3D s->interrupt_enabled && s->event_valrdy;

You don't need to set irq to false and then modify it;
this is equivalent to
   bool irq =3D s->interrupt_enabled && s->event_valrdy;

> +    qemu_set_irq(s->irq, irq);
> +}

> +static void nrf51_rng_reset(DeviceState *dev)
> +{
> +    Nrf51RNGState *s =3D NRF51_RNG(dev);

This seems to be missing code to actually reset the fields ?

> +
> +    rng_update_timer(s);
> +}

Otherwise the device looks good.

thanks
-- PMM
