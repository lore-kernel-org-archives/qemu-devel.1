Received: from eggs.gnu.org ([2001:4830:134:3::10]:42352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYV-0000C1-CD
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYQ-0004ui-BV
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:39 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:36787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVxYQ-0004u3-1E
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:34 -0400
Received: by mail-wr0-x235.google.com with SMTP id y28so13192004wrd.3
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:10:33 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51])
	by smtp.gmail.com with ESMTPSA id 143sm2934870wmg.9.2017.07.14.03.10.30
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 14 Jul 2017 03:10:30 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 12:10:12 +0200
Message-Id: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/55] Misc patches for QEMU 2.10 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 49bcce4b9c11759678fd223aefb48691c4959d4f:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-07-12' into staging (2017-07-13 16:56:06 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 68c761e19c2ea453f880dbbd04e867d34d1468b8:

  spapr_rng: Convert to DEFINE_PROP_LINK (2017-07-14 12:04:43 +0200)

----------------------------------------------------------------
* gdbstub fixes (Alex)
* IOMMU MemoryRegion subclass (Alexey)
* Chardev hotswap (Anton)
* NBD_OPT_GO support (Eric)
* Misc bugfixes
* DEFINE_PROP_LINK (minus the ARM patches - Fam)
* MAINTAINERS updates (Philippe)

----------------------------------------------------------------
Alex Bennée (4):
      gdbstub: modernise DEBUG_GDB
      gdbstub: rename cpu_index -> cpu_gdb_index
      qom/cpu: remove host_tid field
      gdbstub: don't fail on vCont; C04:0; c packets

Alexey Kardashevskiy (2):
      memory/iommu: QOM'fy IOMMU MemoryRegion
      memory/iommu: introduce IOMMUMemoryRegionClass

Anton Nefedov (13):
      char: move QemuOpts->ChardevBackend translation to a separate func
      char: add backend hotswap handler
      char: chardevice hotswap
      char: forbid direct chardevice access for hotswap devices
      char: avoid chardevice direct access
      test-char: destroy chardev-udp after test
      test-char: split char_udp_test
      test-char: split char_file_test
      test-char: add hotswap test
      hmp: add hmp analogue for qmp-chardev-change
      virtio-console: chardev hotswap support
      serial: move TIOCM update to a separate function
      serial: chardev hotswap support

Emilio G. Cota (2):
      vl: fix breakage of -tb-size
      translate-all: remove redundant !tcg_enabled check in dump_exec_info

Eric Blake (9):
      nbd: Create struct for tracking export info
      nbd: Don't bother tracing an NBD_OPT_ABORT response failure
      nbd: Expose and debug more NBD constants
      nbd: Simplify trace of client flags in negotiation
      nbd: Refactor reply to NBD_OPT_EXPORT_NAME
      nbd: Implement NBD_OPT_GO on server
      nbd: Implement NBD_OPT_GO on client
      nbd: Implement NBD_INFO_BLOCK_SIZE on server
      nbd: Implement NBD_INFO_BLOCK_SIZE on client

Fam Zheng (13):
      qdev: Introduce PropertyInfo.create
      qdev: Introduce DEFINE_PROP_LINK
      qmp: Use ObjectProperty.type if present
      qdev: Add const qualifier to PropertyInfo definitions
      virtio-blk: Convert to DEFINE_PROP_LINK
      virtio-scsi: Convert to DEFINE_PROP_LINK
      virtio-rng: Convert to DEFINE_PROP_LINK
      virtio-crypto: Convert to DEFINE_PROP_LINK
      dimm: Convert to DEFINE_PROP_LINK
      ivshmem: Convert to DEFINE_PROP_LINK
      mips_cmgcr: Convert to DEFINE_PROP_LINK
      cpu: Convert to DEFINE_PROP_LINK
      spapr_rng: Convert to DEFINE_PROP_LINK

Igor Mammedov (1):
      qom: enforce readonly nature of link's check callback

Marc-André Lureau (1):
      chardev: block during sync read

Paolo Bonzini (1):
      build: add -Wexpansion-to-defined

Peng Hao (1):
      chardev: fix parallel device can't be reconnect

Philippe Mathieu-Daudé (5):
      MAINTAINERS: update TCG entries
      MAINTAINERS: update KVM entries
      MAINTAINERS: update Xen entries
      MAINTAINERS: update TCI entry
      MAINTAINERS: add entry for "Unimplemented" device

Pranith Kumar (2):
      Revert "exec.c: Fix breakpoint invalidation race"
      mttcg/i386: Patch instruction using async_safe_* framework

Prasad J Pandit (1):
      exec: use qemu_ram_ptr_length to access guest ram

 MAINTAINERS                      |  18 +--
 accel/tcg/translate-all.c        |   5 -
 backends/rng-egd.c               |   2 +-
 block/nbd-client.c               |  22 +--
 block/nbd-client.h               |   3 +-
 block/nbd.c                      |  16 ++-
 bsd-user/qemu.h                  |   2 +
 chardev/char-fe.c                |  16 ++-
 chardev/char-mux.c               |   1 +
 chardev/char-socket.c            |   2 +
 chardev/char.c                   | 164 +++++++++++++++++----
 configure                        |   2 +-
 exec.c                           |  70 +++++----
 gdbstub.c                        | 119 ++++++++-------
 hmp-commands.hx                  |  18 ++-
 hmp.c                            |  34 +++++
 hmp.h                            |   1 +
 hw/alpha/typhoon.c               |  31 ++--
 hw/arm/pxa2xx.c                  |   3 +-
 hw/arm/strongarm.c               |   4 +-
 hw/block/virtio-blk.c            |   6 +-
 hw/char/bcm2835_aux.c            |   2 +-
 hw/char/cadence_uart.c           |   4 +-
 hw/char/debugcon.c               |   4 +-
 hw/char/digic-uart.c             |   2 +-
 hw/char/escc.c                   |   8 +-
 hw/char/etraxfs_ser.c            |   2 +-
 hw/char/exynos4210_uart.c        |   4 +-
 hw/char/grlib_apbuart.c          |   4 +-
 hw/char/imx_serial.c             |   2 +-
 hw/char/ipoctal232.c             |   4 +-
 hw/char/lm32_juart.c             |   2 +-
 hw/char/lm32_uart.c              |   2 +-
 hw/char/mcf_uart.c               |   2 +-
 hw/char/milkymist-uart.c         |   2 +-
 hw/char/parallel.c               |   8 +-
 hw/char/pl011.c                  |   2 +-
 hw/char/sclpconsole-lm.c         |   4 +-
 hw/char/sclpconsole.c            |   4 +-
 hw/char/serial.c                 |  63 ++++++--
 hw/char/sh_serial.c              |   4 +-
 hw/char/spapr_vty.c              |   4 +-
 hw/char/stm32f2xx_usart.c        |   3 +-
 hw/char/terminal3270.c           |   4 +-
 hw/char/virtio-console.c         |  35 ++++-
 hw/char/xen_console.c            |   4 +-
 hw/char/xilinx_uartlite.c        |   2 +-
 hw/core/qdev-properties-system.c |   8 +-
 hw/core/qdev-properties.c        |  63 +++++---
 hw/core/qdev.c                   |  31 ++--
 hw/display/xlnx_dp.c             |   2 +-
 hw/dma/rc4030.c                  |  34 +++--
 hw/i386/amd_iommu.c              |  33 +++--
 hw/i386/amd_iommu.h              |   5 +-
 hw/i386/intel_iommu.c            |  42 ++++--
 hw/i386/kvmvapic.c               |  85 +++++------
 hw/ipmi/ipmi.c                   |   2 +-
 hw/ipmi/ipmi_bmc_extern.c        |   4 +-
 hw/mem/pc-dimm.c                 |  30 +---
 hw/mips/boston.c                 |   2 +-
 hw/mips/mips_jazz.c              |   2 +-
 hw/mips/mips_malta.c             |   2 +-
 hw/misc/ivshmem.c                |  30 ++--
 hw/misc/mips_cmgcr.c             |  16 +--
 hw/pci-host/apb.c                |  29 ++--
 hw/ppc/spapr_iommu.c             |  42 ++++--
 hw/ppc/spapr_rng.c               |   8 +-
 hw/s390x/css.c                   |   4 +-
 hw/s390x/s390-pci-bus.c          |  31 ++--
 hw/s390x/s390-pci-bus.h          |   3 +-
 hw/s390x/s390-pci-inst.c         |  11 +-
 hw/s390x/virtio-ccw.c            |   9 --
 hw/scsi/virtio-scsi.c            |  13 +-
 hw/usb/ccid-card-passthru.c      |   6 +-
 hw/usb/dev-serial.c              |   7 +-
 hw/usb/redirect.c                |   7 +-
 hw/vfio/common.c                 |  12 +-
 hw/vfio/spapr.c                  |   3 +-
 hw/virtio/virtio-crypto-pci.c    |   2 -
 hw/virtio/virtio-crypto.c        |  27 +---
 hw/virtio/virtio-pci.c           |   6 -
 hw/virtio/virtio-rng.c           |  12 +-
 include/block/nbd.h              |  58 ++++++--
 include/chardev/char-fe.h        |  22 +++
 include/chardev/char.h           |  19 +++
 include/exec/exec-all.h          |   3 +
 include/exec/gdbstub.h           |   9 --
 include/exec/memory.h            |  94 ++++++++----
 include/hw/i386/intel_iommu.h    |   5 +-
 include/hw/mips/mips.h           |   2 +-
 include/hw/ppc/spapr.h           |   7 +-
 include/hw/qdev-core.h           |   6 +-
 include/hw/qdev-properties.h     |  62 ++++----
 include/hw/s390x/css.h           |   4 +-
 include/hw/vfio/vfio-common.h    |   2 +-
 include/qemu/typedefs.h          |   1 +
 include/qom/cpu.h                |   3 +-
 include/qom/object.h             |   6 +-
 linux-user/syscall.c             |   1 -
 memory.c                         | 113 ++++++++++-----
 monitor.c                        |   4 +-
 nbd/client.c                     | 283 ++++++++++++++++++++++++++++++------
 nbd/common.c                     |  92 ++++++++++++
 nbd/nbd-internal.h               |  13 +-
 nbd/server.c                     | 304 +++++++++++++++++++++++++++++++++------
 nbd/trace-events                 |  25 ++--
 net/colo-compare.c               |  10 +-
 net/filter-mirror.c              |   8 +-
 net/slirp.c                      |   2 +-
 net/vhost-user.c                 |   7 +-
 qapi-schema.json                 |  40 ++++++
 qemu-nbd.c                       |  10 +-
 qmp.c                            |   5 +-
 qom/cpu.c                        |   1 +
 qom/object.c                     |   8 +-
 qtest.c                          |   2 +-
 target/i386/cpu.c                |   2 +-
 target/ppc/translate_init.c      |   2 +-
 target/xtensa/xtensa-semi.c      |   2 +-
 tests/test-char.c                | 275 ++++++++++++++++++++++++++---------
 tests/test-hmp.c                 |   1 +
 tests/vhost-user-test.c          |   2 +-
 vl.c                             |   8 +-
 123 files changed, 2006 insertions(+), 860 deletions(-)
-- 
1.8.3.1
