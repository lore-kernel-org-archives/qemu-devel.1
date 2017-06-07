Received: from eggs.gnu.org ([2001:4830:134:3::10]:57288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIVfw-0003wF-Qa
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIVfr-0006Ge-T1
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:46:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIVfr-0006GR-Jx
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:46:39 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 11:46:27 +0400
Message-Id: <20170607074632.13162-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/5] Code cleanups with Coccinelle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

Here is a few patches I came up with playing with some semantic
patches. If necessary, I can split them further by unit/domains, but
that will likely make a quite long series of patches.

Marc-Andr=C3=A9 Lureau (5):
  coccinelle: replace code with ROUND_UP macro
  coccinelle: use DIV_ROUND_UP
  arch: introduce ELF_NOTE_SIZE macro
  Replace g_malloc()+memcpy() with g_memdup()
  coccinelle: prefer glib g_new/g_renew macros

 hw/lm32/lm32_hwsetup.h              |  2 +-
 include/hw/elf_ops.h                |  2 +-
 include/qemu/timer.h                |  2 +-
 audio/alsaaudio.c                   |  2 +-
 audio/coreaudio.c                   |  2 +-
 audio/dsoundaudio.c                 |  2 +-
 audio/ossaudio.c                    |  2 +-
 audio/paaudio.c                     |  2 +-
 audio/wavaudio.c                    |  2 +-
 backends/cryptodev.c                |  2 +-
 block/qed-check.c                   |  3 ++-
 bootdevice.c                        |  2 +-
 bsd-user/syscall.c                  |  2 +-
 bt-host.c                           |  2 +-
 bt-vhci.c                           |  2 +-
 cpus-common.c                       |  4 ++--
 cpus.c                              | 16 ++++++++--------
 disas/ia64.c                        |  4 ++--
 dma-helpers.c                       |  4 ++--
 dump.c                              | 10 +++++-----
 gdbstub.c                           |  4 ++--
 hw/9pfs/9p-handle.c                 |  2 +-
 hw/9pfs/9p-proxy.c                  |  2 +-
 hw/9pfs/9p-synth.c                  |  5 ++---
 hw/9pfs/9p.c                        |  6 +++---
 hw/9pfs/xen-9p-backend.c            |  6 +++---
 hw/acpi/memory_hotplug.c            |  2 +-
 hw/audio/intel-hda.c                |  2 +-
 hw/bt/core.c                        |  4 ++--
 hw/bt/hci.c                         |  4 ++--
 hw/bt/l2cap.c                       |  4 ++--
 hw/bt/sdp.c                         |  6 +++---
 hw/char/parallel.c                  |  2 +-
 hw/char/serial.c                    |  4 ++--
 hw/char/sh_serial.c                 |  2 +-
 hw/char/virtio-serial-bus.c         | 19 +++++++++----------
 hw/core/irq.c                       |  2 +-
 hw/core/ptimer.c                    |  2 +-
 hw/core/reset.c                     |  2 +-
 hw/cris/axis_dev88.c                |  2 +-
 hw/display/pxa2xx_lcd.c             |  2 +-
 hw/display/tc6393xb.c               |  2 +-
 hw/display/vga.c                    |  2 +-
 hw/display/virtio-gpu.c             |  8 ++++----
 hw/display/xenfb.c                  |  4 ++--
 hw/dma/etraxfs_dma.c                |  2 +-
 hw/dma/rc4030.c                     |  4 ++--
 hw/dma/soc_dma.c                    |  6 ++----
 hw/i2c/bitbang_i2c.c                |  2 +-
 hw/i2c/core.c                       |  4 ++--
 hw/i386/amd_iommu.c                 |  4 ++--
 hw/i386/intel_iommu.c               |  2 +-
 hw/i386/kvm/pci-assign.c            |  2 +-
 hw/i386/multiboot.c                 |  3 +--
 hw/i386/pc.c                        |  5 ++---
 hw/i386/xen/xen-hvm.c               | 12 ++++++------
 hw/i386/xen/xen-mapcache.c          | 14 +++++++-------
 hw/input/pckbd.c                    |  2 +-
 hw/input/ps2.c                      |  4 ++--
 hw/input/pxa2xx_keypad.c            |  2 +-
 hw/input/tsc2005.c                  |  3 +--
 hw/input/virtio-input.c             |  4 ++--
 hw/intc/exynos4210_gic.c            |  2 +-
 hw/intc/heathrow_pic.c              |  2 +-
 hw/intc/xics.c                      |  2 +-
 hw/intc/xics_kvm.c                  |  2 +-
 hw/lm32/lm32_boards.c               |  4 ++--
 hw/lm32/milkymist.c                 |  2 +-
 hw/m68k/mcf5206.c                   |  4 ++--
 hw/m68k/mcf5208.c                   |  2 +-
 hw/mips/mips_malta.c                |  2 +-
 hw/mips/mips_mipssim.c              |  2 +-
 hw/mips/mips_r4k.c                  |  2 +-
 hw/misc/applesmc.c                  |  2 +-
 hw/misc/imx6_src.c                  |  2 +-
 hw/misc/ivshmem.c                   |  4 ++--
 hw/misc/macio/mac_dbdma.c           |  2 +-
 hw/misc/pci-testdev.c               |  2 +-
 hw/net/eepro100.c                   |  3 +--
 hw/net/net_rx_pkt.c                 |  2 +-
 hw/net/virtio-net.c                 |  2 +-
 hw/pci/msix.c                       |  6 +++---
 hw/pci/pci.c                        |  2 +-
 hw/pci/pcie_aer.c                   |  4 ++--
 hw/ppc/e500.c                       |  4 ++--
 hw/ppc/mac_newworld.c               |  2 +-
 hw/ppc/mac_oldworld.c               |  2 +-
 hw/ppc/ppc.c                        |  8 ++++----
 hw/ppc/ppc405_boards.c              |  8 ++++----
 hw/ppc/ppc405_uc.c                  | 28 ++++++++++++++--------------
 hw/ppc/ppc440_bamboo.c              |  4 ++--
 hw/ppc/ppc4xx_devs.c                |  4 ++--
 hw/ppc/ppc_booke.c                  |  4 ++--
 hw/ppc/prep.c                       |  2 +-
 hw/ppc/spapr.c                      |  4 ++--
 hw/ppc/spapr_events.c               |  2 +-
 hw/ppc/spapr_iommu.c                |  2 +-
 hw/ppc/spapr_pci.c                  |  2 +-
 hw/ppc/spapr_vio.c                  |  2 +-
 hw/ppc/virtex_ml507.c               |  2 +-
 hw/s390x/css.c                      |  8 ++++----
 hw/s390x/s390-pci-bus.c             |  4 ++--
 hw/sh4/r2d.c                        |  4 ++--
 hw/sh4/sh7750.c                     |  2 +-
 hw/sparc/leon3.c                    |  2 +-
 hw/sparc64/sparc64.c                |  4 ++--
 hw/timer/arm_timer.c                |  2 +-
 hw/timer/grlib_gptimer.c            |  2 +-
 hw/timer/sh_timer.c                 |  4 ++--
 hw/timer/slavio_timer.c             |  2 +-
 hw/timer/xilinx_timer.c             |  2 +-
 hw/usb/dev-hub.c                    |  8 ++++----
 hw/vfio/common.c                    |  2 +-
 hw/vfio/pci.c                       |  4 ++--
 hw/vfio/platform.c                  |  4 ++--
 hw/virtio/virtio-crypto.c           |  2 +-
 hw/virtio/virtio-pci.c              |  4 ++--
 hw/virtio/virtio.c                  |  4 ++--
 hw/xtensa/xtfpga.c                  |  2 +-
 kvm-all.c                           |  4 ++--
 libdecnumber/decNumber.c            |  2 +-
 linux-user/elfload.c                |  2 +-
 memory.c                            | 12 ++++++------
 memory_mapping.c                    |  2 +-
 migration/block.c                   |  2 +-
 migration/postcopy-ram.c            |  2 +-
 migration/ram.c                     |  2 +-
 monitor.c                           |  2 +-
 nbd/server.c                        |  4 ++--
 net/slirp.c                         |  2 +-
 qga/commands-win32.c                |  2 +-
 qga/commands.c                      |  2 +-
 qmp.c                               |  2 +-
 qobject/json-parser.c               |  2 +-
 replay/replay-char.c                |  8 ++++----
 replay/replay-events.c              | 10 +++++-----
 replay/replay-net.c                 |  5 ++---
 slirp/dnssearch.c                   |  4 ++--
 slirp/slirp.c                       |  2 +-
 target/i386/arch_dump.c             | 32 ++++++++++++++++---------------=
-
 target/i386/cpu.c                   |  2 +-
 target/mips/translate_init.c        |  4 ++--
 target/openrisc/mmu.c               |  2 +-
 target/ppc/kvm.c                    |  4 ++--
 target/ppc/mem_helper.c             |  2 +-
 target/ppc/translate.c              |  2 +-
 target/ppc/translate_init.c         |  6 +++---
 target/s390x/misc_helper.c          |  2 +-
 target/s390x/mmu_helper.c           |  2 +-
 tcg/tcg.c                           |  4 ++--
 tests/ahci-test.c                   |  2 +-
 tests/fw_cfg-test.c                 |  4 ++--
 tests/libqos/ahci.c                 |  2 +-
 tests/libqos/libqos.c               |  2 +-
 tests/libqos/malloc.c               |  6 +++---
 tests/pc-cpu-test.c                 |  2 +-
 tests/qht-bench.c                   |  4 ++--
 tests/test-hbitmap.c                |  2 +-
 tests/test-iov.c                    |  5 ++---
 tests/test-qmp-commands.c           | 14 +++++++-------
 tests/test-qobject-output-visitor.c |  2 +-
 ui/console.c                        |  2 +-
 ui/cursor.c                         |  2 +-
 ui/input-legacy.c                   |  2 +-
 ui/vnc-enc-tight.c                  |  4 ++--
 ui/vnc.c                            |  5 +++--
 util/acl.c                          |  2 +-
 util/envlist.c                      |  2 +-
 util/hbitmap.c                      |  2 +-
 util/iohandler.c                    |  2 +-
 util/main-loop.c                    |  2 +-
 util/qemu-timer.c                   |  2 +-
 vl.c                                |  2 +-
 173 files changed, 324 insertions(+), 332 deletions(-)

--=20
2.13.0.91.g00982b8dd
