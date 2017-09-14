Received: from eggs.gnu.org ([2001:4830:134:3::10]:43045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsLTz-00063e-2V
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 00:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsLTv-0003pZ-5p
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 00:10:29 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1504812251-23438-1-git-send-email-sundeep.lkml@gmail.com>
	<2b183ac5-36d8-1da6-cbac-4c6366f23261@amsat.org>
	<CALHRZuoJjSkSYaM9xz8xo2R-=oQEx5a1bkhSirc=NmEpxeG2AQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <28d6a84f-3a32-78ea-7a87-055fb14e1641@amsat.org>
Date: Thu, 14 Sep 2017 01:10:16 -0300
MIME-Version: 1.0
In-Reply-To: <CALHRZuoJjSkSYaM9xz8xo2R-=oQEx5a1bkhSirc=NmEpxeG2AQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu devel v8 PATCH 0/5] Add support for
 Smartfusion2 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sundeep subbaraya <sundeep.lkml@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>

On 09/08/2017 04:24 AM, sundeep subbaraya wrote:
> Hi Phillipe,
> 
> On Fri, Sep 8, 2017 at 3:14 AM, Philippe Mathieu-Daudé <f4bug@amsat.org 
> <mailto:f4bug@amsat.org>> wrote:
> 
>     Hi Subbaraya,
> 
>     very good work!
> 
>     On 09/07/2017 04:24 PM, Subbaraya Sundeep wrote:
> 
>         Hi Qemu-devel,
> 
>         I am trying to add Smartfusion2 SoC.
>         SoC is from Microsemi and System on Module(SOM)
>         board is from Emcraft systems. Smartfusion2 has hardened
>         Microcontroller(Cortex-M3)based Sub System and FPGA fabric.
>         At the moment only system timer, sysreg and SPI
>         controller are modelled.
> 
>         Testing:
>         ./arm-softmmu/qemu-system-arm -M smartfusion2-som -serial
>         mon:stdio \
>         -kernel u-boot.bin -display none -drive
>         file=spi.bin,if=mtd,format=raw
> 
> 
>     "-M emcraft-sf2" ;)
> 
> 
> copy/paste error :)
> 
> 
>     U-Boot 2010.03-00147-g7da5092 (Jul 03 2017 - 09:04:50)
> 
>     CPU  : SmartFusion2 SoC (Cortex-M3 Hard IP)
>     Freqs: CORTEX-M3=142MHz,PCLK0=71MHz,PCLK1=71MHz
>     Board: M2S-FG484-SOM Rev 1A, www.emcraft.com <http://www.emcraft.com>
>     DRAM:  64 MB
>     *** Warning - bad CRC, using default environment
> 
>     In:    serial
>     Out:   serial
>     Err:   serial
>     Net:   M2S_MAC
>     Hit any key to stop autoboot:  0
>     16384 KiB S25FL128P_64K at 0:0 is now current device
>     ## Booting kernel from Legacy Image at a0007fc0 ...
>         Image Name:   dtskernel
>         Image Type:   ARM Linux Kernel Image (uncompressed)
>         Data Size:    2664224 Bytes =  2.5 MB
>         Load Address: a0008000
>         Entry Point:  a0008001
>         Verifying Checksum ... OK
>         Loading Kernel Image ... OK
>     OK
> 
>     Starting kernel ...
> 
>     NVIC: Bad read offset 0xd74
>     [    0.000000] Booting Linux on physical CPU 0x0
>     [    0.000000] Linux version 4.5.0-00001-g3aa90e8-dirty
>     (sundeep@sundeep-Vostro-3458) (gcc version 5.4.0 (GCC) ) #102
>     PREEMPT Tue May 16 19:43:40 IST 2017
>     [    0.000000] CPU: ARMv7-M [410fc231] revision 1 (ARMv7M), cr=00000000
>     [    0.000000] CPU: unknown data cache, unknown instruction cache
>     [    0.000000] Machine model: Microsemi SmartFusion 2 development board
>     [    0.000000] Kernel command line: console=ttyS0,115200n8 panic=10
>     mem=64M@0xa0000000 earlyprintk
>     [    0.000000] Memory: 62204K/65536K available (1472K kernel code,
>     73K rwdata, 652K rodata, 400K init, 120K bss, 3332K reserved, 0K
>     cma-reserved)
>     [    0.000000] NR_IRQS:16 nr_irqs:16 16
>     [    0.001178] sched_clock: 32 bits at 83MHz, resolution 12ns, wraps
>     every 25873297401ns
>     [    0.003085] clocksource: msf2_clocksource: mask: 0xffffffff
>     max_cycles: 0xffffffff, max_idle_ns: 23027234290 ns
>     [    0.009732] timer at 40004000, irq=16
>     [    0.014475] Calibrating delay loop... 442.36 BogoMIPS (lpj=2211840)
>     [    0.653685] Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
>     [    0.690789] console [ttyS0] disabled
>     [    0.696659] 40000000.serial: ttyS0 at MMIO 0x40000000 (irq = 17,
>     base_baud = 5187500) is a 16550
>     [    0.702725] console [ttyS0] enabled
>     [    0.826251] Freeing unused kernel memory: 400K (a021c000 - a0280000)
>     init started: BusyBox v1.24.1 (2017-05-15 09:57:00 IST)
>     ~ #
> 
>     (qemu) info mtree
>     address-space: cpu-memory
>        0000000000000000-ffffffffffffffff (prio 0, i/o): armv7m-container
>          0000000000000000-ffffffffffffffff (prio -1, i/o): system
>            0000000000000000-000000000003ffff (prio 0, i/o): alias
>     MSF2.eNVM.alias @MSF2.eNVM 0000000000000000-000000000003ffff
>            0000000020000000-000000002000ffff (prio 0, ram): MSF2.eSRAM
>            0000000040000000-000000004000001f (prio 0, i/o): serial
>            0000000040001000-000000004000103f (prio 0, i/o): mss-spi
>            0000000040004000-000000004000402f (prio 0, i/o): mss-timer
>            0000000040011000-000000004001103f (prio 0, i/o): mss-spi
>            0000000040038000-00000000400382ff (prio 0, i/o): msf2-sysreg
>            0000000060000000-000000006003ffff (prio 0, rom): MSF2.eNVM
>            00000000a0000000-00000000a3ffffff (prio 0, ram): ddr-ram
>          0000000022000000-0000000023ffffff (prio 0, i/o): bitband
>          0000000042000000-0000000043ffffff (prio 0, i/o): bitband
>          00000000e000e000-00000000e000efff (prio 0, i/o): nvic
>            00000000e000e000-00000000e000efff (prio 0, i/o): nvic_sysregs
>            00000000e000e010-00000000e000e0ef (prio 1, i/o): systick
> 
>     (qemu) info qtree
>     bus: main-system-bus
>        type System
>        dev: msf2-soc, id ""
>          part-name = "M2S010"
>          eNVM-size = 262144 (0x40000)
>          eSRAM-size = 65536 (0x10000)
>          m3clk = 142000000 (0x876bf80)
>          apb0div = 2 (0x2)
>          apb1div = 2 (0x2)
>        dev: mss-spi, id ""
>          gpio-out "sysbus-irq" 2
>          mmio 0000000040011000/0000000000000040
>          bus: spi
>            type SSI
>        dev: mss-spi, id ""
>          gpio-out "sysbus-irq" 2
>          mmio 0000000040001000/0000000000000040
>          bus: spi
>            type SSI
>            dev: s25sl12801, id ""
>              gpio-in "ssi-gpio-cs" 1
>              nonvolatile-cfg = 36863 (0x8fff)
>              spansion-cr1nv = 0 (0x0)
>              spansion-cr2nv = 1 (0x1)
>              spansion-cr3nv = 2 (0x2)
>              spansion-cr4nv = 16 (0x10)
>              drive = "mtd0"
>        dev: mss-timer, id ""
>          gpio-out "sysbus-irq" 2
>          clock-frequency = 71000000 (0x43b5fc0)
>          mmio 0000000040004000/0000000000000030
>        dev: msf2-sysreg, id ""
>          apb0divisor = 2 (0x2)
>          apb1divisor = 2 (0x2)
>          mmio 0000000040038000/0000000000000300
> 
>     So far:
>     Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org
>     <mailto:f4bug@amsat.org>>
> 
> 
> Thanks for testing.
> 
> 
>     Just some comments (no need to fix):
> 
> 
> Thank you, I will look into these errors once the patchset gets into the 
> tree.
> 
> 
>     M2S-FG484-SOM> reset
>     resetting ...
>     M2S-FG484-SOM>
> 
>     Hmm no reset, I was expecting some unimp/guest-error warning.
> 
>     M2S-FG484-SOM> tftpboot
>     m2s_eth_init: FIFO initialization timeout
>     *** m2s_mac_dump_regs FIFO init:
>       DMA TX CTRL=00000000;DESC=00000000;STAT=00000000
>       DMA RX CTRL=00000000;DESC=00000000;STAT=00000000
>       DMA IRQ 00000000/00000000
>       CFG1=00000000;CFG2=00000000;IFG=00000000;HD=00000000;MFL=00000000
>       IFCTRL=00000000;IFSTAT=00000000;ADR1=00000000;ADR2=00000000
>       FIFO CFG 00000000/00000000/00000000/00000000/00000000/00000000/
>       FIFO ACC
>     00000000/00000000/00000000/00000000/00000000/00000000/00000000/00000000/
> 
>     (same unimp/guest-error warning)
> 
> If device is not implemented how do I print warning when guest access 
> that device?

in hw/arm/msf2-soc.c:

     create_unimplemented_device("emac",  0x40041000, 0x1000);

and while here:

     create_unimplemented_device("i2c_0", 0x40002000, 0x1000);
     create_unimplemented_device("i2c_1", 0x40012000, 0x1000);
     create_unimplemented_device("rtc",   0x40017000, 0x1000);
     create_unimplemented_device("usb",   0x40043000, 0x1000);

Then you'll see unimp access running "qemu-system-arm -d unimp"

This can be another patch although.

Regards,

Phil.

> 
> Thanks,
> Sundeep
> 
> 
>     M2S-FG484-SOM> sf erase 0 0x1000
>     UNHANDLED EXCEPTION: HARD FAULT
>        R0    = 00000072  R1  = 00000072
>        R2    = 09fa3af0  R3  = 004c8000
>        R12   = 00000004  LR  = 00000a27
>        PC    = 0000ec98  PSR = 01000000
>     [hang]
>     IN:
>     0x0000029e:  e7fe       b.n     0x29e
> 
> 
> 
> 
> 
>         Binaries u-boot.bin and spi.bin are at:
>         https://github.com/Subbaraya-Sundeep/qemu-test-binaries.git
>         <https://github.com/Subbaraya-Sundeep/qemu-test-binaries.git>
> 
>         U-boot is from Emcraft with modified
>               - SPI driver not to use PDMA.
>               - ugly hack to pass dtb to kernel in r1.
>         @
>         https://github.com/Subbaraya-Sundeep/emcraft-uboot-sf2.git
>         <https://github.com/Subbaraya-Sundeep/emcraft-uboot-sf2.git>
> 
>         Linux is 4.5 linux with Smartfusion2 SoC dts and clocksource
>         driver added by myself @
>         https://github.com/Subbaraya-Sundeep/linux.git
>         <https://github.com/Subbaraya-Sundeep/linux.git>
> 
>         v8:
>                  memory_region_init_ram to memory_region_init_rom in soc
>                  %s/emcraft_sf2_init/emcraft_sf2_s2s010_init/g in som
>                  Added mc->ignore_memory_transaction_failures = true in som
>                          as per latest commit.
>                  Code simplifications as suggested by Alistair in sysreg
>         and ssi.
> 
>         v7:
>                  Removed vmstate_register_ram_global as per latest commit
>                  Moved header files to C which are local to C source files
>                  Removed abort() from msf2-sysreg.c
>                  Added VMStateDescription in mss-timer.c
> 
>         v6:
>               Moved some defines from header files to source files
>               Added properties m3clk, apb0div, apb0div1 properties
>               to soc.
>               Added properties apb0divisor, apb1divisor to sysreg
>               Update system_clock_source in msf2-soc.c
>               Changed machine name smartfusion2-som->emcraft-sf2
> 
>         v5
>               As per Philippe comments:
>                   Added abort in Sysreg if guest tries to remap memory
>                   other than default mapping.
>                   Use of CONFIG_MSF2 in Makefile for soc.c
>                   Fixed incorrect logic in timer model.
>                   Renamed msf2-timer.c -> mss-timer.c
>                           msf2-spi.c -> mss-spi.c also type names
>                   Renamed function msf2_init->emcraft_sf2_init in msf2-som.c
>                   Added part-name,eNVM-size,eSRAM-size,pclk0 and pclk1
>                       properties to soc.
>                   Pass soc part-name,memory size and clock rate
>         properties from som.
>         v4:
>               Fixed build failure by using PRIx macros.
>         v3:
>               Added SoC file and board file as per Alistair comments.
>         v2:
>               Added SPI controller so that u-boot loads kernel from spi
>         flash.
>         v1:
>               Initial patch set with timer and sysreg
> 
>         Thanks,
>         Sundeep
> 
> 
>         Subbaraya Sundeep (5):
>             msf2: Add Smartfusion2 System timer
>             msf2: Microsemi Smartfusion2 System Register block
>             msf2: Add Smartfusion2 SPI controller
>             msf2: Add Smartfusion2 SoC
>             msf2: Add Emcraft's Smartfusion2 SOM kit
> 
>            default-configs/arm-softmmu.ma <http://arm-softmmu.ma>k |   1 +
>            hw/arm/Makefile.objs            |   1 +
>            hw/arm/msf2-soc.c               | 218 ++++++++++++++++++++++
>            hw/arm/msf2-som.c               |  95 ++++++++++
>            hw/misc/Makefile.objs           |   1 +
>            hw/misc/msf2-sysreg.c           | 195 +++++++++++++++++++
>            hw/ssi/Makefile.objs            |   1 +
>            hw/ssi/mss-spi.c                | 404
>         ++++++++++++++++++++++++++++++++++++++++
>            hw/timer/Makefile.objs          |   1 +
>            hw/timer/mss-timer.c            | 289
>         ++++++++++++++++++++++++++++
>            include/hw/arm/msf2-soc.h       |  66 +++++++
>            include/hw/misc/msf2-sysreg.h   |  78 ++++++++
>            include/hw/ssi/mss-spi.h        |  58 ++++++
>            include/hw/timer/mss-timer.h    |  64 +++++++
>            14 files changed, 1472 insertions(+)
>            create mode 100644 hw/arm/msf2-soc.c
>            create mode 100644 hw/arm/msf2-som.c
>            create mode 100644 hw/misc/msf2-sysreg.c
>            create mode 100644 hw/ssi/mss-spi.c
>            create mode 100644 hw/timer/mss-timer.c
>            create mode 100644 include/hw/arm/msf2-soc.h
>            create mode 100644 include/hw/misc/msf2-sysreg.h
>            create mode 100644 include/hw/ssi/mss-spi.h
>            create mode 100644 include/hw/timer/mss-timer.h
> 
> 
