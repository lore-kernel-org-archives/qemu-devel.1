Received: from eggs.gnu.org ([2001:4830:134:3::10]:33892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZKp-0007OB-N2
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZKm-0002nP-Ev
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:00:39 -0500
Received: from mail-by2nam01on0076.outbound.protection.outlook.com
	([104.47.34.76]:33408
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCZKl-0002n4-Qo
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:00:36 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:56:23 -0800
Message-ID: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 00/45]  Remove some of the fprintf(stderr, "*
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

V4:
 - Reorder patch 3 (the audio func patch)
 - Add all tags
 - Small fixes
V3:
 - Rebase
 - All sorts of style fixes
 - Remove "qemu: " prefixes from print messages
V2:
 - Fix build issues
 - Drop block patches
 - Split the hw patches into subdirectories
 - Remove AUDIO_FUNC macro as well
 - Add some __FUNCTION__ rename fixes in a seperate patch
 - Create a qemu_log() conversion patch for target/

Alistair Francis (45):
  audio: Replace AUDIO_FUNC with __func__
  Replace all occurances of __FUNCTION__ with __func__
  Fixes after renaming __FUNCTION__ to __func__
  tests: Replace fprintf(stderr, "*\n" with error_report()
  hw/arm: Replace fprintf(stderr, "*\n" with error_report()
  hw/block: Replace fprintf(stderr, "*\n" with error_report()
  hw/bt: Replace fprintf(stderr, "*\n" with error_report()
  hw/char: Replace fprintf(stderr, "*\n" with error_report()
  hw/core: Replace fprintf(stderr, "*\n" with error_report()
  hw/cris: Replace fprintf(stderr, "*\n" with error_report()
  hw/display: Replace fprintf(stderr, "*\n" with error_report()
  hw/dma: Replace fprintf(stderr, "*\n" with error_report()
  hw/gpio: Replace fprintf(stderr, "*\n" with error_report()
  hw/i2c: Replace fprintf(stderr, "*\n" with error_report()
  hw/i386: Replace fprintf(stderr, "*\n" with error_report()
  hw/ide: Replace fprintf(stderr, "*\n" with error_report()
  hw/input: Replace fprintf(stderr, "*\n" with error_report()
  hw/intc: Replace fprintf(stderr, "*\n" with error_report()
  hw/ipmi: Replace fprintf(stderr, "*\n" with error_report()
  hw/isa: Replace fprintf(stderr, "*\n" with error_report()
  hw/lm32: Replace fprintf(stderr, "*\n" with error_report()
  hw/microblaze: Replace fprintf(stderr, "*\n" with error_report()
  hw/mips: Replace fprintf(stderr, "*\n" with error_report()
  hw/misc: Replace fprintf(stderr, "*\n" with error_report()
  hw/moxie: Replace fprintf(stderr, "*\n" with error_report()
  hw/net: Replace fprintf(stderr, "*\n" with error_report()
  hw/nios2: Replace fprintf(stderr, "*\n" with error_report()
  hw/nvram: Replace fprintf(stderr, "*\n" with error_report()
  hw/openrisc: Replace fprintf(stderr, "*\n" with error_report()
  hw/pci*: Replace fprintf(stderr, "*\n" with error_report()
  hw/ppc: Replace fprintf(stderr, "*\n" with error_report()
  hw/s390x: Replace fprintf(stderr, "*\n" with error_report()
  hw/scsi: Replace fprintf(stderr, "*\n" with error_report()
  hw/sd: Replace fprintf(stderr, "*\n" with error_report()
  hw/sh4: Replace fprintf(stderr, "*\n" with error_report()
  hw/sparc*: Replace fprintf(stderr, "*\n" with error_report()
  hw/ssi: Replace fprintf(stderr, "*\n" with error_report()
  hw/timer: Replace fprintf(stderr, "*\n" with error_report()
  hw/usb: Replace fprintf(stderr, "*\n" with error_report()
  hw/watchdog: Replace fprintf(stderr, "*\n" with error_report()
  hw/xen*: Replace fprintf(stderr, "*\n" with error_report()
  util: Replace fprintf(stderr, "*\n" with error_report()
  ui: Replace fprintf(stderr, "*\n" with error_report()
  tcg: Replace fprintf(stderr, "*\n" with error_report()
  target: Use qemu_log() instead of fprintf(stderr, ...)

 audio/alsaaudio.c                      |  4 +-
 audio/audio.c                          | 40 +++++++++---------
 audio/audio_int.h                      |  6 ---
 audio/audio_pt_int.c                   | 28 ++++++-------
 audio/audio_template.h                 | 26 ++++++------
 audio/dsoundaudio.c                    |  2 +-
 audio/mixeng.c                         |  2 +-
 audio/ossaudio.c                       | 10 ++---
 audio/paaudio.c                        | 56 ++++++++++++-------------
 audio/sdlaudio.c                       |  2 +-
 audio/wavaudio.c                       |  2 +-
 cpus.c                                 |  8 ++--
 exec.c                                 | 14 +++----
 hw/arm/armv7m.c                        |  2 +-
 hw/arm/boot.c                          | 37 ++++++++---------
 hw/arm/gumstix.c                       | 13 +++---
 hw/arm/mainstone.c                     |  7 ++--
 hw/arm/musicpal.c                      |  2 +-
 hw/arm/nseries.c                       |  2 +-
 hw/arm/omap1.c                         | 49 +++++++++++-----------
 hw/arm/omap2.c                         | 23 +++++-----
 hw/arm/omap_sx1.c                      |  6 +--
 hw/arm/palm.c                          | 20 ++++-----
 hw/arm/pxa2xx.c                        | 53 ++++++++++++------------
 hw/arm/pxa2xx_gpio.c                   |  6 +--
 hw/arm/pxa2xx_pic.c                    |  4 +-
 hw/arm/stellaris.c                     |  3 +-
 hw/arm/tosa.c                          | 25 +++++------
 hw/arm/versatilepb.c                   |  2 +-
 hw/arm/vexpress.c                      |  8 ++--
 hw/arm/z2.c                            |  6 +--
 hw/audio/hda-codec.c                   | 10 ++---
 hw/audio/intel-hda.c                   | 28 ++++++-------
 hw/audio/wm8750.c                      |  4 +-
 hw/block/dataplane/virtio-blk.c        |  6 +--
 hw/block/nand.c                        |  4 +-
 hw/block/onenand.c                     | 16 +++----
 hw/block/tc58128.c                     | 44 +++++++++-----------
 hw/bt/core.c                           | 15 ++++---
 hw/bt/hci-csr.c                        | 21 +++++-----
 hw/bt/hci.c                            | 46 ++++++++++----------
 hw/bt/hid.c                            |  4 +-
 hw/bt/l2cap.c                          | 49 +++++++++++-----------
 hw/bt/sdp.c                            | 11 ++---
 hw/char/mcf_uart.c                     |  5 ++-
 hw/char/sh_serial.c                    | 11 +++--
 hw/core/loader.c                       | 43 +++++++++----------
 hw/core/ptimer.c                       |  7 ++--
 hw/cris/axis_dev88.c                   |  3 +-
 hw/cris/boot.c                         |  6 +--
 hw/display/blizzard.c                  | 28 ++++++-------
 hw/display/omap_dss.c                  | 16 +++----
 hw/display/pl110.c                     |  2 +-
 hw/display/pxa2xx_lcd.c                | 14 +++----
 hw/display/qxl-render.c                |  9 ++--
 hw/display/qxl.c                       | 10 ++---
 hw/display/qxl.h                       |  2 +-
 hw/display/tc6393xb.c                  | 38 +++++++++--------
 hw/display/virtio-gpu-3d.c             |  4 +-
 hw/display/vmware_vga.c                | 22 +++++-----
 hw/display/xenfb.c                     |  2 +-
 hw/dma/omap_dma.c                      | 38 +++++++++--------
 hw/dma/pxa2xx_dma.c                    | 14 +++----
 hw/dma/soc_dma.c                       | 36 ++++++++--------
 hw/gpio/max7310.c                      |  8 ++--
 hw/gpio/omap_gpio.c                    |  2 +-
 hw/i2c/omap_i2c.c                      | 10 ++---
 hw/i386/kvm/apic.c                     |  9 ++--
 hw/i386/kvm/clock.c                    |  7 ++--
 hw/i386/kvm/i8254.c                    |  7 ++--
 hw/i386/kvm/i8259.c                    |  5 ++-
 hw/i386/kvm/ioapic.c                   |  5 ++-
 hw/i386/multiboot.c                    | 21 +++++-----
 hw/i386/pc.c                           | 24 +++++------
 hw/i386/pc_piix.c                      |  2 +-
 hw/i386/pc_sysfw.c                     |  4 +-
 hw/i386/xen/xen-hvm.c                  | 30 +++++++-------
 hw/i386/xen/xen-mapcache.c             | 12 +++---
 hw/i386/xen/xen_apic.c                 |  3 +-
 hw/ide/ahci.c                          |  6 +--
 hw/ide/core.c                          |  3 +-
 hw/ide/microdrive.c                    |  4 +-
 hw/input/lm832x.c                      |  8 ++--
 hw/input/pckbd.c                       |  3 +-
 hw/input/pxa2xx_keypad.c               |  6 +--
 hw/input/tsc2005.c                     | 17 ++++----
 hw/input/tsc210x.c                     | 76 +++++++++++++++++-------------=
----
 hw/input/virtio-input-hid.c            | 14 +++----
 hw/input/virtio-input.c                |  5 ++-
 hw/intc/arm_gic_kvm.c                  | 12 +++---
 hw/intc/omap_intc.c                    |  4 +-
 hw/intc/openpic.c                      |  7 ++--
 hw/intc/openpic_kvm.c                  |  8 ++--
 hw/intc/s390_flic_kvm.c                |  4 +-
 hw/ipmi/ipmi_bmc_extern.c              |  5 ++-
 hw/isa/isa-bus.c                       |  7 ++--
 hw/isa/vt82c686.c                      |  2 +-
 hw/lm32/lm32_boards.c                  |  7 ++--
 hw/lm32/milkymist.c                    |  7 ++--
 hw/microblaze/boot.c                   |  2 +-
 hw/mips/boston.c                       |  4 +-
 hw/mips/gt64xxx_pci.c                  |  2 +-
 hw/mips/mips_fulong2e.c                | 13 +++---
 hw/mips/mips_jazz.c                    |  4 +-
 hw/mips/mips_malta.c                   | 16 ++++---
 hw/mips/mips_mipssim.c                 | 11 +++--
 hw/mips/mips_r4k.c                     | 18 ++++----
 hw/misc/a9scu.c                        |  3 +-
 hw/misc/cbus.c                         | 12 +++---
 hw/misc/omap_clk.c                     |  4 +-
 hw/misc/omap_gpmc.c                    | 13 +++---
 hw/misc/omap_l4.c                      |  5 ++-
 hw/misc/omap_sdrc.c                    |  5 ++-
 hw/misc/omap_tap.c                     |  6 +--
 hw/misc/tmp105.c                       |  2 +-
 hw/misc/vmport.c                       |  2 +-
 hw/moxie/moxiesim.c                    | 14 +++----
 hw/net/fsl_etsec/etsec.c               |  2 +-
 hw/net/pcnet.c                         |  2 +-
 hw/net/smc91c111.c                     |  5 ++-
 hw/net/vhost_net.c                     | 16 +++----
 hw/nios2/boot.c                        |  2 +-
 hw/nvram/eeprom93xx.c                  |  5 ++-
 hw/nvram/fw_cfg.c                      |  5 ++-
 hw/openrisc/openrisc_sim.c             |  4 +-
 hw/pci-host/bonito.c                   |  8 ++--
 hw/pci/pci.c                           | 12 +++---
 hw/ppc/e500.c                          | 22 +++++-----
 hw/ppc/mac_newworld.c                  |  2 +-
 hw/ppc/mac_oldworld.c                  |  2 +-
 hw/ppc/mpc8544_guts.c                  |  5 ++-
 hw/ppc/ppc405_boards.c                 | 15 +++----
 hw/ppc/ppc440_bamboo.c                 | 22 +++++-----
 hw/ppc/ppc4xx_pci.c                    |  3 +-
 hw/ppc/prep.c                          |  4 +-
 hw/ppc/virtex_ml507.c                  |  4 +-
 hw/s390x/virtio-ccw.c                  |  5 ++-
 hw/scsi/lsi53c895a.c                   |  4 +-
 hw/scsi/spapr_vscsi.c                  | 49 +++++++++++-----------
 hw/scsi/virtio-scsi-dataplane.c        |  6 +--
 hw/sd/pl181.c                          |  5 ++-
 hw/sd/pxa2xx_mmci.c                    |  6 +--
 hw/sd/sd.c                             | 15 +++----
 hw/sh4/r2d.c                           |  9 ++--
 hw/sh4/sh7750.c                        | 64 ++++++++++++++--------------
 hw/sparc/leon3.c                       | 16 ++++---
 hw/sparc/sun4m.c                       | 16 ++++---
 hw/sparc64/niagara.c                   |  4 +-
 hw/sparc64/sun4u.c                     | 10 ++---
 hw/ssi/omap_spi.c                      |  9 ++--
 hw/timer/omap_gptimer.c                | 13 +++---
 hw/timer/twl92230.c                    |  8 ++--
 hw/timer/xilinx_timer.c                |  8 ++--
 hw/usb/core.c                          | 15 +++----
 hw/usb/desc.c                          |  6 +--
 hw/usb/dev-audio.c                     | 39 ++++++++---------
 hw/usb/dev-bluetooth.c                 |  4 +-
 hw/usb/dev-mtp.c                       |  9 ++--
 hw/usb/dev-network.c                   | 14 +++----
 hw/usb/hcd-ehci.c                      | 32 +++++++-------
 hw/usb/hcd-musb.c                      |  4 +-
 hw/usb/hcd-xhci.c                      |  3 +-
 hw/usb/host-legacy.c                   |  3 +-
 hw/usb/tusb6010.c                      | 14 +++----
 hw/watchdog/watchdog.c                 | 11 +++--
 hw/watchdog/wdt_i6300esb.c             | 10 +++--
 hw/xen/xen-common.c                    | 11 ++---
 hw/xenpv/xen_domainbuild.c             | 32 +++++++-------
 hw/xenpv/xen_machine_pv.c              |  9 ++--
 include/hw/arm/omap.h                  | 10 ++---
 include/hw/arm/sharpsl.h               |  2 +-
 memory_mapping.c                       |  2 +-
 migration/block.c                      |  4 +-
 target/cris/translate.c                |  2 +-
 target/ppc/translate.c                 | 22 +++++-----
 target/sh4/translate.c                 |  4 +-
 target/unicore32/translate.c           |  2 +-
 tcg/optimize.c                         |  8 ++--
 tcg/tcg.c                              |  2 +-
 tcg/tcg.h                              |  3 +-
 tcg/tci.c                              |  2 +-
 tcg/tci/tcg-target.inc.c               |  4 +-
 tests/Makefile.include                 |  4 +-
 tests/ahci-test.c                      |  3 +-
 tests/bios-tables-test.c               |  5 ++-
 tests/i440fx-test.c                    |  8 ++--
 tests/libqos/ahci.c                    | 10 ++---
 tests/libqos/libqos.c                  |  7 ++--
 tests/libqos/malloc.c                  | 13 +++---
 tests/libqtest.c                       | 13 +++---
 tests/migration-test.c                 |  8 ++--
 tests/migration/stress.c               | 36 ++++++++--------
 tests/qemu-iotests/socket_scm_helper.c | 11 ++---
 tests/rcutorture.c                     |  5 ++-
 tests/tcg/linux-test.c                 |  2 +-
 tests/tcg/runcom.c                     |  6 +--
 tests/tcg/test-i386-fprem.c            |  2 +-
 tests/tcg/test_path.c                  |  4 +-
 tests/test-hmp.c                       |  5 ++-
 tests/test-rcu-list.c                  |  5 ++-
 tests/usb-hcd-ehci-test.c              |  2 +-
 tests/vhost-user-bridge.c              | 28 ++++++-------
 ui/cocoa.m                             |  6 +--
 ui/console.c                           |  2 +-
 ui/curses.c                            |  2 +-
 ui/cursor.c                            | 12 +++---
 ui/gtk.c                               | 10 ++---
 ui/input-linux.c                       |  3 +-
 ui/keymaps.c                           |  4 +-
 ui/sdl.c                               | 14 +++----
 ui/sdl2.c                              |  8 ++--
 ui/sdl_zoom.c                          |  3 +-
 ui/shader.c                            |  9 ++--
 ui/spice-display.c                     | 10 ++---
 ui/vnc-enc-tight.c                     |  4 +-
 ui/vnc-enc-zlib.c                      |  4 +-
 ui/vnc-enc-zrle.c                      |  4 +-
 ui/vnc.c                               |  2 +-
 util/aio-posix.c                       |  1 +
 util/coroutine-sigaltstack.c           |  2 +-
 util/error.c                           |  4 +-
 util/main-loop.c                       |  2 +-
 util/mmap-alloc.c                      |  3 +-
 util/module.c                          |  6 +--
 util/osdep.c                           |  4 +-
 util/oslib-posix.c                     |  3 +-
 util/oslib-win32.c                     |  3 +-
 util/qemu-coroutine.c                  |  5 ++-
 util/qemu-progress.c                   |  3 +-
 util/qemu-thread-posix.c               |  5 ++-
 util/qemu-thread-win32.c               |  5 ++-
 util/qemu-timer-common.c               |  3 +-
 util/qht.c                             |  2 +-
 vl.c                                   |  2 +-
 234 files changed, 1284 insertions(+), 1239 deletions(-)

--=20
2.14.1
