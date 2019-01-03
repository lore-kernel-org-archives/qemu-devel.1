Received: from eggs.gnu.org ([208.118.235.92]:52648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf5pF-0006Vt-6d
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:26:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf5pE-00073l-Di
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:26:29 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gf5pE-00071B-6t
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:26:28 -0500
Received: by mail-ot1-x342.google.com with SMTP id n8so29814633otl.6
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 08:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20181211031044.27628-1-joel@jms.id.au>
	<20181211031044.27628-3-joel@jms.id.au>
In-Reply-To: <20181211031044.27628-3-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jan 2019 16:26:14 +0000
Message-ID: <CAFEAcA-KoxgDuWtCfZqzGgMgQrxRiMYfwt31eU12CQOPW_pSMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] aspeed/scu: Implement power off
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 11 Dec 2018 at 03:11, Joel Stanley <joel@jms.id.au> wrote:
>
> This register does not exist in hardware. It is here to allow the guest
> code to cause Qemu to exit when required.
>
> The register address chosen is unused in the emulated machines
> datasheets.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  hw/misc/aspeed_scu.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index c8217740efc1..aa17d032ba93 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -16,6 +16,7 @@
>  #include "qapi/visitor.h"
>  #include "qemu/bitops.h"
>  #include "qemu/log.h"
> +#include "sysemu/sysemu.h"
>  #include "crypto/random.h"
>  #include "trace.h"
>
> @@ -84,6 +85,7 @@
>  #define SRAM_DECODE_BASE1    TO_REG(0x194)
>  #define SRAM_DECODE_BASE2    TO_REG(0x198)
>  #define BMC_REV              TO_REG(0x19C)
> +#define POWEROFF             TO_REG(0x1A0)
>  #define BMC_DEV_ID           TO_REG(0x1A4)

I'm always a bit dubious about adding things to QEMU devices
which don't exist in the real hardware we're emulating. If we
do want to do that, I think we should clearly flag them up as
being QEMU-specific with suitable comments and naming of
the #define, etc.

thanks
-- PMM
