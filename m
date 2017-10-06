Received: from eggs.gnu.org ([2001:4830:134:3::10]:40356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cO6-0006ir-Jo
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cO1-0004cs-L1
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:50:38 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:48:55 -0300
Message-Id: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/88] use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Hi,

This is a follow-up of Marc-André's clang-tidy series [1].
While chatting we realized we were trying to reach the same goal, Marc-André
using clang-tidy and me using spatch; so he let me finish his series applying
my changes over his.
I also included Jan's patch which fits well.

Summary:
- 1 bugfix (memory leak)
- few optimizations (avoid to zeroise when all memory is assigned)
- bunch of mechanical refactors

Regards,

Phil.

[1]: http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg00881.html

Jan Beulich (1):
  hw/block/xen_disk: avoid use of g_new0()

Marc-André Lureau (57):
  ARM: use g_new() family of functions
  Audio: use g_new() family of functions
  BT: use g_new() family of functions
  Bootdevice: use g_new() family of functions
  Character devices: use g_new() family of functions
  Cryptodev Backends: use g_new() family of functions
  Dirty Bitmaps: use g_new() family of functions
  ui/vnc: use g_new() family of functions
  Main loop: use g_new() family of functions
  Memory API: use g_new() family of functions
  memory: use g_new() family of functions
  Migration: use g_new() family of functions
  NBD: use g_new() family of functions
  LM32: use g_new() family of functions
  M68K: use g_new() family of functions
  MIPS: use g_new() family of functions
  OpenRISC: use g_new() family of functions
  S390: use g_new() family of functions
  SH4: use g_new() family of functions
  disas: use g_new() family of functions
  SPARC: use g_new() family of functions
  QEMU Guest Agent: use g_new() family of functions
  QMP: use g_new() family of functions
  QObject: use g_new() family of functions
  Record/replay: use g_new() family of functions
  SLIRP: use g_new() family of functions
  TCG: use g_new() family of functions
  VFIO: use g_new() family of functions
  hw/i386: use g_new() family of functions
  hw/xen: use g_new() family of functions
  XTFPGA: use g_new() family of functions
  hw/core: use g_new() family of functions
  hw/display: use g_new() family of functions
  hw/i2c: use g_new() family of functions
  hw/input: use g_new() family of functions
  hw/misc: use g_new() family of functions
  ivshmem: use g_new() family of functions
  hw/timer: use g_new() family of functions
  i.MX31: use g_new() family of functions
  iSCSI: use g_new() family of functions
  KVM: use g_new() family of functions
  PReP: use g_new() family of functions
  PowerPC: use g_new() family of functions
  ppc: use g_new() family of functions
  ppc4xx: use g_new() family of functions
  ppce500: use g_new() family of functions
  sPAPR: use g_new() family of functions
  tests: use g_new() family of functions
  user: use g_new() family of functions
  user: use g_strfreev()
  util: use g_new() family of functions
  virtio: use g_new() family of functions
  virtio-9p: use g_new() family of functions
  decnumber: use g_new() family of functions
  dma: use g_new() family of functions
  dump: use g_new() family of functions
  gdb: use g_new() family of functions

Philippe Mathieu-Daudé (30):
  cocci: script to use g_new() & friends
  cocci: add more g_new() transformations
  cocci: extract typeof() from g_new()
  cocci: avoid use of g_new0()
  cocci: use g_strfreev()
  backends/hostmem: use g_new() family of functions
  ui/spice: use g_new() family of functions
  exec: use g_new() family of functions
  qom: use g_new() family of functions
  qapi: use g_new() family of functions
  target/i386: use g_new() family of functions
  hw/core/loader: use g_new() family of functions
  hw/display/vga: use g_new() family of functions
  bsd-user/syscall: fix a memory leak on EFAULT, use g_new()
  util/qemu-thread-win32: use g_new() family of functions
  util/coroutine: use g_new() family of functions
  block: use g_new() family of functions
  block: avoid use of g_new0()
  hw/block/nvme: use g_new() family of functions
  balloon: use g_new() family of functions
  hmp: use g_new() family of functions
  numa: use g_new() family of functions
  hw/acpi: use g_new() family of functions
  hw/ipmi: use g_new() family of functions
  hw/pci: use g_new() family of functions
  hw/scsi: use g_new() family of functions
  hw/usb: use g_new() family of functions
  net/hub: use g_new() family of functions
  hw/net/rocker: use g_new() family of functions
  scripts/coverity-model: use g_new() family of functions

 hw/lm32/lm32_hwsetup.h              |   2 +-
 include/qemu/timer.h                |   2 +-
 accel/kvm/kvm-all.c                 |   8 +-
 audio/alsaaudio.c                   |   2 +-
 audio/coreaudio.c                   |   2 +-
 audio/dsoundaudio.c                 |   2 +-
 audio/ossaudio.c                    |   2 +-
 audio/paaudio.c                     |   2 +-
 audio/wavaudio.c                    |   2 +-
 audio/wavcapture.c                  |   2 +-
 backends/cryptodev.c                |   2 +-
 backends/hostmem.c                  |   4 +-
 balloon.c                           |   2 +-
 block/backup.c                      |   2 +-
 block/blkdebug.c                    |   4 +-
 block/commit.c                      |   2 +-
 block/iscsi.c                       |   2 +-
 block/linux-aio.c                   |   2 +-
 block/mirror.c                      |   2 +-
 block/qapi.c                        |   4 +-
 block/qcow2-refcount.c              |  12 +-
 block/qcow2.c                       |   2 +-
 block/qed-l2-cache.c                |   2 +-
 block/sheepdog.c                    |   2 +-
 block/stream.c                      |   2 +-
 block/vhdx.c                        |   9 +-
 block/win32-aio.c                   |   2 +-
 bootdevice.c                        |   2 +-
 bsd-user/main.c                     |   6 +-
 bsd-user/syscall.c                  |   3 +-
 bt-host.c                           |   2 +-
 bt-vhci.c                           |   2 +-
 cpus-common.c                       |   4 +-
 cpus.c                              |  18 +--
 disas/m68k.c                        |   3 +-
 disas/nios2.c                       |   3 +-
 disas/sparc.c                       |   3 +-
 dma-helpers.c                       |   4 +-
 dump.c                              |  11 +-
 exec.c                              |   8 +-
 gdbstub.c                           |   4 +-
 hmp.c                               |   2 +-
 hw/9pfs/9p-handle.c                 |   2 +-
 hw/9pfs/9p-proxy.c                  |   2 +-
 hw/9pfs/9p-synth.c                  |   8 +-
 hw/9pfs/9p.c                        |   2 +-
 hw/9pfs/xen-9p-backend.c            |   2 +-
 hw/acpi/vmgenid.c                   |   2 +-
 hw/arm/virt-acpi-build.c            |   2 +-
 hw/audio/intel-hda.c                |   2 +-
 hw/block/nvme.c                     |   4 +-
 hw/block/xen_disk.c                 |   2 +-
 hw/bt/core.c                        |   4 +-
 hw/bt/hci.c                         |   4 +-
 hw/bt/l2cap.c                       |   6 +-
 hw/char/parallel.c                  |   2 +-
 hw/char/serial.c                    |   4 +-
 hw/char/sh_serial.c                 |   2 +-
 hw/char/virtio-serial-bus.c         |   6 +-
 hw/core/irq.c                       |   2 +-
 hw/core/loader.c                    |   6 +-
 hw/core/ptimer.c                    |   2 +-
 hw/core/qdev.c                      |   2 +-
 hw/core/reset.c                     |   2 +-
 hw/display/pxa2xx_lcd.c             |   2 +-
 hw/display/tc6393xb.c               |   2 +-
 hw/display/vga-isa-mm.c             |   6 +-
 hw/display/vga.c                    |   2 +-
 hw/display/virtio-gpu.c             |   4 +-
 hw/display/xenfb.c                  |   4 +-
 hw/dma/etraxfs_dma.c                |   2 +-
 hw/dma/rc4030.c                     |   4 +-
 hw/i2c/bitbang_i2c.c                |   2 +-
 hw/i2c/core.c                       |   4 +-
 hw/i386/acpi-build.c                |   4 +-
 hw/i386/amd_iommu.c                 |   4 +-
 hw/i386/intel_iommu.c               |   2 +-
 hw/i386/pc.c                        |   8 +-
 hw/i386/pc_sysfw.c                  |   6 +-
 hw/i386/xen/xen-hvm.c               |  10 +-
 hw/i386/xen/xen-mapcache.c          |  14 +--
 hw/input/pckbd.c                    |   2 +-
 hw/input/ps2.c                      |   4 +-
 hw/input/pxa2xx_keypad.c            |   2 +-
 hw/input/tsc2005.c                  |   3 +-
 hw/intc/heathrow_pic.c              |   2 +-
 hw/intc/xics.c                      |   2 +-
 hw/intc/xics_kvm.c                  |   4 +-
 hw/ipmi/ipmi_bmc_sim.c              |   2 +-
 hw/lm32/lm32_boards.c               |   4 +-
 hw/lm32/milkymist.c                 |   2 +-
 hw/m68k/mcf5206.c                   |   4 +-
 hw/m68k/mcf5208.c                   |   2 +-
 hw/mips/mips_malta.c                |   2 +-
 hw/mips/mips_mipssim.c              |   2 +-
 hw/mips/mips_r4k.c                  |   2 +-
 hw/misc/applesmc.c                  |   2 +-
 hw/misc/imx6_src.c                  |   2 +-
 hw/misc/ivshmem.c                   |   4 +-
 hw/misc/pvpanic.c                   |   2 +-
 hw/net/rocker/rocker_of_dpa.c       |   4 +-
 hw/net/virtio-net.c                 |   4 +-
 hw/openrisc/openrisc_sim.c          |   2 +-
 hw/pci/pci.c                        |   2 +-
 hw/pci/pcie_port.c                  |   2 +-
 hw/ppc/e500.c                       |   7 +-
 hw/ppc/mac_newworld.c               |   5 +-
 hw/ppc/mac_oldworld.c               |   2 +-
 hw/ppc/ppc.c                        |   8 +-
 hw/ppc/ppc405_boards.c              |   4 +-
 hw/ppc/ppc405_uc.c                  |  24 ++--
 hw/ppc/ppc440_bamboo.c              |   2 +-
 hw/ppc/ppc4xx_devs.c                |   6 +-
 hw/ppc/ppc_booke.c                  |   4 +-
 hw/ppc/prep.c                       |   2 +-
 hw/ppc/spapr.c                      |   2 +-
 hw/ppc/spapr_events.c               |   4 +-
 hw/ppc/spapr_iommu.c                |   2 +-
 hw/ppc/spapr_pci.c                  |   2 +-
 hw/ppc/virtex_ml507.c               |   2 +-
 hw/s390x/css.c                      |  10 +-
 hw/s390x/s390-pci-bus.c             |   4 +-
 hw/scsi/vmw_pvscsi.c                |   2 +-
 hw/sh4/r2d.c                        |   4 +-
 hw/sh4/sh7750.c                     |   2 +-
 hw/sparc/leon3.c                    |   2 +-
 hw/sparc64/sparc64.c                |   4 +-
 hw/timer/arm_timer.c                |   2 +-
 hw/timer/sh_timer.c                 |   4 +-
 hw/timer/slavio_timer.c             |   2 +-
 hw/usb/hcd-ehci.c                   |   2 +-
 hw/vfio/common.c                    |  12 +-
 hw/vfio/pci-quirks.c                |  18 +--
 hw/vfio/pci.c                       |   7 +-
 hw/vfio/platform.c                  |   6 +-
 hw/virtio/vhost.c                   |   2 +-
 hw/virtio/virtio-crypto.c           |   2 +-
 hw/virtio/virtio.c                  |   2 +-
 hw/xen/xen_pvdev.c                  |   2 +-
 hw/xtensa/xtfpga.c                  |   2 +-
 libdecnumber/decNumber.c            |   8 +-
 linux-user/elfload.c                |   2 +-
 linux-user/main.c                   |   6 +-
 memory.c                            |   2 +-
 memory_mapping.c                    |   2 +-
 migration/migration.c               |   2 +-
 migration/page_cache.c              |   2 +-
 migration/postcopy-ram.c            |   2 +-
 migration/ram.c                     |   3 +-
 monitor.c                           |  14 +--
 nbd/server.c                        |   4 +-
 net/hub.c                           |   2 +-
 net/slirp.c                         |   4 +-
 numa.c                              |   2 +-
 qapi/opts-visitor.c                 |   2 +-
 qapi/qapi-clone-visitor.c           |   2 +-
 qapi/qapi-dealloc-visitor.c         |   2 +-
 qapi/qobject-output-visitor.c       |   2 +-
 qapi/string-input-visitor.c         |   2 +-
 qapi/string-output-visitor.c        |   2 +-
 qga/commands-posix.c                |  20 +--
 qga/commands-win32.c                |  12 +-
 qga/commands.c                      |   2 +-
 qmp.c                               |  14 +--
 qobject/json-parser.c               |   2 +-
 qobject/qbool.c                     |   2 +-
 qobject/qdict.c                     |   4 +-
 qobject/qlist.c                     |   4 +-
 qobject/qstring.c                   |   2 +-
 qom/object.c                        |   6 +-
 replay/replay-char.c                |   4 +-
 replay/replay-events.c              |  10 +-
 scripts/coverity-model.c            |   2 +-
 slirp/slirp.c                       |   2 +-
 slirp/socket.c                      |   2 +-
 target/arm/helper.c                 |   4 +-
 target/i386/cpu.c                   |   6 +-
 target/i386/hax-all.c               |   4 +-
 target/i386/hax-mem.c               |   2 +-
 target/i386/hyperv.c                |   2 +-
 target/mips/translate_init.c        |   4 +-
 target/openrisc/mmu.c               |   2 +-
 target/ppc/kvm.c                    |   2 +-
 target/ppc/translate_init.c         |  14 +--
 target/s390x/cpu_models.c           |  12 +-
 target/s390x/diag.c                 |   2 +-
 tcg/tcg.c                           |   4 +-
 tests/ahci-test.c                   |   4 +-
 tests/fw_cfg-test.c                 |   4 +-
 tests/libqos/ahci.c                 |   2 +-
 tests/libqos/libqos.c               |   2 +-
 tests/libqos/malloc.c               |   6 +-
 tests/libqos/pci-pc.c               |   2 +-
 tests/libqos/pci-spapr.c            |   2 +-
 tests/libqos/pci.c                  |   2 +-
 tests/libqos/virtio-mmio.c          |   4 +-
 tests/libqos/virtio-pci.c           |   4 +-
 tests/libqtest.c                    |   2 +-
 tests/pc-cpu-test.c                 |   2 +-
 tests/test-hbitmap.c                |   2 +-
 tests/test-qmp-commands.c           |  14 +--
 tests/test-qobject-output-visitor.c |   4 +-
 thunk.c                             |   2 +-
 ui/spice-core.c                     |  10 +-
 ui/spice-display.c                  |   4 +-
 ui/spice-input.c                    |   4 +-
 ui/vnc-enc-tight.c                  |   2 +-
 ui/vnc-palette.c                    |   2 +-
 ui/vnc.c                            |   6 +-
 util/acl.c                          |   6 +-
 util/coroutine-sigaltstack.c        |   2 +-
 util/coroutine-ucontext.c           |   2 +-
 util/coroutine-win32.c              |   2 +-
 util/envlist.c                      |   6 +-
 util/error.c                        |   2 +-
 util/hbitmap.c                      |   2 +-
 util/iohandler.c                    |   2 +-
 util/main-loop.c                    |   2 +-
 util/module.c                       |   4 +-
 util/qemu-option.c                  |   8 +-
 util/qemu-thread-win32.c            |   2 +-
 util/qemu-timer.c                   |   2 +-
 util/qht.c                          |   2 +-
 vl.c                                |  12 +-
 scripts/coccinelle/g_new.cocci      | 240 ++++++++++++++++++++++++++++++++++++
 225 files changed, 677 insertions(+), 456 deletions(-)
 create mode 100644 scripts/coccinelle/g_new.cocci

-- 
2.14.2
