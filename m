Received: from eggs.gnu.org ([2001:4830:134:3::10]:54513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqJiH-0003av-1O
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqJi5-0006z7-Ev
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:57:17 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:45807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqJhy-0006wr-Ik
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:57:07 -0400
Received: by mail-oi0-x243.google.com with SMTP id q11-v6so8489439oic.12
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 07:57:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180811090836.4024-2-contrib@steffen-goertz.de>
References: <20180811090836.4024-1-contrib@steffen-goertz.de>
	<20180811090836.4024-2-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 15:56:44 +0100
Message-ID: <CAFEAcA-9ZXojPExwPpzWWYka8QPByYj0D5a2eULzgHTtcDj4SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] hw/arm/nrf51_soc: nRF51 Calculate
 peripheral id from base address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

On 11 August 2018 at 10:08, Steffen G=C3=B6rtz <contrib@steffen-goertz.de> =
wrote:
> The base address determines a peripherals id, which identifies its
> interrupt line, see NRF51 reference manual section 10 peripheral
> interface. This little gem calculates the peripheral id based
> on its base address.
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> ---
>  hw/arm/nrf51_soc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index 9f9649c780..441d05e1ef 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -38,6 +38,9 @@
>  #define NRF51822_FLASH_SIZE     (256 * 1024)
>  #define NRF51822_SRAM_SIZE      (16 * 1024)
>
> +/* IRQ lines can be derived from peripheral base addresses */
> +#define BASE_TO_IRQ(base) (((base) >> 12) & 0x1F)
> +

You could also have macros for getting the base address
from the peripheral ID and the IRQ line from the
peripheral ID, but this is fine too.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
