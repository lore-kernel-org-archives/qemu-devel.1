Received: from eggs.gnu.org ([2001:4830:134:3::10]:33268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qj-0004pt-7S
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qg-0003mH-0s
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:45:57 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6qf-0003m1-O1
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:45:53 -0500
Received: by mail-wm0-x243.google.com with SMTP id c85so58230583wmi.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:45:53 -0800 (PST)
Received: from 640k.lan (94-39-187-56.adsl-ull.clienti.tiscali.it.
	[94.39.187.56]) by smtp.gmail.com with ESMTPSA id
	a186sm4002755wmh.1.2017.01.27.05.45.51 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 27 Jan 2017 05:45:51 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:08 +0100
Message-Id: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/41] Misc changes for 2017-01-27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 3879284d6517dc22529395bdb259f4183b589127:

  Merge remote-tracking branch 'remotes/berrange/tags/pull-qio-2017-01-23-2' into staging (2017-01-23 15:59:09 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 0a24326232f7c7f8c5ab9080784312d05d496e47:

  memory: don't sign-extend 32-bit writes (2017-01-26 15:29:49 +0100)

----------------------------------------------------------------
* SCSI max_transfer support for scsi-generic (Eric)
* x86 SMI broadcast (Laszlo)
* Character device QOMification (Marc-André)
* Record/replay improvements (Pavel)
* iscsi fixes (Peter L.)
* "info mtree -f" command (Peter Xu)
* TSC clock rate reporting (Phil)
* DEVICE_CATEGORY_CPU (Thomas)
* Memory sign-extension fix (Ladi)

----------------------------------------------------------------
Eric Farman (3):
      hw/scsi: Fix debug message of cdb structure in scsi-generic
      block: Fix target variable of BLKSECTGET ioctl
      block: get max_transfer limit for char (scsi-generic) devices

Ladi Prosek (1):
      memory: don't sign-extend 32-bit writes

Laszlo Ersek (3):
      hw/isa/lpc_ich9: add SMI feature negotiation via fw_cfg
      hw/isa/lpc_ich9: add broadcast SMI feature
      hw/isa/lpc_ich9: negotiate SMI broadcast on pc-q35-2.9+ machine types

Marc-André Lureau (20):
      tests: fix linking test-char on win32
      qemu-options: stdio is available on win32
      char: add qemu_chr_fe_add_watch() Returns description
      doc: fix spelling
      char: use a const CharDriver
      char: use a static array for backends
      char: move callbacks in CharDriver
      char: fold single-user functions in caller
      char: introduce generic qemu_chr_get_kind()
      char: use a feature bit for replay
      char: allocate CharDriverState as a single object
      bt: use qemu_chr_alloc()
      char: rename CharDriverState Chardev
      char: rename TCPChardev and NetChardev
      spice-char: improve error reporting
      char: use error_report()
      gtk: overwrite the console.c char driver
      baum: use a common prefix for chr callbacks
      vc: use a common prefix for chr callbacks
      chardev: qom-ify

Pavel Dovgalyuk (7):
      icount: update instruction counter on apic patching
      replay: improve interrupt handling
      replay: don't use rtc clock on loadvm phase
      savevm: add public save_vmstate function
      replay: save/load initial state
      replay: exception replay fix
      apic: save apic_delivered flag

Peter Lieven (2):
      block/iscsi: avoid data corruption with cache=writeback
      block/iscsi: statically link qemu_iscsi_opts

Peter Xu (2):
      memory: tune mtree_print_mr() to dump mr type
      memory: hmp: add "-f" for "info mtree"

Phil Dennis-Jordan (2):
      x86-KVM: Supply TSC and APIC clock rates to guest like VMWare
      pc: Enable vmware-cpuid-freq CPU option for 2.9+ machine types

Thomas Huth (1):
      Introduce DEVICE_CATEGORY_CPU for CPU devices

 MAINTAINERS                       |    1 +
 backends/baum.c                   |  102 +-
 backends/msmouse.c                |   77 +-
 backends/rng-egd.c                |    4 +-
 backends/testdev.c                |   53 +-
 block/Makefile.objs               |    1 +
 block/file-posix.c                |   19 +-
 block/iscsi-opts.c                |   69 ++
 block/iscsi.c                     |    8 +-
 cpu-exec.c                        |    2 +-
 docs/replay.txt                   |   16 +
 exec.c                            |    2 +-
 gdbstub.c                         |   45 +-
 hmp-commands-info.hx              |    6 +-
 hw/arm/fsl-imx25.c                |    2 +-
 hw/arm/fsl-imx31.c                |    2 +-
 hw/arm/fsl-imx6.c                 |    2 +-
 hw/arm/nseries.c                  |    2 +-
 hw/arm/omap2.c                    |    2 +-
 hw/arm/pxa2xx.c                   |    2 +-
 hw/arm/virt.c                     |    2 +-
 hw/bt/hci-csr.c                   |   64 +-
 hw/char/escc.c                    |    2 +-
 hw/char/exynos4210_uart.c         |    2 +-
 hw/char/imx_serial.c              |    2 +-
 hw/char/mcf_uart.c                |    4 +-
 hw/char/omap_uart.c               |    6 +-
 hw/char/parallel.c                |    2 +-
 hw/char/serial-isa.c              |    2 +-
 hw/char/serial.c                  |    4 +-
 hw/char/sh_serial.c               |    2 +-
 hw/char/spapr_vty.c               |    2 +-
 hw/char/virtio-console.c          |    2 +-
 hw/core/qdev-properties-system.c  |    4 +-
 hw/cpu/core.c                     |    8 +
 hw/display/milkymist-tmu2.c       |    2 +-
 hw/display/sm501.c                |    2 +-
 hw/i386/kvmvapic.c                |    6 +
 hw/intc/apic_common.c             |   33 +
 hw/isa/isa-bus.c                  |    2 +-
 hw/isa/lpc_ich9.c                 |   91 +-
 hw/isa/pc87312.c                  |    2 +-
 hw/lm32/lm32.h                    |    4 +-
 hw/lm32/milkymist-hw.h            |    2 +-
 hw/mips/mips_malta.c              |    4 +-
 hw/misc/ivshmem.c                 |    2 +-
 hw/misc/milkymist-pfpu.c          |    2 +-
 hw/scsi/scsi-generic.c            |    5 +-
 hw/timer/mc146818rtc.c            |   15 +-
 hw/usb/ccid-card-passthru.c       |    2 +-
 hw/usb/dev-serial.c               |    6 +-
 hw/usb/redirect.c                 |    4 +-
 include/block/block.h             |    1 +
 include/exec/memory.h             |    2 +-
 include/hw/arm/exynos4210.h       |    2 +-
 include/hw/arm/omap.h             |    6 +-
 include/hw/bt.h                   |    4 +-
 include/hw/char/cadence_uart.h    |    2 +-
 include/hw/char/escc.h            |    2 +-
 include/hw/char/pl011.h           |    4 +-
 include/hw/char/serial.h          |    4 +-
 include/hw/char/xilinx_uartlite.h |    2 +-
 include/hw/cris/etraxfs.h         |    2 +-
 include/hw/devices.h              |    2 +-
 include/hw/i386/apic_internal.h   |    2 +
 include/hw/i386/ich9.h            |   13 +
 include/hw/i386/pc.h              |   12 +-
 include/hw/m68k/mcf.h             |    4 +-
 include/hw/ppc/spapr_vio.h        |    2 +-
 include/hw/qdev-core.h            |    1 +
 include/hw/qdev-properties.h      |    2 +-
 include/hw/sh4/sh.h               |    2 +-
 include/hw/sparc/grlib.h          |    2 +-
 include/hw/xen/xen.h              |    2 +-
 include/monitor/monitor.h         |    2 +-
 include/qemu/typedefs.h           |    2 +-
 include/sysemu/char.h             |  155 +--
 include/sysemu/replay.h           |   13 +-
 include/sysemu/sysemu.h           |    5 +-
 include/ui/console.h              |    2 +
 include/ui/gtk.h                  |    2 +-
 include/ui/qemu-spice.h           |    2 +-
 memory.c                          |   89 +-
 migration/savevm.c                |   33 +-
 monitor.c                         |   10 +-
 net/colo-compare.c                |    4 +-
 net/filter-mirror.c               |    4 +-
 net/slirp.c                       |    2 +-
 net/vhost-user.c                  |   10 +-
 qdev-monitor.c                    |    1 +
 qemu-char.c                       | 1914 ++++++++++++++++++++-----------------
 qemu-options.hx                   |   12 +-
 qmp.c                             |    2 +-
 qom/cpu.c                         |    1 +
 qtest.c                           |    2 +-
 replay/replay-char.c              |    8 +-
 replay/replay-snapshot.c          |   17 +
 replay/replay.c                   |    5 +
 spice-qemu-char.c                 |  231 +++--
 stubs/monitor.c                   |    2 +-
 stubs/replay.c                    |    4 +-
 target/i386/cpu.c                 |    1 +
 target/i386/cpu.h                 |    4 +
 target/i386/kvm.c                 |   36 +-
 target/i386/seg_helper.c          |    1 +
 tests/Makefile.include            |    2 +-
 tests/test-char.c                 |   10 +-
 tests/vhost-user-test.c           |    4 +-
 translate-all.c                   |    2 +
 ui/console.c                      |  111 ++-
 ui/gtk.c                          |   86 +-
 vl.c                              |   59 +-
 xen-common-stub.c                 |    2 +-
 xen-common.c                      |    4 +-
 114 files changed, 2192 insertions(+), 1448 deletions(-)
 create mode 100644 block/iscsi-opts.c
-- 
1.8.3.1
