Received: from eggs.gnu.org ([2001:4830:134:3::10]:33462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZyNf-0004uV-LK
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:24:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZyNe-00008M-3g
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:24:19 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZyNd-000071-QK
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:24:18 -0500
Received: by mail-wr0-x243.google.com with SMTP id z48so5150514wrz.6
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 04:24:17 -0800 (PST)
Received: from 640k.lan (dynamic-adsl-78-12-229-84.clienti.tiscali.it.
	[78.12.229.84]) by smtp.gmail.com with ESMTPSA id
	w195sm1740188wmw.46.2018.01.12.04.24.15 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Jan 2018 04:24:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 13:24:12 +0100
Message-Id: <1515759853-20360-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/52] Misc patches for 2017-01-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 997eba28a3ed5400a80f754bf3a1c8044b75b9ff:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180111' into staging (2018-01-11 14:34:41 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to a88ae3be7bf0550adf877f5422c837dbf4bf4a39:

  scripts/analyse-locks-simpletrace.py: script to analyse lock times (2018-01-12 13:22:05 +0100)

----------------------------------------------------------------
* QemuMutex tracing improvements (Alex)
* ram_addr_t optimization (David)
* SCSI fixes (Fam, Stefan, me)
* do {} while (0) fixes (Eric)
* KVM fix for PMU (Jan)
* memory leak fixes from ASAN (Marc-André)
* migration fix for HPET, icount, loadvm (Maria, Pavel)
* hflags fixes (me, Tao)
* block/iscsi uninitialized variable (Peter L.)
* full support for GMainContexts in character devices (Peter Xu)
* more boot-serial-test (Thomas)
* Memory leak fix (Zhecheng)

----------------------------------------------------------------
Alex Bennée (4):
      scripts/qemu-gdb: add simple tcg lock status helper
      scripts/qemu-gdb/timers.py: new helper to dump timer state
      util/qemu-thread-*: add qemu_lock, locked and unlock trace events
      scripts/analyse-locks-simpletrace.py: script to analyse lock times

Dr. David Alan Gilbert (2):
      find_ram_offset: Add comments and tracing
      find_ram_offset: Align ram_addr_t allocation on long boundaries

Eric Blake (7):
      net: Drop unusual use of do { } while (0);
      mips: Tweak location of ';' in macros
      chardev: Use goto/label instead of do/break/while(0)
      chardev: Clean up previous patch indentation
      tests: Avoid 'do/while(false); ' in vhost-user-bridge
      maint: Fix macros with broken 'do/while(0); ' usage
      checkpatch: Enforce proper do/while (0) style

Fam Zheng (1):
      scsi-generic: Add share-rw option

Haozhong Zhang (1):
      pc: fail memory hot-plug/unplug with -no-acpi and Q35 machine type

Jan Dakinevich (1):
      i386/cpu/kvm: look at PMU's CPUID before setting MSRs

Marc-André Lureau (18):
      build-sys: fix qemu-ga -pthread linking
      build-sys: silence make by default or V=0
      build-sys: add a rule to print a variable
      build-sys: compile with -Og or -O1 when --enable-debug
      tests/docker: add some sanitizers to fedora dockerfile
      tests/docker: add test-debug
      build-sys: add some sanitizers when --enable-debug if possible
      tests: fix check-qobject leak
      vl: fix direct firmware directories leak
      readline: add a free function
      tests: fix migration-test leak
      crypto: fix stack-buffer-overflow error
      qemu-config: fix leak in query-command-line-options
      tests: fix qmp-test leak
      ucontext: annotate coroutine stack for ASAN
      tests: fix coroutine leak in /basic/entered
      mips: fix potential fopen(NULL,...)
      disas/s390: fix global-buffer-overflow

Paolo Bonzini (3):
      scsi: fix scsi_convert_sense crash when in_buf == NULL && in_len == 0
      target-i386: update hflags on Hypervisor.framework
      cpus: unify qemu_*_wait_io_event

Pavel Dovgalyuk (3):
      hpet: recover timer offset correctly
      icount: fixed saving/restoring of icount warp timers
      cpu: flush TB cache when loading VMState

Peter Lieven (1):
      block/iscsi: fix initialization of iTask in iscsi_co_get_block_status

Peter Xu (3):
      chardev: use backend chr context when watch for fe
      chardev: let g_idle_add() be with chardev gcontext
      chardev: introduce qemu_chr_timeout_add_ms()

Stefan Hajnoczi (1):
      scsi-disk: release AioContext in unaligned WRITE SAME case

Tao Wu (3):
      target/i386: move hflags update code to a function
      target/i386: hax: change to use x86_update_hflags
      target/i386: hax: Move x86_update_hflags.

Thomas Huth (3):
      tests/boot-serial-test: Add tests for microblaze boards
      tests/boot-serial-test: Add a test for the moxiesim machine
      tests/boot-serial-test: Add support for the raspi2 machine

linzhecheng (1):
      irq: fix memory leak

 .travis.yml                            |   3 +-
 Makefile                               |   7 +-
 audio/paaudio.c                        |   4 +-
 block/iscsi.c                          |   3 +-
 chardev/char-fe.c                      |   2 +-
 chardev/char-pty.c                     |  64 ++++++++--------
 chardev/char-serial.c                  |  75 +++++++++---------
 chardev/char-socket.c                  |  28 ++++---
 chardev/char.c                         |  18 +++++
 configure                              |  38 +++++++++-
 cpus.c                                 | 134 ++++++++++++++++++++-------------
 crypto/ivgen-essiv.c                   |   2 +-
 disas/s390.c                           |  16 ++--
 docs/devel/build-system.txt            |  13 ++++
 exec.c                                 |  40 ++++++++--
 hw/adc/stm32f2xx_adc.c                 |   2 +-
 hw/block/m25p80.c                      |   2 +-
 hw/char/cadence_uart.c                 |   2 +-
 hw/char/stm32f2xx_usart.c              |   2 +-
 hw/char/terminal3270.c                 |  28 ++++---
 hw/display/cg3.c                       |   2 +-
 hw/display/dpcd.c                      |   2 +-
 hw/display/xlnx_dp.c                   |   2 +-
 hw/dma/pl330.c                         |   2 +-
 hw/dma/xlnx-zynq-devcfg.c              |   2 +-
 hw/dma/xlnx_dpdma.c                    |   2 +-
 hw/i2c/i2c-ddc.c                       |   2 +-
 hw/i386/pc.c                           |  18 ++++-
 hw/misc/auxbus.c                       |   2 +-
 hw/misc/macio/mac_dbdma.c              |   4 +-
 hw/misc/mmio_interface.c               |   2 +-
 hw/misc/stm32f2xx_syscfg.c             |   2 +-
 hw/misc/zynq_slcr.c                    |   2 +-
 hw/net/cadence_gem.c                   |   2 +-
 hw/net/pcnet.c                         |  20 ++---
 hw/nvram/ds1225y.c                     |   4 +-
 hw/scsi/scsi-disk.c                    |   1 +
 hw/scsi/scsi-generic.c                 |   9 +++
 hw/ssi/mss-spi.c                       |   2 +-
 hw/ssi/stm32f2xx_spi.c                 |   2 +-
 hw/ssi/xilinx_spi.c                    |   2 +-
 hw/ssi/xilinx_spips.c                  |   2 +-
 hw/timer/a9gtimer.c                    |   2 +-
 hw/timer/cadence_ttc.c                 |   2 +-
 hw/timer/hpet.c                        |  30 +++++++-
 hw/timer/mss-timer.c                   |   2 +-
 hw/timer/stm32f2xx_timer.c             |   2 +-
 hw/tpm/tpm_passthrough.c               |   2 +-
 hw/tpm/tpm_tis.c                       |   2 +-
 include/chardev/char.h                 |   3 +
 include/hw/compat.h                    |   6 +-
 include/qemu/compiler.h                |   4 +
 include/qemu/readline.h                |   1 +
 include/qemu/thread.h                  |  39 +++++++++-
 migration/rdma.c                       |   2 +-
 monitor.c                              |   2 +-
 rules.mak                              |   2 +
 scripts/analyse-locks-simpletrace.py   |  99 ++++++++++++++++++++++++
 scripts/checkpatch.pl                  |   5 ++
 scripts/qemu-gdb.py                    |   4 +-
 scripts/qemugdb/tcg.py                 |  46 +++++++++++
 scripts/qemugdb/timers.py              |  54 +++++++++++++
 scsi/utils.c                           |  12 +--
 target/arm/translate-a64.c             |   2 +-
 target/i386/cpu.c                      |  42 +++++++++++
 target/i386/cpu.h                      |   2 +
 target/i386/hax-all.c                  |  54 +------------
 target/i386/hvf/x86hvf.c               |   2 +-
 target/i386/kvm.c                      | 121 ++++++++++++-----------------
 target/mips/msa_helper.c               |  34 +++++----
 target/s390x/kvm.c                     |   2 +-
 tests/Makefile.include                 |   5 ++
 tests/acpi-utils.h                     |   8 +-
 tests/boot-serial-test.c               |  37 +++++++++
 tests/check-qobject.c                  |   2 +
 tests/docker/dockerfiles/fedora.docker |   4 +-
 tests/docker/test-clang                |   2 +-
 tests/docker/test-debug                |  26 +++++++
 tests/docker/test-mingw                |   2 -
 tests/migration-test.c                 |   3 +-
 tests/qmp-test.c                       |   3 +-
 tests/tcg/test-mmap.c                  |   2 +-
 tests/test-coroutine.c                 |   1 -
 tests/vhost-user-bridge.c              |   6 +-
 trace-events                           |   4 +
 ui/sdl_zoom_template.h                 |   8 +-
 util/coroutine-ucontext.c              |  48 ++++++++++++
 util/qemu-config.c                     |   3 +-
 util/qemu-thread-posix.c               |  21 +++---
 util/qemu-thread-win32.c               |  20 ++---
 util/readline.c                        |  18 ++++-
 util/trace-events                      |   7 +-
 vl.c                                   |   9 ++-
 93 files changed, 975 insertions(+), 415 deletions(-)
 create mode 100755 scripts/analyse-locks-simpletrace.py
 create mode 100644 scripts/qemugdb/tcg.py
 create mode 100644 scripts/qemugdb/timers.py
 create mode 100755 tests/docker/test-debug
-- 
1.8.3.1
