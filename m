Received: from eggs.gnu.org ([2001:4830:134:3::10]:51539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3o-0001M4-PQ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3k-0002tR-Mb
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:44 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf3k-0002rF-CJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:40 -0400
Received: by mail-wm0-f48.google.com with SMTP id 62so25293548wmw.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:25:40 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51]) by smtp.gmail.com with ESMTPSA id
	k75sm6042448wmh.10.2017.07.13.07.24.35 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Jul 2017 07:24:36 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:23:53 +0200
Message-Id: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/41] Misc patches for QEMU 2.10 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit f0d2ead97cddf622a0478086886cc70a8ed6aeaf:

  Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170711' into staging (2017-07-13 12:48:37 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to a5c8d75361054dbf953b87bc9675ecb11433762a:

  translate-all: remove redundant !tcg_enabled check in dump_exec_info (2017-07-13 15:43:45 +0200)

----------------------------------------------------------------
* gdbstub fixes (Alex)
* IOMMU MemoryRegion subclass (Alexey)
* Chardev hotswap (Anton)
* NBD_OPT_GO support (Eric)
* Misc bugfixes
* MAINTAINERS updates (Philippe)

----------------------------------------------------------------
I'm away next week, I'd be able to resubmit if there are issues on July 23.

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

 MAINTAINERS                   |  18 +--
 accel/tcg/translate-all.c     |   5 -
 backends/rng-egd.c            |   2 +-
 block/nbd-client.c            |  22 +--
 block/nbd-client.h            |   3 +-
 block/nbd.c                   |  16 ++-
 bsd-user/qemu.h               |   2 +
 chardev/char-fe.c             |  16 ++-
 chardev/char-mux.c            |   1 +
 chardev/char-socket.c         |   2 +
 chardev/char.c                | 164 ++++++++++++++++++-----
 configure                     |   2 +-
 exec.c                        |  43 ++++--
 gdbstub.c                     | 119 ++++++++---------
 hmp-commands.hx               |  18 ++-
 hmp.c                         |  34 +++++
 hmp.h                         |   1 +
 hw/alpha/typhoon.c            |  31 +++--
 hw/arm/pxa2xx.c               |   3 +-
 hw/arm/strongarm.c            |   4 +-
 hw/char/bcm2835_aux.c         |   2 +-
 hw/char/cadence_uart.c        |   4 +-
 hw/char/debugcon.c            |   4 +-
 hw/char/digic-uart.c          |   2 +-
 hw/char/escc.c                |   8 +-
 hw/char/etraxfs_ser.c         |   2 +-
 hw/char/exynos4210_uart.c     |   4 +-
 hw/char/grlib_apbuart.c       |   4 +-
 hw/char/imx_serial.c          |   2 +-
 hw/char/ipoctal232.c          |   4 +-
 hw/char/lm32_juart.c          |   2 +-
 hw/char/lm32_uart.c           |   2 +-
 hw/char/mcf_uart.c            |   2 +-
 hw/char/milkymist-uart.c      |   2 +-
 hw/char/parallel.c            |   8 +-
 hw/char/pl011.c               |   2 +-
 hw/char/sclpconsole-lm.c      |   4 +-
 hw/char/sclpconsole.c         |   4 +-
 hw/char/serial.c              |  63 +++++++--
 hw/char/sh_serial.c           |   4 +-
 hw/char/spapr_vty.c           |   4 +-
 hw/char/stm32f2xx_usart.c     |   3 +-
 hw/char/terminal3270.c        |   4 +-
 hw/char/virtio-console.c      |  35 ++++-
 hw/char/xen_console.c         |   4 +-
 hw/char/xilinx_uartlite.c     |   2 +-
 hw/dma/rc4030.c               |  34 +++--
 hw/i386/amd_iommu.c           |  33 +++--
 hw/i386/amd_iommu.h           |   5 +-
 hw/i386/intel_iommu.c         |  42 ++++--
 hw/i386/kvmvapic.c            |  85 ++++++------
 hw/ipmi/ipmi_bmc_extern.c     |   4 +-
 hw/mips/boston.c              |   2 +-
 hw/mips/mips_jazz.c           |   2 +-
 hw/mips/mips_malta.c          |   2 +-
 hw/misc/ivshmem.c             |   6 +-
 hw/pci-host/apb.c             |  29 ++--
 hw/ppc/spapr_iommu.c          |  42 ++++--
 hw/s390x/s390-pci-bus.c       |  29 ++--
 hw/s390x/s390-pci-bus.h       |   3 +-
 hw/s390x/s390-pci-inst.c      |  11 +-
 hw/usb/ccid-card-passthru.c   |   6 +-
 hw/usb/dev-serial.c           |   7 +-
 hw/usb/redirect.c             |   7 +-
 hw/vfio/common.c              |  12 +-
 hw/vfio/spapr.c               |   3 +-
 include/block/nbd.h           |  58 ++++++--
 include/chardev/char-fe.h     |  22 +++
 include/chardev/char.h        |  19 +++
 include/exec/gdbstub.h        |   9 --
 include/exec/memory.h         |  94 +++++++++----
 include/hw/i386/intel_iommu.h |   5 +-
 include/hw/mips/mips.h        |   2 +-
 include/hw/ppc/spapr.h        |   7 +-
 include/hw/vfio/vfio-common.h |   2 +-
 include/qemu/typedefs.h       |   1 +
 include/qom/cpu.h             |   2 -
 linux-user/syscall.c          |   1 -
 memory.c                      | 113 +++++++++++-----
 monitor.c                     |   4 +-
 nbd/client.c                  | 283 +++++++++++++++++++++++++++++++++------
 nbd/common.c                  |  92 +++++++++++++
 nbd/nbd-internal.h            |  13 +-
 nbd/server.c                  | 304 +++++++++++++++++++++++++++++++++++-------
 nbd/trace-events              |  25 ++--
 net/colo-compare.c            |  10 +-
 net/filter-mirror.c           |   8 +-
 net/slirp.c                   |   2 +-
 net/vhost-user.c              |   7 +-
 qapi-schema.json              |  40 ++++++
 qemu-nbd.c                    |  10 +-
 qtest.c                       |   2 +-
 target/xtensa/xtensa-semi.c   |   2 +-
 tests/test-char.c             | 275 ++++++++++++++++++++++++++++----------
 tests/test-hmp.c              |   1 +
 tests/vhost-user-test.c       |   2 +-
 vl.c                          |   8 +-
 97 files changed, 1831 insertions(+), 643 deletions(-)
-- 
1.8.3.1
