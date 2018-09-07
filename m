Received: from eggs.gnu.org ([2001:4830:134:3::10]:34056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyLUV-0006OK-32
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 14:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyLUU-0003iL-4P
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 14:28:23 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180831103816.13479-1-clg@kaod.org>
	<20180831103816.13479-6-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dd089705-b87f-625d-a5f3-e2aff3daf9f3@amsat.org>
Date: Fri, 7 Sep 2018 15:28:10 -0300
MIME-Version: 1.0
In-Reply-To: <20180831103816.13479-6-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 05/11] aspeed/smc: fix some
 alignment issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>

On 8/31/18 7:38 AM, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ssi/aspeed_smc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index b29bfd3124a9..1270842dcf0c 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -388,8 +388,8 @@ static uint64_t aspeed_smc_flash_default_read(void *opaque, hwaddr addr,
>  static void aspeed_smc_flash_default_write(void *opaque, hwaddr addr,
>                                             uint64_t data, unsigned size)
>  {
> -   qemu_log_mask(LOG_GUEST_ERROR, "%s: To 0x%" HWADDR_PRIx " of size %u: 0x%"
> -                 PRIx64 "\n", __func__, addr, size, data);
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: To 0x%" HWADDR_PRIx " of size %u: 0x%"
> +                  PRIx64 "\n", __func__, addr, size, data);
>  }
>  
>  static const MemoryRegionOps aspeed_smc_flash_default_ops = {
> @@ -529,7 +529,7 @@ static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
>       */
>      if (aspeed_smc_flash_mode(fl) == CTRL_FREADMODE) {
>          for (i = 0; i < aspeed_smc_flash_dummies(fl); i++) {
> -                ssi_transfer(fl->controller->spi, 0xFF);
> +            ssi_transfer(fl->controller->spi, 0xFF);
>          }
>      }
>  }
> @@ -567,7 +567,7 @@ static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
>  }
>  
>  static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
> -                           unsigned size)
> +                                   unsigned size)
>  {
>      AspeedSMCFlash *fl = opaque;
>      AspeedSMCState *s = fl->controller;
> 
