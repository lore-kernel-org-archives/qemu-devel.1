Received: from eggs.gnu.org ([2001:4830:134:3::10]:53225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejq1e-0001vL-D1
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:30:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejq1d-0004ao-8s
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:30:22 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejq1d-0004ZY-3p
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:30:21 -0500
Received: by mail-oi0-x243.google.com with SMTP id u6so4060619oiv.9
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:30:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180208172202.9984-2-f4bug@amsat.org>
References: <20180208172202.9984-1-f4bug@amsat.org>
	<20180208172202.9984-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 17:30:00 +0000
Message-ID: <CAFEAcA_0rt7cCJs43BjW3OcQh=oeby+4j2dtFPSzgCn9tqW1qQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/arm/aspeed: directly map the serial
 device to the system address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 8 February 2018 at 17:22, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/aspeed_soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index c83b7e207b..a786750e14 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -257,7 +257,7 @@ static void aspeed_soc_realize(DeviceState *dev, Erro=
r **errp)
>      /* UART - attach an 8250 to the IO space as our UART5 */
>      if (serial_hds[0]) {
>          qemu_irq uart5 =3D qdev_get_gpio_in(DEVICE(&s->vic), uart_irqs[4=
]);
> -        serial_mm_init(&s->iomem, ASPEED_SOC_UART_5_BASE, 2,
> +        serial_mm_init(get_system_memory(), ASPEED_SOC_UART_5_BASE, 2,
>                         uart5, 38400, serial_hds[0], DEVICE_LITTLE_ENDIAN=
);
>      }

Is this a bug fix? It certainly changes behaviour, which
suggests that a fuller commit message would be useful.

thanks
-- PMM
