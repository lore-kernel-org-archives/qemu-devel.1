Received: from eggs.gnu.org ([2001:4830:134:3::10]:57733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsha-0005Lt-W9
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshW-0002bx-Mp
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:27 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:40977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshW-0002ag-CG
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:22 -0400
Received: by mail-wr0-x234.google.com with SMTP id f14so2516581wre.8
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:22 -0700 (PDT)
Received: from donizetti.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	x107sm1557951wrb.97.2018.03.13.15.47.19 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 13 Mar 2018 15:47:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:10 +0100
Message-Id: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/69] Misc patches for QEMU soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Not sure why this didn't make it to the list yesterday---most likely I
didn't remove --dry-run...  Now I understand why everybody was waiting
for my pull request.

The following changes since commit 819fd4699c7b36d574292bcbd8bc25e9d716c84b:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180309a' into staging (2018-03-12 13:21:53 +0000)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 0790f86861079b1932679d0f011e431aaf4ee9e2:

  tcg: fix cpu_io_recompile (2018-03-12 17:10:38 +0100)

----------------------------------------------------------------
* Record-replay lockstep execution, log dumper and fixes (Alex, Pavel)
* SCSI fix to pass maximum transfer size (Daniel Barboza)
* chardev fixes and improved iothread support (Daniel Berrangé, Peter)
* checkpatch tweak (Eric)
* make help tweak (Marc-André)
* make more PCI NICs available with -net or -nic (myself)
* change default q35 NIC to e1000e (myself)
* SCSI support for NDOB bit (myself)
* membarrier system call support (myself)
* SuperIO refactoring (Philippe)
* miscellaneous cleanups and fixes (Thomas)

----------------------------------------------------------------
Alex Bennée (5):
      replay/replay.c: bump REPLAY_VERSION again
      replay/replay-internal.c: track holding of replay_lock
      replay: make locking visible outside replay code
      replay: push replay_mutex_lock up the call tree
      scripts/replay-dump.py: replay log dumper

Daniel Henrique Barboza (1):
      scsi-disk.c: consider bl->max_transfer in INQUIRY emulation

Daniel P. Berrangé (1):
      chardev: fix handling of EAGAIN for TCP chardev

Eric Blake (1):
      checkpatch: Exempt long URLs

Marc-André Lureau (1):
      build-sys: make help could have 'modules' target

Paolo Bonzini (11):
      qom: introduce object_class_get_list_sorted
      net: allow using any PCI NICs in -net or -nic
      q35: change default NIC to e1000e
      qemu-doc: update deprecation section to use -nic and -netdev hubport
      scsi: support NDOB (no data-out buffer) for WRITE SAME commands
      hw/i386: make IOMMUs configurable via default-configs/
      rcutorture: remove synchronize_rcu from readers
      docs: document atomic_load_acquire and atomic_store_release
      rcu: make memory barriers more explicit
      membarrier: introduce qemu/sys_membarrier.h
      membarrier: add --enable-membarrier

Pavel Dovgalyuk (13):
      cpu-exec: fix exception_index handling
      replay: fix processing async events
      replay: fixed replay_enable_events
      replay: fix save/load vm for non-empty queue
      replay: added replay log format description
      replay: save prior value of the host clock
      replay: don't destroy mutex at exit
      replay: check return values of fwrite
      replay: avoid recursive call of checkpoints
      replay: don't process async events when warping the clock
      replay: save vmstate of the asynchronous events
      replay: update documentation
      tcg: fix cpu_io_recompile

Peter Xu (7):
      vl: export machine_init_done
      chardev: update net listener gcontext
      chardev: allow telnet gsource to switch gcontext
      chardev: introduce chr_machine_done hook
      chardev: use chardev's gcontext for async connect
      chardev: tcp: postpone async connection setup
      chardev: tcp: let TLS run on chardev context

Philippe Mathieu-Daudé (25):
      hw/isa: Move parallel_hds_isa_init() to hw/char/parallel-isa.c
      hw/dma/i8257: Rename DMA_init() to i8257_dma_init()
      hw/input/i8042: Extract declarations from i386/pc.h into input/i8042.h
      MAINTAINERS: Fix the PC87312 include path
      hw/isa/pc87312: Rename the device type as TYPE_PC87312_SUPERIO
      hw/isa/pc87312: Use uint16_t for the ISA I/O base address
      hw/isa/pc87312: Use 'unsigned int' for the irq value
      hw/isa/superio: Add a Super I/O template based on the PC87312 device
      hw/isa/pc87312: Inherit from the abstract TYPE_ISA_SUPERIO
      hw/isa/superio: Factor out the parallel code from pc87312.c
      hw/isa/superio: Factor out the serial code from pc87312.c
      hw/isa/superio: Factor out the floppy disc controller code from pc87312.c
      hw/isa/superio: Add a keyboard/mouse controller (8042)
      hw/isa/superio: Factor out the IDE code from pc87312.c
      hw/mips/malta: Code movement
      hw/isa/superio: Factor out the FDC37M817 Super I/O from mips_malta.c
      hw/mips/mips_fulong2e: Factor out vt82c686b_southbridge_init()
      hw/isa/vt82c686: Rename vt82c686b_init() -> vt82c686b_isa_init()
      hw/isa/vt82c686: Add the TYPE_VT82C686B_SUPERIO
      MAINTAINERS: Add entries for the VT82C686B Super I/O
      MAINTAINERS: Split the Alpha TCG/machine section
      hw/isa/superio: Add the SMC FDC37C669 Super I/O
      hw/alpha/dp264: Add the ISA DMA controller
      hw/alpha/dp264: Use the TYPE_SMC37C669_SUPERIO
      hw/i386/pc: Factor out the superio code

Thomas Huth (4):
      qemu-doc: Add the paragraph about the -no-frame deprecation again
      hw: Do not include "sysemu/block-backend.h" if it is not necessary
      Polish the version strings containing the package version
      hw/mips/jazz: Fix implicit creation of "-drive if=scsi" devices

 MAINTAINERS                        |  20 ++-
 Makefile                           |  23 +--
 accel/tcg/cpu-exec.c               |   5 +-
 accel/tcg/translate-all.c          |  18 ++-
 bsd-user/main.c                    |   2 +-
 chardev/char-mux.c                 |  33 +++-
 chardev/char-socket.c              | 137 ++++++++++++-----
 chardev/char.c                     |  43 ++----
 configure                          |  44 +++++-
 cpus.c                             |  24 ++-
 default-configs/alpha-softmmu.mak  |   5 +
 default-configs/i386-softmmu.mak   |   2 +
 default-configs/x86_64-softmmu.mak |   2 +
 docs/devel/atomics.txt             |  57 +++----
 docs/replay.txt                    | 163 +++++++++++++++++---
 hw/alpha/dp264.c                   |  13 +-
 hw/arm/highbank.c                  |   1 -
 hw/arm/msf2-soc.c                  |   1 -
 hw/arm/realview.c                  |   1 -
 hw/arm/tosa.c                      |   1 -
 hw/char/Makefile.objs              |   1 +
 hw/char/parallel-isa.c             |  36 +++++
 hw/char/parallel.c                 |   2 +-
 hw/dma/i82374.c                    |   3 +-
 hw/dma/i8257.c                     |   4 +-
 hw/i386/Makefile.objs              |   4 +-
 hw/i386/pc.c                       |  86 ++++++-----
 hw/i386/pc_piix.c                  |   7 +-
 hw/i386/pc_q35.c                   |   8 +-
 hw/i386/vmmouse.c                  |   1 +
 hw/i386/vmport.c                   |   1 +
 hw/ide/ahci-allwinner.c            |   1 -
 hw/ide/cmd646.c                    |   1 -
 hw/ide/ich.c                       |   1 -
 hw/ide/isa.c                       |   1 -
 hw/ide/microdrive.c                |   1 -
 hw/ide/mmio.c                      |   1 -
 hw/input/pckbd.c                   |   2 +-
 hw/isa/Makefile.objs               |   1 +
 hw/isa/isa-bus.c                   |  26 ----
 hw/isa/isa-superio.c               | 214 ++++++++++++++++++++++++++
 hw/isa/pc87312.c                   | 178 ++++++++++-----------
 hw/isa/smc37c669-superio.c         | 115 ++++++++++++++
 hw/isa/trace-events                |  10 +-
 hw/isa/vt82c686.c                  |  22 ++-
 hw/mips/mips_fulong2e.c            |  86 +++++------
 hw/mips/mips_jazz.c                |  13 +-
 hw/mips/mips_malta.c               |  48 +++---
 hw/mips/mips_r4k.c                 |   3 +-
 hw/pci/pci.c                       |  61 ++++----
 hw/ppc/e500.c                      |   2 +-
 hw/ppc/mac_newworld.c              |   1 -
 hw/ppc/mac_oldworld.c              |   1 -
 hw/ppc/prep.c                      |   7 +-
 hw/scsi/esp.c                      |  12 +-
 hw/scsi/mptendian.c                |   1 -
 hw/scsi/scsi-bus.c                 |   2 +-
 hw/scsi/scsi-disk.c                |  17 +-
 hw/sd/core.c                       |   1 -
 hw/sparc/sun4m.c                   |   5 -
 hw/sparc64/sun4u.c                 |   6 +-
 hw/tricore/tricore_testboard.c     |   2 -
 hw/unicore32/puv3.c                |   1 +
 include/chardev/char-mux.h         |   2 -
 include/chardev/char.h             |   2 +
 include/hw/char/parallel.h         |  14 ++
 include/hw/{isa => dma}/i8257.h    |   6 +
 include/hw/i386/pc.h               |  20 +--
 include/hw/input/i8042.h           |  24 +++
 include/hw/isa/isa.h               |   2 -
 include/hw/isa/pc87312.h           |  24 +--
 include/hw/isa/superio.h           |  60 ++++++++
 include/hw/isa/vt82c686.h          |   4 +-
 include/hw/scsi/esp.h              |  10 +-
 include/qemu/rcu.h                 |  16 +-
 include/qemu/sys_membarrier.h      |  27 ++++
 include/qemu/timer.h               |  14 ++
 include/qom/object.h               |  11 ++
 include/sysemu/replay.h            |  16 ++
 include/sysemu/sysemu.h            |   2 +
 linux-user/main.c                  |   2 +-
 migration/savevm.c                 |  13 ++
 qdev-monitor.c                     |   9 +-
 qemu-doc.texi                      |  44 ++++--
 qemu-img.c                         |   2 +-
 qemu-io.c                          |   2 +-
 qemu-nbd.c                         |   2 +-
 qga/main.c                         |   2 +-
 qom/object.c                       |  13 ++
 replay/replay-audio.c              |  14 +-
 replay/replay-char.c               |  21 +--
 replay/replay-events.c             |  75 +++++----
 replay/replay-internal.c           |  43 +++++-
 replay/replay-internal.h           |  17 +-
 replay/replay-snapshot.c           |  12 ++
 replay/replay-time.c               |  10 +-
 replay/replay.c                    |  58 ++++---
 scripts/checkpatch.pl              |   3 +-
 scripts/replay-dump.py             | 308 +++++++++++++++++++++++++++++++++++++
 scsi/qemu-pr-helper.c              |   2 +-
 stubs/machine-init-done.c          |   2 +
 stubs/replay.c                     |   8 +
 target/alpha/cpu.c                 |  15 +-
 target/hppa/cpu.c                  |  15 +-
 target/lm32/cpu.c                  |  15 +-
 target/sh4/cpu.c                   |  15 +-
 target/tricore/helper.c            |   2 +-
 tests/rcutorture.c                 |   4 -
 tests/test-char.c                  |   1 -
 tests/virtio-scsi-test.c           |   6 +
 ui/cocoa.m                         |   2 +-
 util/Makefile.objs                 |   1 +
 util/main-loop.c                   |  15 +-
 util/qemu-timer.c                  |  12 ++
 util/rcu.c                         |  15 +-
 util/sys_membarrier.c              |  50 ++++++
 vl.c                               |   7 +-
 117 files changed, 1953 insertions(+), 729 deletions(-)
 create mode 100644 hw/char/parallel-isa.c
 create mode 100644 hw/isa/isa-superio.c
 create mode 100644 hw/isa/smc37c669-superio.c
 create mode 100644 include/hw/char/parallel.h
 rename include/hw/{isa => dma}/i8257.h (86%)
 create mode 100644 include/hw/input/i8042.h
 create mode 100644 include/hw/isa/superio.h
 create mode 100644 include/qemu/sys_membarrier.h
 create mode 100755 scripts/replay-dump.py
 create mode 100644 util/sys_membarrier.c
-- 
2.14.3
