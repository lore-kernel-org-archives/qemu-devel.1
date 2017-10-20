Received: from eggs.gnu.org ([2001:4830:134:3::10]:54238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5NXY-0005qP-EX
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5NXV-0008KZ-E4
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:00:04 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171019163546.2039-1-clg@kaod.org>
	<20171019163546.2039-9-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2348bd8d-3247-c0f8-8a75-59b9ea0b2732@amsat.org>
Date: Thu, 19 Oct 2017 23:59:49 -0300
MIME-Version: 1.0
In-Reply-To: <20171019163546.2039-9-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 8/8] aspeed: add the pc9552 chips to the
 witherspoon machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>

On 10/19/2017 01:35 PM, Cédric Le Goater wrote:
> The pca9552 LED blinkers on the Witherspoon machine are used for leds
> but also as GPIOs to control fans and GPUs.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  hw/arm/aspeed.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index df7f266800ba..0e2a4fa62c26 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -397,6 +397,8 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
>      AspeedSoCState *soc = &bmc->soc;
>      uint8_t *eeprom_buf = g_malloc0(8 * 1024);
>  
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), "pca9552", 0x60);

TYPE_PCA9552 ?

> +
>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423", 0x4c);
>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423", 0x4c);
>  
> @@ -409,6 +411,8 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
>  
>      smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), 0x51,
>                            eeprom_buf);
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "pca9552",

ditto

> +                     0x60);
>  }
>  
>  static void witherspoon_bmc_init(MachineState *machine)
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
