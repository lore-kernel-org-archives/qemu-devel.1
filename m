Received: from eggs.gnu.org ([2001:4830:134:3::10]:59647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbwYz-0006Rm-2K
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 16:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbwYu-0001Ei-6L
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 16:47:37 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1486648058-520-1-git-send-email-clg@kaod.org>
	<1486648058-520-3-git-send-email-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4fcd2d72-e970-8e03-4741-52a5e9ed2af0@amsat.org>
Date: Thu, 9 Feb 2017 18:47:24 -0300
MIME-Version: 1.0
In-Reply-To: <1486648058-520-3-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] aspeed: remove useless comment on
 controller segment size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>



On 02/09/2017 10:47 AM, Cédric Le Goater wrote:
> The flash devices used for the FMC controller (BMC firmware) are well
> defined for each Aspeed machine and are all smaller than the default
> mapping window size, at least for CE0 which is the chip the SoC boots
> from.
>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/aspeed.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index ac9cbd66b72a..283c03881493 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -148,10 +148,6 @@ static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
>          DriveInfo *dinfo = drive_get_next(IF_MTD);
>          qemu_irq cs_line;
>
> -        /*
> -         * FIXME: check that we are not using a flash module exceeding
> -         * the controller segment size
> -         */
>          fl->flash = ssi_create_slave_no_init(s->spi, flashtype);
>          if (dinfo) {
>              qdev_prop_set_drive(fl->flash, "drive", blk_by_legacy_dinfo(dinfo),
> @@ -210,7 +206,9 @@ static void aspeed_board_init(MachineState *machine,
>
>          /*
>           * create a ROM region using the default mapping window size of
> -         * the flash module.
> +         * the flash module. The window size is 64MB for the AST2400
> +         * SoC and 128MB for the AST2500 SoC, which is twice as big as
> +         * needed by the flash modules of the Aspeed machines.
>           */
>          memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
>                                 fl->size, &error_abort);
>
