Received: from eggs.gnu.org ([2001:4830:134:3::10]:55511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dwdUF-0002fo-Q7
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 20:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dwdUB-0005OE-La
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 20:12:31 -0400
Received: from mail-sn1nam01on0044.outbound.protection.outlook.com
	([104.47.32.44]:27168
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dwdUB-0005NV-2f
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 20:12:27 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 25 Sep 2017 17:08:34 -0700
Message-ID: <cover.1506384414.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 0/8]  Remove some of the fprintf(stderr, "*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com


Continue on improving QEMUs logging/error messages by removing more
fprintf()'s.

Unfortunatley my Coccinelle skills aren't that great so it's all done in
some nasty regex and a little bit of manual work.



Alistair Francis (8):
  Replace all occurances of __FUNCTION__ with __func__
  tests: Replace fprintf(stderr, "*\n" with error_report()
  hw: Replace fprintf(stderr, "*\n" with error_report()
  block: Replace fprintf(stderr, "*\n" with error_report()
  util: Replace fprintf(stderr, "*\n" with error_report()
  ui: Replace fprintf(stderr, "*\n" with error_report()
  tcg: Replace fprintf(stderr, "*\n" with error_report()
  target: Replace fprintf(stderr, "*\n" with error_report()

 audio/audio_int.h                      |   2 +-
 block/file-posix.c                     |   6 +-
 block/file-win32.c                     |   3 +-
 block/linux-aio.c                      |   5 +-
 block/parallels.c                      |   7 ++-
 block/qcow2-cluster.c                  |   2 +-
 block/qcow2-refcount.c                 |  95 +++++++++++++++--------------=
--
 block/qcow2.c                          |   8 +--
 block/quorum.c                         |   5 +-
 block/ssh.c                            |   4 +-
 block/vdi.c                            |  14 +++--
 block/vpc.c                            |   5 +-
 block/vvfat.c                          |  99 ++++++++++++++++++-----------=
----
 cpus.c                                 |   8 +--
 exec.c                                 |  14 ++---
 hw/arm/armv7m.c                        |   2 +-
 hw/arm/boot.c                          |  34 +++++------
 hw/arm/gumstix.c                       |  13 +++--
 hw/arm/mainstone.c                     |   7 ++-
 hw/arm/musicpal.c                      |   2 +-
 hw/arm/nseries.c                       |   2 +-
 hw/arm/omap1.c                         |  45 +++++++--------
 hw/arm/omap2.c                         |  23 ++++----
 hw/arm/omap_sx1.c                      |   6 +-
 hw/arm/palm.c                          |  20 +++----
 hw/arm/pxa2xx.c                        |  53 +++++++++---------
 hw/arm/pxa2xx_gpio.c                   |   6 +-
 hw/arm/pxa2xx_pic.c                    |   4 +-
 hw/arm/stellaris.c                     |   3 +-
 hw/arm/tosa.c                          |  25 +++++----
 hw/arm/versatilepb.c                   |   2 +-
 hw/arm/vexpress.c                      |   8 +--
 hw/arm/z2.c                            |   6 +-
 hw/audio/hda-codec.c                   |  10 ++--
 hw/audio/intel-hda.c                   |  28 +++++-----
 hw/audio/wm8750.c                      |   4 +-
 hw/block/dataplane/virtio-blk.c        |   6 +-
 hw/block/nand.c                        |   4 +-
 hw/block/onenand.c                     |  16 +++---
 hw/block/tc58128.c                     |  44 +++++++--------
 hw/bt/core.c                           |  15 ++---
 hw/bt/hci-csr.c                        |  17 +++---
 hw/bt/hci.c                            |  48 ++++++++--------
 hw/bt/hid.c                            |   4 +-
 hw/bt/l2cap.c                          |  49 ++++++++--------
 hw/bt/sdp.c                            |  11 ++--
 hw/char/exynos4210_uart.c              |   6 +-
 hw/char/mcf_uart.c                     |   5 +-
 hw/char/sh_serial.c                    |   9 +--
 hw/core/loader.c                       |  31 ++++++-----
 hw/core/ptimer.c                       |   7 ++-
 hw/cris/axis_dev88.c                   |   3 +-
 hw/cris/boot.c                         |   5 +-
 hw/display/blizzard.c                  |  28 +++++-----
 hw/display/omap_dss.c                  |  16 +++---
 hw/display/pl110.c                     |   2 +-
 hw/display/pxa2xx_lcd.c                |  14 ++---
 hw/display/qxl-render.c                |   9 ++-
 hw/display/qxl.c                       |  10 ++--
 hw/display/qxl.h                       |   2 +-
 hw/display/tc6393xb.c                  |  38 +++++++------
 hw/display/virtio-gpu-3d.c             |   4 +-
 hw/display/vmware_vga.c                |  22 ++++----
 hw/display/xenfb.c                     |   2 +-
 hw/dma/omap_dma.c                      |  38 +++++++------
 hw/dma/pxa2xx_dma.c                    |  14 ++---
 hw/dma/soc_dma.c                       |  37 ++++++------
 hw/gpio/max7310.c                      |   8 +--
 hw/gpio/omap_gpio.c                    |   2 +-
 hw/i2c/omap_i2c.c                      |  10 ++--
 hw/i386/kvm/apic.c                     |   9 +--
 hw/i386/kvm/clock.c                    |   7 ++-
 hw/i386/kvm/i8254.c                    |   7 ++-
 hw/i386/kvm/i8259.c                    |   5 +-
 hw/i386/kvm/ioapic.c                   |   5 +-
 hw/i386/multiboot.c                    |  21 +++----
 hw/i386/pc.c                           |  18 +++---
 hw/i386/pc_piix.c                      |   2 +-
 hw/i386/pc_sysfw.c                     |   5 +-
 hw/i386/xen/xen-hvm.c                  |  32 ++++++-----
 hw/i386/xen/xen-mapcache.c             |  12 ++--
 hw/i386/xen/xen_apic.c                 |   2 +-
 hw/ide/ahci.c                          |   6 +-
 hw/ide/core.c                          |   2 +-
 hw/ide/microdrive.c                    |   4 +-
 hw/input/lm832x.c                      |   8 +--
 hw/input/pckbd.c                       |   3 +-
 hw/input/pxa2xx_keypad.c               |   6 +-
 hw/input/tsc2005.c                     |  17 +++---
 hw/input/tsc210x.c                     |  76 ++++++++++++-------------
 hw/input/virtio-input-hid.c            |  14 ++---
 hw/input/virtio-input.c                |   5 +-
 hw/intc/arm_gic_kvm.c                  |  12 ++--
 hw/intc/omap_intc.c                    |   4 +-
 hw/intc/openpic.c                      |   7 ++-
 hw/intc/openpic_kvm.c                  |   8 +--
 hw/intc/s390_flic_kvm.c                |   4 +-
 hw/ipmi/ipmi.c                         |   1 +
 hw/ipmi/ipmi_bmc_extern.c              |   5 +-
 hw/isa/isa-bus.c                       |   7 ++-
 hw/isa/vt82c686.c                      |   2 +-
 hw/lm32/lm32_boards.c                  |   5 +-
 hw/lm32/milkymist.c                    |   5 +-
 hw/m68k/an5206.c                       |   4 +-
 hw/m68k/mcf5206.c                      |   3 +-
 hw/m68k/mcf5208.c                      |   7 ++-
 hw/microblaze/boot.c                   |   2 +-
 hw/mips/boston.c                       |   4 +-
 hw/mips/gt64xxx_pci.c                  |   2 +-
 hw/mips/mips_fulong2e.c                |   4 +-
 hw/mips/mips_jazz.c                    |   4 +-
 hw/mips/mips_malta.c                   |   4 +-
 hw/mips/mips_mipssim.c                 |   4 +-
 hw/mips/mips_r4k.c                     |   6 +-
 hw/misc/a9scu.c                        |   3 +-
 hw/misc/cbus.c                         |  12 ++--
 hw/misc/omap_clk.c                     |   4 +-
 hw/misc/omap_gpmc.c                    |  13 +++--
 hw/misc/omap_l4.c                      |   5 +-
 hw/misc/omap_sdrc.c                    |   5 +-
 hw/misc/omap_tap.c                     |   6 +-
 hw/misc/tmp105.c                       |   2 +-
 hw/misc/vmport.c                       |   2 +-
 hw/moxie/moxiesim.c                    |   7 ++-
 hw/net/fsl_etsec/etsec.c               |   2 +-
 hw/net/pcnet.c                         |   2 +-
 hw/net/smc91c111.c                     |   5 +-
 hw/net/vhost_net.c                     |  16 +++---
 hw/nios2/boot.c                        |   2 +-
 hw/nvram/eeprom93xx.c                  |   5 +-
 hw/nvram/fw_cfg.c                      |   4 +-
 hw/openrisc/openrisc_sim.c             |   3 +-
 hw/pci-host/bonito.c                   |   8 +--
 hw/pci/pci.c                           |  10 ++--
 hw/ppc/e500.c                          |  20 +++----
 hw/ppc/mac_newworld.c                  |   2 +-
 hw/ppc/mac_oldworld.c                  |   2 +-
 hw/ppc/mpc8544_guts.c                  |   5 +-
 hw/ppc/ppc405_boards.c                 |   8 +--
 hw/ppc/ppc440_bamboo.c                 |  19 ++++---
 hw/ppc/ppc4xx_pci.c                    |   3 +-
 hw/ppc/prep.c                          |   4 +-
 hw/ppc/virtex_ml507.c                  |   4 +-
 hw/s390x/virtio-ccw.c                  |   2 +-
 hw/scsi/lsi53c895a.c                   |   4 +-
 hw/scsi/spapr_vscsi.c                  |  49 ++++++++--------
 hw/scsi/virtio-scsi-dataplane.c        |   6 +-
 hw/sd/pl181.c                          |   5 +-
 hw/sd/pxa2xx_mmci.c                    |   6 +-
 hw/sd/sd.c                             |  14 ++---
 hw/sh4/r2d.c                           |   9 +--
 hw/sh4/sh7750.c                        |  64 ++++++++++-----------
 hw/sparc/leon3.c                       |   9 +--
 hw/sparc/sun4m.c                       |   8 +--
 hw/sparc64/niagara.c                   |   2 +-
 hw/sparc64/sun4u.c                     |   9 +--
 hw/ssi/omap_spi.c                      |   9 +--
 hw/timer/omap_gptimer.c                |  13 +++--
 hw/timer/twl92230.c                    |   8 +--
 hw/timer/xilinx_timer.c                |   8 +--
 hw/usb/core.c                          |  15 ++---
 hw/usb/desc.c                          |   4 +-
 hw/usb/dev-audio.c                     |  29 +++++-----
 hw/usb/dev-bluetooth.c                 |   4 +-
 hw/usb/dev-mtp.c                       |   9 +--
 hw/usb/dev-network.c                   |  20 +++----
 hw/usb/hcd-ehci.c                      |  32 +++++------
 hw/usb/hcd-musb.c                      |   4 +-
 hw/usb/hcd-xhci.c                      |   3 +-
 hw/usb/host-legacy.c                   |   2 +-
 hw/usb/tusb6010.c                      |  14 ++---
 hw/watchdog/watchdog.c                 |   9 +--
 hw/watchdog/wdt_i6300esb.c             |   8 ++-
 hw/xen/xen-common.c                    |  10 ++--
 hw/xen/xen_pt.c                        |   4 +-
 hw/xenpv/xen_domainbuild.c             |  32 +++++------
 hw/xenpv/xen_machine_pv.c              |   8 +--
 include/hw/arm/omap.h                  |  10 ++--
 include/hw/arm/sharpsl.h               |   2 +-
 memory_mapping.c                       |   2 +-
 migration/block.c                      |   4 +-
 target/arm/arm-powerctl.c              |   5 +-
 target/arm/arm-semi.c                  |   3 +-
 target/arm/helper.c                    |   4 +-
 target/arm/kvm.c                       |  16 +++---
 target/arm/kvm32.c                     |   2 +-
 target/arm/kvm64.c                     |   2 +-
 target/arm/translate-a64.c             |   4 +-
 target/arm/translate.c                 |   2 +-
 target/cris/helper.c                   |   2 +-
 target/cris/translate.c                |   2 +-
 target/i386/hax-all.c                  |  52 ++++++++---------
 target/i386/hax-darwin.c               |  26 ++++-----
 target/i386/hax-mem.c                  |   4 +-
 target/i386/hax-windows.c              |  42 +++++++-------
 target/i386/kvm.c                      |  38 ++++++-------
 target/i386/misc_helper.c              |  12 ++--
 target/lm32/op_helper.c                |   4 +-
 target/mips/mips-semi.c                |   3 +-
 target/mips/translate.c                |   2 +-
 target/ppc/excp_helper.c               |   4 +-
 target/ppc/kvm.c                       |  36 ++++++------
 target/ppc/mmu-hash64.c                |   2 +-
 target/ppc/mmu_helper.c                |   2 +-
 target/ppc/translate.c                 |  20 +++----
 target/ppc/translate_init.c            |  53 +++++++++---------
 target/s390x/kvm.c                     |  20 +++----
 target/s390x/misc_helper.c             |   2 +-
 target/sh4/translate.c                 |   4 +-
 target/unicore32/translate.c           |   4 +-
 tcg/optimize.c                         |   8 +--
 tcg/tcg.c                              |   2 +-
 tcg/tcg.h                              |   3 +-
 tcg/tci.c                              |   2 +-
 tcg/tci/tcg-target.inc.c               |   4 +-
 tests/Makefile.include                 |   4 +-
 tests/ahci-test.c                      |   3 +-
 tests/atomic_add-bench.c               |   2 +-
 tests/bios-tables-test.c               |   5 +-
 tests/check-qlit                       | Bin 0 -> 272776 bytes
 tests/i440fx-test.c                    |   8 +--
 tests/libqos/ahci.c                    |  10 ++--
 tests/libqos/libqos.c                  |   7 ++-
 tests/libqos/malloc.c                  |  13 +++--
 tests/libqtest.c                       |  13 +++--
 tests/migration/stress.c               |  36 ++++++------
 tests/postcopy-test.c                  |   8 +--
 tests/qemu-iotests/socket_scm_helper.c |  11 ++--
 tests/qht-bench.c                      |   5 +-
 tests/rcutorture.c                     |   5 +-
 tests/tcg/linux-test.c                 |   2 +-
 tests/tcg/runcom.c                     |   6 +-
 tests/tcg/test-i386-fprem.c            |   2 +-
 tests/tcg/test_path.c                  |   4 +-
 tests/test-hmp.c                       |   5 +-
 tests/test-rcu-list.c                  |   5 +-
 tests/usb-hcd-ehci-test.c              |   2 +-
 tests/vhost-user-bridge.c              |  28 +++++-----
 ui/cocoa.m                             |   6 +-
 ui/console.c                           |   2 +-
 ui/curses.c                            |   2 +-
 ui/cursor.c                            |  12 ++--
 ui/gtk.c                               |  10 ++--
 ui/input-linux.c                       |   3 +-
 ui/keymaps.c                           |   4 +-
 ui/sdl.c                               |  14 ++---
 ui/sdl2.c                              |   8 +--
 ui/sdl_zoom.c                          |   3 +-
 ui/shader.c                            |   8 +--
 ui/spice-display.c                     |  10 ++--
 ui/vnc-enc-tight.c                     |   4 +-
 ui/vnc-enc-zlib.c                      |   4 +-
 ui/vnc-enc-zrle.c                      |   4 +-
 ui/vnc.c                               |   2 +-
 util/aio-posix.c                       |   5 +-
 util/coroutine-sigaltstack.c           |   2 +-
 util/error.c                           |   2 +-
 util/main-loop.c                       |   2 +-
 util/mmap-alloc.c                      |   3 +-
 util/module.c                          |   6 +-
 util/osdep.c                           |   4 +-
 util/oslib-posix.c                     |   3 +-
 util/oslib-win32.c                     |   3 +-
 util/qemu-coroutine.c                  |   5 +-
 util/qemu-progress.c                   |   3 +-
 util/qemu-thread-posix.c               |   5 +-
 util/qemu-thread-win32.c               |   5 +-
 util/qemu-timer-common.c               |   3 +-
 util/qht.c                             |   2 +-
 vl.c                                   |   2 +-
 270 files changed, 1477 insertions(+), 1368 deletions(-)
 create mode 100755 tests/check-qlit

--=20
2.11.0
