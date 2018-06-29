Received: from eggs.gnu.org ([2001:4830:134:3::10]:34017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYrDw-00037H-7e
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYrDt-0005cl-1E
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:05:56 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:38696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYrDs-0005bz-Lm
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:05:52 -0400
Received: by mail-wm0-x241.google.com with SMTP id 69-v6so1626086wmf.3
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 04:05:52 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	s200-v6sm2598572wmb.44.2018.06.29.04.05.49
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 29 Jun 2018 04:05:49 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 29 Jun 2018 13:05:16 +0200
Message-Id: <1530270317-28612-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 00/60] Misc patches for soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 4a83bf2f339d4b63ecd5ef48b9816c3b7ee24553:

  Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20180627' into staging (2018-06-28 15:31:42 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 28a3cfc10b2e1a34985797357b4aa7558a63d08f:

  tests/boot-serial: Do not delete the output file in case of errors (2018-06-29 13:02:50 +0200)

----------------------------------------------------------------
* "info mtree" improvements (Alexey)
* fake VPD block limits for SCSI passthrough (Daniel Barboza)
* chardev and main loop fixes (Daniel Berrangé, Sergio, Stefan)
* help fixes (Eduardo)
* pc-dimm refactoring (David)
* tests improvements and fixes (Emilio, Thomas)
* SVM emulation fixes (Jan)
* MemoryRegionCache fix (Eric)
* WHPX improvements (Justin)
* ESP cleanup (Mark)
* -overcommit option (Michael)
* qemu-pr-helper fixes (me)
* "info pic" improvements for x86 (Peter)
* x86 TCG emulation fixes (Richard)
* KVM slot handling fix (Shannon)
* Next round of deprecation (Thomas)
* Windows dump format support (Viktor)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      memory/hmp: Print owners/parents in "info mtree"

Daniel Henrique Barboza (3):
      hw/scsi: cleanups before VPD BL emulation
      hw/scsi: centralize SG_IO calls into single function
      hw/scsi: add VPD Block Limits emulation

Daniel P. Berrangé (1):
      chardev: don't splatter terminal settings on exit if not previously set

David Hildenbrand (15):
      memory-device: turn alignment assert into check
      exec: check that alignment is a power of two
      pc-dimm: remove leftover "struct pc_dimms_capacity"
      pc: rename pc_dimm_(plug|unplug|...)* into pc_memory_(plug|unplug|...)*
      pc-dimm: rename pc_dimm_memory_* to pc_dimm_*
      pc-dimm: remove pc_dimm_get_free_slot() from header
      pc: factor out pc specific dimm checks into pc_memory_pre_plug()
      nvdimm: no need to overwrite get_vmstate_memory_region()
      hostmem: drop error variable from host_memory_backend_get_memory()
      pc-dimm: merge get_(vmstate_)memory_region()
      nvdimm: convert "unarmed" into a static property
      nvdimm: convert nvdimm_mr into a pointer
      nvdimm: make get_memory_region() perform checks and initialization
      pc-dimm: get_memory_region() will not fail after realize
      numa: report all DIMM/NVDIMMs as plugged memory

Eduardo Habkost (1):
      qemu-options: Add missing newline to -accel help text

Emilio G. Cota (1):
      tests/atomic_add-bench: add -m option to use mutexes

Eric Auger (1):
      exec: Fix MAP_RAM for cached access

Jan Kiszka (3):
      target-i386: Add NMI interception to SVM
      target-i386: Allow interrupt injection after STGI
      target-i386: Mark cpu_vmexit noreturn

Justin Terry (VM) (2):
      WHPX workaround bug in OSVW handling
      WHPX: register for unrecognized MSR exits

Mark Cave-Ayland (2):
      hw/mips/jazz: create ESP device directly via qdev
      esp: remove legacy esp_init() function

Michael S. Tsirkin (2):
      kvm: support -overcommit cpu-pm=on|off
      i386/cpu: make -cpu host support monitor/mwait

Paolo Bonzini (10):
      move public invalidate APIs out of translate-all.{c,h}, clean up
      whpx: commit missing file
      QemuMutex: support --enable-debug-mutex
      osdep: work around Coverity parsing errors
      pr-helper: fix --socket-path default in help
      pr-helper: fix assertion failure on failed multipath PERSISTENT RESERVE IN
      pr-manager-helper: avoid SIGSEGV when writing to the socket fail
      pr-manager: put stubs in .c file
      pr-manager: add query-pr-managers QMP command
      pr-manager-helper: report event on connection/disconnection

Peter Xu (7):
      qemu-thread: introduce qemu-thread-common.h
      configure: enable debug-mutex if debug enabled
      doc: another fix to "info pic"
      ioapic: support "info pic"
      ioapic: some proper indents when dump info
      ioapic: support "info irq"
      hmp: obsolete "info ioapic"

Richard Henderson (1):
      target/i386: Fix BLSR and BLSI

Sergio Lopez (1):
      hw/char/serial: Only retry if qemu_chr_fe_write returns 0

Shannon Zhao (1):
      kvm: Delete the slot if and only if the KVM_MEM_READONLY flag is changed

Stefan Hajnoczi (1):
      main-loop: document IOCanReadHandler

Thomas Huth (3):
      Replace '-enable-kvm' with '-accel kvm' in docs and help texts
      Deprecate the -enable-hax option
      tests/boot-serial: Do not delete the output file in case of errors

Viktor Prutyanov (4):
      dump: add Windows dump format to dump-guest-memory
      dump: use system context in Windows dump
      dump: add fallback KDBG using in Windows dump
      dump: add Windows live system dump

 Makefile.target                   |   1 +
 accel/kvm/kvm-all.c               |  17 +-
 accel/tcg/translate-all.c         |  28 +--
 accel/tcg/translate-all.h         |   1 -
 accel/tcg/user-exec-stub.c        |   3 +
 backends/hostmem.c                |   3 +-
 chardev/char-stdio.c              |   6 +-
 configure                         |  11 +
 docs/COLO-FT.txt                  |   8 +-
 docs/can.txt                      |   4 +-
 docs/multi-thread-compression.txt |   2 +-
 docs/multiseat.txt                |   2 +-
 docs/specs/tpm.txt                |   8 +-
 dump.c                            |  24 ++-
 exec.c                            |  39 +++-
 hmp-commands-info.hx              |   9 +-
 hmp-commands.hx                   |  13 +-
 hmp.c                             |   9 +-
 hw/block/dataplane/virtio-blk.c   |   4 +-
 hw/char/serial.c                  |   2 +-
 hw/i386/kvm/ioapic.c              |  11 +-
 hw/i386/pc.c                      |  73 +++----
 hw/intc/ioapic.c                  |  12 +-
 hw/intc/ioapic_common.c           |  47 ++++-
 hw/mem/memory-device.c            |   8 +-
 hw/mem/nvdimm.c                   |  93 +++++----
 hw/mem/pc-dimm.c                  |  35 ++--
 hw/mips/mips_jazz.c               |  19 +-
 hw/misc/ivshmem.c                 |   3 +-
 hw/ppc/spapr.c                    |  18 +-
 hw/scsi/esp.c                     |  30 ---
 hw/scsi/scsi-disk.c               | 427 +++++++++++++++++++-------------------
 hw/scsi/scsi-generic.c            | 246 ++++++++++++++++------
 hw/scsi/virtio-scsi-dataplane.c   |   4 +-
 include/exec/exec-all.h           |   8 +-
 include/exec/memory.h             |   2 +-
 include/exec/ram_addr.h           |   2 +
 include/hw/i386/ioapic_internal.h |   3 +
 include/hw/i386/pc.h              |   3 -
 include/hw/mem/nvdimm.h           |   2 +-
 include/hw/mem/pc-dimm.h          |  17 +-
 include/hw/scsi/esp.h             |   5 -
 include/hw/scsi/scsi.h            |   6 +-
 include/qemu/main-loop.h          |  14 ++
 include/qemu/osdep.h              |  15 ++
 include/qemu/thread-posix.h       |   4 +
 include/qemu/thread-win32.h       |   4 +
 include/scsi/pr-manager.h         |  11 +-
 include/sysemu/hostmem.h          |   3 +-
 include/sysemu/kvm_int.h          |   1 +
 include/sysemu/sysemu.h           |   1 +
 linux-user/mmap.c                 |   1 -
 memory.c                          |  72 ++++++-
 memory_ldst.inc.c                 |  47 ++---
 monitor.c                         |   4 +-
 numa.c                            |   9 +-
 qapi/block.json                   |  52 +++++
 qapi/misc.json                    |   5 +-
 qemu-doc.texi                     |   5 +
 qemu-options.hx                   |  28 ++-
 scsi/Makefile.objs                |   1 +
 scsi/pr-manager-helper.c          |  28 +++
 scsi/pr-manager-stub.c            |  30 +++
 scsi/pr-manager.c                 |  45 ++++
 scsi/qemu-pr-helper.c             |  21 +-
 target/i386/cpu.c                 |  32 ++-
 target/i386/cpu.h                 |  13 +-
 target/i386/kvm.c                 |  32 +++
 target/i386/monitor.c             |   8 +-
 target/i386/seg_helper.c          |   1 +
 target/i386/svm_helper.c          |   1 +
 target/i386/translate.c           |  29 +--
 target/i386/whp-dispatch.h        |  56 +++++
 target/i386/whpx-all.c            |  54 ++++-
 target/xtensa/op_helper.c         |   9 +-
 tests/atomic_add-bench.c          |  19 +-
 tests/boot-serial-test.c          |  17 +-
 trace/control-target.c            |   1 -
 util/qemu-thread-common.h         |  55 +++++
 util/qemu-thread-posix.c          |  19 +-
 util/qemu-thread-win32.c          |  17 +-
 vl.c                              |  33 ++-
 win_dump.c                        | 385 ++++++++++++++++++++++++++++++++++
 win_dump.h                        | 176 ++++++++++++++++
 84 files changed, 1934 insertions(+), 692 deletions(-)
 create mode 100644 scsi/pr-manager-stub.c
 create mode 100644 target/i386/whp-dispatch.h
 create mode 100644 util/qemu-thread-common.h
 create mode 100644 win_dump.c
 create mode 100644 win_dump.h
-- 
1.8.3.1
