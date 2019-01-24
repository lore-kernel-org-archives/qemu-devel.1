Received: from eggs.gnu.org ([209.51.188.92]:59018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmbhW-0006nP-MO
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmbhV-0004X5-W3
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:53:34 -0500
References: <20190123212234.32068-1-stefanha@redhat.com>
	<20190123212234.32068-6-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8b7397c4-1e92-0e8f-b394-1d8f45141623@redhat.com>
Date: Thu, 24 Jan 2019 10:53:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190123212234.32068-6-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/5] tests/microbit-test: Add tests for
 nRF51 NVMC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, qemu-block@nongnu.org, qemu-arm@nongnu.org, jusual@mail.ru, Laurent Vivier <lvivier@redhat.com>, jim@groklearning.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, Richard Henderson <rth@twiddle.net>

On 2019-01-23 22:22, Stefan Hajnoczi wrote:
> From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
>=20
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/microbit-test.c | 97 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>=20
> diff --git a/tests/microbit-test.c b/tests/microbit-test.c
> index 0c125535f6..d3edd38643 100644
> --- a/tests/microbit-test.c
> +++ b/tests/microbit-test.c
> @@ -20,8 +20,104 @@
> =20
>  #include "hw/arm/nrf51.h"
>  #include "hw/gpio/nrf51_gpio.h"
> +#include "hw/nvram/nrf51_nvm.h"
>  #include "hw/timer/nrf51_timer.h"
> =20
> +#define FLASH_SIZE          (256 * NRF51_PAGE_SIZE)
> +
> +static void fill_and_erase(hwaddr base, hwaddr size, uint32_t address_=
reg)
> +{
> +    hwaddr i;
> +
> +    /* Erase Page */
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x02);
> +    writel(NRF51_NVMC_BASE + address_reg, base);
> +    writel(NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x00);

I think you might have a conflict here with Julia's patch
"tests/microbit-test: Make test independent of global_qtest". Could you
please have a look (and e.g. include Julia's patches in your series)?

 Thanks,
  Thomas
