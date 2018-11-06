Received: from eggs.gnu.org ([2001:4830:134:3::10]:57401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK6KL-00028B-Cv
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:43:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK6KJ-0005Zo-Qm
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:43:49 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:42162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gK6KJ-0004yA-4U
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:43:47 -0500
Received: by mail-oi1-x22e.google.com with SMTP id x63-v6so7917279oix.9
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 10:43:38 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 18:43:17 +0000
Message-ID: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] List of files containing devices which have not been
 QOMified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

I had an idea for how to get a rough list of source files
containing devices that haven't been QOMified. The theory
is that a pre-QOM device generally has an "init" function
which allocates memory for the device struct. So looking in
hw/ for files which call g_new*() or g_malloc*() should get
us all the non-QOM devices (as well as a pile of false
positives, of course). The following link is the result of
doing that and then eyeballing the results for false positives
and throwing those out. It might have missed one or two
files or included one or two by mistake. But I think it's
pretty close, and it seems to have caught all the obvious
ones I knew about. There are 61 files on this list.

I am also suspicious about hw/bt/ but don't know enough
about that subsystem to say if it could benefit from
using QOM objects more.

hw/arm/exynos4210.c
hw/arm/nseries.c
hw/arm/omap1.c
hw/arm/omap2.c
hw/arm/pxa2xx.c
hw/arm/stellaris.c
hw/arm/strongarm.c
hw/char/omap_uart.c
hw/char/parallel.c
hw/char/serial.c
hw/char/sh_serial.c
hw/core/ptimer.c
hw/cris/axis_dev88.c
hw/display/blizzard.c
hw/display/omap_dss.c
hw/display/omap_lcdc.c
hw/display/pxa2xx_lcd.c
hw/display/tc6393xb.c
hw/display/vga-isa-mm.c
hw/dma/etraxfs_dma.c
hw/dma/omap_dma.c
hw/dma/rc4030.c
hw/dma/soc_dma.c
hw/i2c/bitbang_i2c.c
hw/ide/ahci.c
hw/input/pckbd.c
hw/input/ps2.c
hw/input/pxa2xx_keypad.c
hw/input/stellaris_input.c
hw/input/tsc2005.c
hw/input/tsc210x.c
hw/m68k/mcf5206.c
hw/m68k/mcf5208.c
hw/mips/mips_malta.c
hw/misc/cbus.c
hw/misc/omap_clk.c
hw/misc/omap_gpmc.c
hw/misc/omap_l4.c
hw/misc/omap_sdrc.c
hw/openrisc/cputimer.c
hw/pci/shpc.c ?
hw/ppc/ppc405_boards.c
hw/ppc/ppc405_uc.c
hw/ppc/ppc440_uc.c
hw/ppc/ppc4xx_devs.c
hw/ppc/ppc_booke.c
hw/ppc/prep.c
hw/riscv/riscv_htif.c
hw/riscv/sifive_uart.c
hw/sd/omap_mmc.c
hw/sh4/r2d.c
hw/sh4/sh7750.c
hw/sparc64/sparc64.c
hw/ssi/omap_spi.c
hw/timer/arm_timer.c
hw/timer/mips_gictimer.c
hw/timer/omap_gptimer.c
hw/timer/omap_synctimer.c
hw/timer/sh_timer.c
hw/usb/hcd-musb.c
hw/xtensa/xtfpga.c

thanks
-- PMM
