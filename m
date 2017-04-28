Received: from eggs.gnu.org ([2001:4830:134:3::10]:60741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1d498I-0003qr-GL
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1d498F-00064B-E7
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:52:38 -0400
From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Date: Fri, 28 Apr 2017 22:21:48 +0530
Message-Id: <1493398313-6673-1-git-send-email-sundeep.lkml@gmail.com>
Subject: [Qemu-devel] [Qemu-devel RFC v3 0/5] Add support for Smartfusion2
 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, crosthwaite.peter@gmail.com, alistair23@gmail.com, Subbaraya Sundeep <sundeep.lkml@gmail.com>

Hi Qemu-devel,

I am trying to add Smartfusion2 SoC.
SoC is from Microsemi and System on Module(SOM)
board is from Emcraft systems. Smartfusion2 has hardened
Microcontroller(Cortex-M3)based Sub System and FPGA fabric.
At the moment only system timer, sysreg and SPI
controller are modelled.

Testing:
./arm-softmmu/qemu-system-arm -M smartfusion2-som -serial mon:stdio \
-kernel u-boot.bin -display none -drive file=spi.bin,if=mtd,format=raw

U-boot is from Emcraft with modified SPI driver not to use PDMA.
Linux is 4.5 linux with Smartfusion2 SoC dts and clocksource 
driver added by myself @
https://github.com/Subbaraya-Sundeep/linux.git

Baremetal elfs from Microsemi Softconsole IDE are also working.

Changes from v2:
    Added SoC file and board file.
Changes from v1:
    Added SPI controller.

Thanks,
Sundeep


Subbaraya Sundeep (5):
  msf2: Add Smartfusion2 System timer
  msf2: Microsemi Smartfusion2 System Register block.
  msf2: Add Smartfusion2 SPI controller
  msf2: Add Smartfusion2 SoC.
  msf2: Add Emcraft's Smartfusion2 SOM kit.

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/Makefile.objs            |   3 +-
 hw/arm/msf2_soc.c               | 194 +++++++++++++++++++++
 hw/arm/msf2_som.c               |  68 ++++++++
 hw/misc/Makefile.objs           |   1 +
 hw/misc/msf2_sysreg.c           | 127 ++++++++++++++
 hw/ssi/Makefile.objs            |   1 +
 hw/ssi/msf2_spi.c               | 373 ++++++++++++++++++++++++++++++++++++++++
 hw/timer/Makefile.objs          |   1 +
 hw/timer/msf2_timer.c           | 250 +++++++++++++++++++++++++++
 include/hw/arm/msf2_soc.h       |  62 +++++++
 include/hw/misc/msf2_sysreg.h   |  77 +++++++++
 include/hw/ssi/msf2_spi.h       | 102 +++++++++++
 include/hw/timer/msf2_timer.h   |  82 +++++++++
 14 files changed, 1341 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/msf2_soc.c
 create mode 100644 hw/arm/msf2_som.c
 create mode 100644 hw/misc/msf2_sysreg.c
 create mode 100644 hw/ssi/msf2_spi.c
 create mode 100644 hw/timer/msf2_timer.c
 create mode 100644 include/hw/arm/msf2_soc.h
 create mode 100644 include/hw/misc/msf2_sysreg.h
 create mode 100644 include/hw/ssi/msf2_spi.h
 create mode 100644 include/hw/timer/msf2_timer.h

-- 
2.5.0
