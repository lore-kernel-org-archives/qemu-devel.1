Received: from eggs.gnu.org ([2001:4830:134:3::10]:49710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1cyVJs-0000PX-GP
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 23:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1cyVJr-0008Ee-Ia
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 23:21:16 -0400
MIME-Version: 1.0
In-Reply-To: <1491736758-19540-1-git-send-email-sundeep.lkml@gmail.com>
References: <1491736758-19540-1-git-send-email-sundeep.lkml@gmail.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Thu, 13 Apr 2017 08:51:12 +0530
Message-ID: <CALHRZurSfOAt53Sf=aGdGe7cHCxNggjUrt6pPDEQLRcvfX_cDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-devel RFC v2 0/4] Add support for
 Smartfusion2 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>

Hi Qemu-devel,

This is my first attempt in Qemu.
Please let me know am doing correct or not.
SoC is cortex M3 based so no bootrom stuff and unlike other
SoCs Qemu need not load dtb and kernel in DDR. Hence am using
u-boot (supplied with -kernel) as bootloader in eNVM and it loads
kernel from SPI flash to DDR same like real hardware scenario.
Also let me know any other Maintainers need to be CCed.

Thank you,
Sundeep

On Sun, Apr 9, 2017 at 4:49 PM, Subbaraya Sundeep
<sundeep.lkml@gmail.com> wrote:
> Hi Qemu-devel,
>
> I am trying to add Smartfusion2 SoC.
> SoC is from Microsemi and System on Module(SOM)
> board is from Emcraft systems. Smartfusion2 has hardened
> Microcontroller(Cortex-M3)based Sub System and FPGA fabric.
> At the moment only system timer, sysreg and SPI
> controller are modelled.
>
> Testing:
> ./arm-softmmu/qemu-system-arm -M smartfusion2-som -serial mon:stdio \
> -kernel u-boot.bin -display none -drive file=spi.bin,if=mtd,format=raw
>
> U-boot is from Emcraft with modified SPI driver not to use PDMA.
> Linux is 4.5 linux with Smartfusion2 SoC dts and clocksource
> driver added by myself @
> https://github.com/Subbaraya-Sundeep/linux.git
>
> Baremetal elfs from Microsemi Softconsole IDE are also working.
>
> Changes from v1:
>     Added SPI controller.
>
> Thanks,
> Sundeep
>
> Subbaraya Sundeep (4):
>   msf2: Add Smartfusion2 System timer
>   msf2: Microsemi Smartfusion2 System Register block.
>   msf2: Add Smartfusion2 SPI controller
>   msf2: Add Emcraft's Smartfusion2 SOM kit.
>
>  default-configs/arm-softmmu.mak |   1 +
>  hw/arm/Makefile.objs            |   2 +-
>  hw/arm/msf2_soc.c               | 141 +++++++++++++
>  hw/misc/Makefile.objs           |   1 +
>  hw/misc/msf2_sysreg.c           | 168 +++++++++++++++
>  hw/ssi/Makefile.objs            |   1 +
>  hw/ssi/msf2_spi.c               | 449 ++++++++++++++++++++++++++++++++++++++++
>  hw/timer/Makefile.objs          |   1 +
>  hw/timer/msf2_timer.c           | 273 ++++++++++++++++++++++++
>  9 files changed, 1036 insertions(+), 1 deletion(-)
>  create mode 100644 hw/arm/msf2_soc.c
>  create mode 100644 hw/misc/msf2_sysreg.c
>  create mode 100644 hw/ssi/msf2_spi.c
>  create mode 100644 hw/timer/msf2_timer.c
>
> --
> 2.5.0
>
