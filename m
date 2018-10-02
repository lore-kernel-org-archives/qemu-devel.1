Received: from eggs.gnu.org ([2001:4830:134:3::10]:46988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1g7ONr-0006fb-KC
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 13:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1g7ONo-0006IF-Bq
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 13:22:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:52663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1g7ONo-0006I2-2H
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 13:22:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id 189-v6so3077479wmw.2
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 10:22:51 -0700 (PDT)
Received: from 640k.lan (94-36-187-248.adsl-ull.clienti.tiscali.it.
	[94.36.187.248]) by smtp.gmail.com with ESMTPSA id
	t2-v6sm16987812wre.96.2018.10.02.10.22.49 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 02 Oct 2018 10:22:49 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  2 Oct 2018 19:22:44 +0200
Message-Id: <1538500966-5506-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v4 00/80] Misc patches for 2018-09-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 3892f1f1a963e59dfe012cd9d461d33b2986fa3b:

  Merge remote-tracking branch 'remotes/dgibson/tags/libfdt-20181002' into staging (2018-10-02 09:54:44 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 97866508669c4a75f531bfa94f8267900fcbb5dc:

  hw/scsi/mptendian: Avoid taking address of fields in packed structs (2018-10-02 19:09:14 +0200)

----------------------------------------------------------------
* configure fix for environment variables (Daniel)
* fix memory leaks (Alex)
* x86_64 MTTCG fixes (Emilio)
* introduce atomic64 (Emilio)
* Fix for virtio hang (Fam, myself)
* SH serial port fix (Geert)
* Deprecate rotation_rate for scsi-block (Fam)
* Extend memory-backend-file availability to all POSIX hosts (Hikaru)
* Memory API cleanups and fixes (Igor, Li Qiang, Peter, Philippe)
* MSI/IOMMU fix (Jan)
* Socket reconnection fixes (Marc-André)
* icount fixes (Emilio, myself)
* QSP fixes for Coverity (myself)
* Some record/replay improovements (Pavel)
* Packed struct fixes (Peter)
* Windows dump fixes and elf2dmp (Viktor)
* kbmclock fix (Yongji)

----------------------------------------------------------------
Alex Bennée (1):
      cpus: fix TCG kick timer leak

Daniel P. Berrangé (1):
      configure: preserve various environment variables in config.status

Emilio G. Cota (22):
      atomic: fix comment s/x64_64/x86_64/
      cpus: initialize timers_state.vm_clock_lock
      cacheinfo: add i/d cache_linesize_log
      util: add atomic64
      tests: add atomic64-bench
      qsp: use atomic64 accessors
      test-rcu-list: access n_reclaims and n_nodes_removed with atomic64
      cpus: access .qemu_icount with atomic64
      cpus: access .qemu_icount_bias with atomic64
      target/i386: move cpu_cc_srcT to DisasContext
      target/i386: move cpu_A0 to DisasContext
      target/i386: move cpu_T0 to DisasContext
      target/i386: move cpu_T1 to DisasContext
      target/i386: move cpu_tmp0 to DisasContext
      target/i386: move cpu_tmp4 to DisasContext
      target/i386: move cpu_ptr0 to DisasContext
      target/i386: move cpu_ptr1 to DisasContext
      target/i386: move cpu_tmp2_i32 to DisasContext
      target/i386: move cpu_tmp3_i32 to DisasContext
      target/i386: move cpu_tmp1_i64 to DisasContext
      target/i386: move x86_64_hregs to DisasContext
      configure: enable mttcg for i386 and x86_64

Fam Zheng (2):
      virtio: Return true from virtio_queue_empty if broken
      scsi-block: Deprecate rotation_rate

Geert Uytterhoeven (1):
      hw/char/sh_serial: Add timeout handling to unbreak serial input

Hikaru Nishida (1):
      hostmem-file: make available memory-backend-file on POSIX-based hosts

Igor Mammedov (1):
      memory: cleanup side effects of memory_region_init_foo() on failure

Jan Kiszka (1):
      kvm: x86: Fix kvm_arch_fixup_msi_route for remap-less case

Li Qiang (5):
      fw_cfg_mem: add read memory region callback
      hw: debugexit: add read callback
      hw: pc-testdev: add read memory region callback
      hw: hyperv_testdev: add read callback
      hw: edu: replace device name with macro

Li Zhijian (1):
      change get_image_size return type to int64_t

Liran Alon (1):
      i386: Compile CPUX86State xsave_buf only when support KVM or HVF

Marc-André Lureau (10):
      hostmem-memfd: add checks before adding hostmem-memfd & properties
      util: add qemu_write_pidfile()
      util: use fcntl() for qemu_write_pidfile() locking
      Delete PID file on exit
      Revert "chardev: tcp: postpone TLS work until machine done"
      Revert "chardev: tcp: postpone async connection setup"
      char-socket: update all ioc handlers when changing context
      test-char: fix random socket test failure
      test-char: add socket reconnect test
      qom/object: add some interface asserts

Mark Cave-Ayland (1):
      lsi53c895a: convert to trace-events

Paolo Bonzini (9):
      qsp: hide indirect function calls from Coverity
      es1370: fix ADC_FRAMEADR and ADC_FRAMECNT
      cpus: take seqlock across qemu_icount updates
      serial: fix DLL writes
      char-pty: remove unnecessary #ifdef
      target/i386: unify masking of interrupts
      target/i386: rename HF_SVMI_MASK to HF_GUEST_MASK
      hvf: drop unused variable
      virtio: do not take address of packed members

Pavel Dovgalyuk (10):
      ps2: prevent changing irq state on save and load
      replay: wake up vCPU when replaying
      replay: flush events when exiting
      translator: fix breakpoint processing
      replay: allow loading any snapshots before recording
      timer: introduce new virtual clock
      slirp: fix ipv6 timers
      ui: fix virtual timers
      target/i386: fix translation for icount mode
      replay: replay BH for IDE trim operation

Peter Maydell (4):
      memory: Remove old_mmio accessors
      hw/nvram/fw_cfg: Use memberwise copy of MemoryRegionOps struct
      docs/devel/memory.txt: Document _with_attrs accessors
      hw/scsi/mptendian: Avoid taking address of fields in packed structs

Philippe Mathieu-Daudé (3):
      memory: Use MAKE_64BIT_MASK()
      memory: Refactor common shifting code from accessors
      memory: Fix access_with_adjusted_size(small size) on big-endian memory regions

Thomas Huth (1):
      accel/tcg: Remove dead code

Viktor Prutyanov (4):
      dump: fix Windows dump memory run mapping
      dump: move Windows dump structures definitions
      contrib: add elf2dmp tool
      MAINTAINERS: add myself as elf2dmp maintainer

Yongji Xie (1):
      kvmclock: run KVM_KVMCLOCK_CTRL ioctl in vcpu thread

 MAINTAINERS                   |    5 +
 Makefile                      |    5 +
 Makefile.objs                 |    1 +
 accel/tcg/translate-all.c     |    9 -
 accel/tcg/translator.c        |    8 +-
 backends/Makefile.objs        |    2 +-
 backends/hostmem-file.c       |    2 +-
 backends/hostmem-memfd.c      |   32 +-
 chardev/char-pty.c            |    6 -
 chardev/char-socket.c         |   86 +-
 configure                     |   45 +
 contrib/elf2dmp/Makefile.objs |    1 +
 contrib/elf2dmp/addrspace.c   |  233 ++++
 contrib/elf2dmp/addrspace.h   |   44 +
 contrib/elf2dmp/download.c    |   47 +
 contrib/elf2dmp/download.h    |   13 +
 contrib/elf2dmp/err.h         |   13 +
 contrib/elf2dmp/kdbg.h        |  194 ++++
 contrib/elf2dmp/main.c        |  589 ++++++++++
 contrib/elf2dmp/pdb.c         |  322 ++++++
 contrib/elf2dmp/pdb.h         |  241 ++++
 contrib/elf2dmp/pe.h          |  121 ++
 contrib/elf2dmp/qemu_elf.c    |  164 +++
 contrib/elf2dmp/qemu_elf.h    |   51 +
 cpus.c                        |   84 +-
 docs/devel/memory.txt         |   13 +-
 exec.c                        |    4 +-
 hw/alpha/dp264.c              |    3 +-
 hw/audio/es1370.c             |   10 +-
 hw/char/serial.c              |    4 +-
 hw/char/sh_serial.c           |   20 +
 hw/char/virtio-serial-bus.c   |    6 +-
 hw/core/loader.c              |    5 +-
 hw/hppa/machine.c             |    2 +-
 hw/i386/kvm/clock.c           |   17 +-
 hw/i386/pc.c                  |    7 +-
 hw/ide/core.c                 |    3 +-
 hw/input/ps2.c                |    8 +-
 hw/mips/mips_fulong2e.c       |    6 +-
 hw/mips/mips_malta.c          |    6 +-
 hw/mips/mips_mipssim.c        |    3 +-
 hw/mips/mips_r4k.c            |    6 +-
 hw/misc/debugexit.c           |    6 +
 hw/misc/edu.c                 |    5 +-
 hw/misc/hyperv_testdev.c      |   10 +-
 hw/misc/pc-testdev.c          |   20 +-
 hw/moxie/moxiesim.c           |    2 +-
 hw/nvram/fw_cfg.c             |   13 +-
 hw/scsi/lsi53c895a.c          |  214 ++--
 hw/scsi/mptendian.c           |  163 +--
 hw/scsi/scsi-disk.c           |    6 +
 hw/scsi/trace-events          |   62 ++
 hw/virtio/virtio.c            |    8 +
 include/exec/memory.h         |    7 +-
 include/hw/loader.h           |    2 +-
 include/qemu/atomic.h         |   36 +-
 include/qemu/memfd.h          |   18 +-
 include/qemu/osdep.h          |    5 +-
 include/qemu/thread.h         |   17 +
 include/qemu/timer.h          |    9 +
 include/qemu/win_dump_defs.h  |  179 +++
 include/sysemu/replay.h       |    3 +
 memory.c                      |  163 +--
 os-posix.c                    |   24 -
 os-win32.c                    |   25 -
 qga/main.c                    |   54 +-
 qom/object.c                  |    9 +-
 replay/replay-events.c        |   14 +-
 replay/replay-internal.h      |    2 -
 replay/replay-snapshot.c      |   17 +-
 replay/replay.c               |   12 +
 scsi/qemu-pr-helper.c         |   40 +-
 slirp/ip6_icmp.c              |    7 +-
 target/i386/cpu.c             |   51 +-
 target/i386/cpu.h             |    9 +-
 target/i386/excp_helper.c     |    2 +-
 target/i386/hvf/README.md     |    2 +-
 target/i386/hvf/hvf.c         |    3 +-
 target/i386/hvf/x86hvf.c      |    4 +-
 target/i386/kvm.c             |   10 +-
 target/i386/seg_helper.c      |  112 +-
 target/i386/svm_helper.c      |    6 +-
 target/i386/translate.c       | 2474 +++++++++++++++++++++--------------------
 tests/Makefile.include        |    3 +-
 tests/atomic64-bench.c        |  171 +++
 tests/test-char.c             |   25 +-
 tests/test-rcu-list.c         |   20 +-
 tests/vhost-user-test.c       |    6 +-
 ui/input.c                    |    8 +-
 util/Makefile.objs            |    1 +
 util/atomic64.c               |   83 ++
 util/cacheinfo.c              |   11 +
 util/memfd.c                  |   35 +-
 util/oslib-posix.c            |   73 ++
 util/oslib-win32.c            |   27 +
 util/qemu-timer.c             |    2 +
 util/qsp.c                    |   49 +-
 vl.c                          |   25 +-
 win_dump.c                    |   40 +-
 win_dump.h                    |  166 +--
 100 files changed, 4824 insertions(+), 2187 deletions(-)
 create mode 100644 contrib/elf2dmp/Makefile.objs
 create mode 100644 contrib/elf2dmp/addrspace.c
 create mode 100644 contrib/elf2dmp/addrspace.h
 create mode 100644 contrib/elf2dmp/download.c
 create mode 100644 contrib/elf2dmp/download.h
 create mode 100644 contrib/elf2dmp/err.h
 create mode 100644 contrib/elf2dmp/kdbg.h
 create mode 100644 contrib/elf2dmp/main.c
 create mode 100644 contrib/elf2dmp/pdb.c
 create mode 100644 contrib/elf2dmp/pdb.h
 create mode 100644 contrib/elf2dmp/pe.h
 create mode 100644 contrib/elf2dmp/qemu_elf.c
 create mode 100644 contrib/elf2dmp/qemu_elf.h
 create mode 100644 include/qemu/win_dump_defs.h
 create mode 100644 tests/atomic64-bench.c
 create mode 100644 util/atomic64.c
-- 
1.8.3.1
