Received: from eggs.gnu.org ([2001:4830:134:3::10]:52724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFyjn-00021L-Vm
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFyjn-00049e-21
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:16:47 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:36551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fFyjm-00049S-SX
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:16:46 -0400
Received: by mail-ot0-x242.google.com with SMTP id m11-v6so29089875otf.3
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 02:16:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180427110137.19304-1-peter.maydell@linaro.org>
References: <20180427110137.19304-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 10:16:25 +0100
Message-ID: <CAFEAcA-X1-D4G4KLmXrTpQ_Yz6O3Pyzj63ir3MjiR4ZkqOF=kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw/arm/iotkit.c: fix minor
 memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

ping for review?

thanks
-- PMM

On 27 April 2018 at 12:01, Peter Maydell <peter.maydell@linaro.org> wrote:
> Coverity (CID1390573) spots that we forgot to free the
> gpioname strings in a loop in the iotkit realize function.
> Correct the error.
>
> This isn't a significant leak, because this function
> only ever runs once.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/iotkit.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
> index c5f0a5b98a..234185e8f7 100644
> --- a/hw/arm/iotkit.c
> +++ b/hw/arm/iotkit.c
> @@ -517,6 +517,7 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
>                                qdev_get_gpio_in(DEVICE(&s->ppc_irq_orgate), i));
>          qdev_connect_gpio_out_named(DEVICE(ppc), "irq", 0,
>                                      qdev_get_gpio_in(devs, 0));
> +        g_free(gpioname);
>      }
>
>      iotkit_forward_sec_resp_cfg(s);
> --
> 2.17.0
