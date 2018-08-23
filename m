Received: from eggs.gnu.org ([2001:4830:134:3::10]:36176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fssmD-0002hY-HQ
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fssm9-0007HD-5B
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:48:05 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fssm8-0007GX-R5
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:48:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id 20-v6so5172290wrb.12
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:48:00 -0700 (PDT)
Received: from donizetti.redhat.com
	(dynamic-adsl-78-12-184-244.clienti.tiscali.it. [78.12.184.244])
	by smtp.gmail.com with ESMTPSA id
	s205-v6sm6183362wmf.42.2018.08.23.09.47.57
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 Aug 2018 09:47:58 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Aug 2018 18:47:55 +0200
Message-Id: <20180823164756.16948-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v4 00/69] Misc patches for 2018-08-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 659b11e7a7239529cfdb4968418268ff9aa22d88:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-pull-request' into staging (2018-08-21 11:36:15 +0100)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to b2e78fac6f27c36938353e477354778896adc08f:

  KVM: cleanup unnecessary #ifdef KVM_CAP_... (2018-08-23 18:46:25 +0200)

----------------------------------------------------------------
* x86 TCG fixes for 64-bit call gates (Andrew)
* qumu-guest-agent freeze-hook tweak (Christian)
* pm_smbus improvements (Corey)
* Move validation to pre_plug for pc-dimm (David)
* Fix memory leaks (Eduardo, Marc-André)
* synchronization profiler (Emilio)
* Convert the CPU list to RCU (Emilio)
* LSI support for PPR Extended Message (George)
* vhost-scsi support for protection information (Greg)
* Mark mptsas as a storage device in the help (Guenter)
* checkpatch tweak cherry-picked from Linux (me)
* Typos, cleanups and dead-code removal (Julia, Marc-André)
* qemu-pr-helper support for old libmultipath (Murilo)
* Annotate fallthroughs (me)
* MemoryRegionOps cleanup (me, Peter)
* Make s390 qtests independent from libqos, which doesn't actually support it (me)
* Make cpu_get_ticks independent from BQL (me)
* Introspection fixes (Thomas)
* Support QEMU_MODULE_DIR environment variable (ryang)

----------------------------------------------------------------
Andrew Oates (2):
      target-i386: Fix lcall/ljmp to call gate in IA-32e mode
      target-i386: fix segment limit check in ljmp

Christian Ehrhardt (1):
      qemu-guest-agent: freeze-hook to ignore dpkg files as well

Corey Minyard (8):
      ipmi: Use proper struct reference for BT vmstate
      i2c: pm_smbus: Clean up some style issues
      i2c: pm_smbus: Fix the semantics of block I2C transfers
      i2c: pm_smbus: Make the I2C block read command read-only
      i2c: pm_smbus: Add block transfer capability
      i2c: pm_smbus: Add interrupt handling
      i2c: pm_smbus: Don't delay host status register busy bit when interrupts are enabled
      i2c: pm_smbus: Add the ability to force block transfer enable

David Hildenbrand (4):
      pc-dimm: assign and verify the "slot" property during pre_plug
      util/oslib-win32: indicate alignment for qemu_anon_ram_alloc()
      pc: drop memory region alignment check for 0
      pc-dimm: assign and verify the "addr" property during pre_plug

Eduardo Habkost (1):
      i386: Fix arch_query_cpu_model_expansion() leak

Emilio G. Cota (20):
      seqlock: constify seqlock_read_begin
      qsp: QEMU's Synchronization Profiler
      qsp: add sort_by option to qsp_report
      qsp: add qsp_reset
      qsp: support call site coalescing
      qsp: track BQL callers explicitly
      tests/atomic_add-bench: add -p to enable sync profiler
      vl: add -enable-sync-profile
      hmp-commands: add sync-profile
      hmp-commands-info: add sync-profile
      rcu_queue: use atomic_set in QLIST_REMOVE_RCU
      rcu_queue: remove barrier from QLIST_EMPTY_RCU
      rcu_queue: add RCU QSIMPLEQ
      rcu_queue: add RCU QTAILQ
      test-rcu-list: access goflag with atomics
      test-rcu-list: abstract the list implementation
      tests: add test-list-simpleq
      tests: add test-rcu-tailq
      spapr: do not use CPU_FOREACH_REVERSE
      qom: convert the CPU list to RCU

George Kennedy (1):
      lsi_scsi: add support for PPR Extended Message

Greg Edwards (3):
      vhost-user-scsi: move host_features into VHostSCSICommon
      vhost-scsi: unify vhost-scsi get_features implementations
      vhost-scsi: expose 't10_pi' property for VIRTIO_SCSI_F_T10_PI

Guenter Roeck (1):
      scsi: mptsas: Mark as storage device

Heinrich Schuchardt (1):
      checkpatch: allow space in more places before a bracket

Julia Suvorova (1):
      chardev/char-fe: Fix typos

Marc-André Lureau (4):
      megasas: fix sglist leak
      update-linux-headers.sh: add qemu_fw_cfg.h
      fw_cfg: import & use linux/qemu_fw_cfg.h
      build-sys: remove glib_subprocess check

Murilo Opsfelder Araujo (1):
      qemu-pr-helper: Fix build on CentOS 7

Paolo Bonzini (11):
      tests: virtio: separate ccw tests from libqos
      es1370: simplify MemoryRegionOps
      fix "Missing break in switch" coverity reports
      checkpatch: fix filename detection when using -f
      MAINTAINERS: add maintainers for qtest
      cpus: protect all icount computation with seqlock
      seqlock: add QemuLockable support
      cpus: protect TimerState writes with a spinlock
      cpus: allow cpu_get_ticks out of BQL
      target/i386: update MPX flags when CPL changes
      KVM: cleanup unnecessary #ifdef KVM_CAP_...

Peter Maydell (1):
      hw/intc/apic: Switch away from old_mmio

Prasad Singamsetty (1):
      kvm: add call to qemu_add_opts() for -overcommit option

Thomas Huth (7):
      tests/migration-test: Silence the kvm_hv message by default
      net: Silence 'has no peer' messages in testing mode
      hw/timer/mc146818rtc: White space clean-up
      hw/timer/mc146818rtc: Fix introspection problem
      tests: Skip old versioned machine types in quick testing mode
      tests/device-introspection: Check that the qom-tree and qtree do not change
      tests/device-introspect: Test with all machines, not only with "none"

ryang (1):
      module: Use QEMU_MODULE_DIR as a search path

 MAINTAINERS                                  |  11 +-
 accel/kvm/kvm-all.c                          |   2 -
 configure                                    |  27 +-
 cpus-common.c                                |   4 +-
 cpus.c                                       | 186 +++---
 disas/m68k.c                                 |   1 +
 dump.c                                       |   2 +-
 hmp-commands-info.hx                         |  22 +
 hmp-commands.hx                              |  15 +
 hmp.c                                        |  24 +
 hmp.h                                        |   1 +
 hw/acpi/piix4.c                              |   2 +-
 hw/arm/pxa2xx.c                              |   2 +-
 hw/audio/cs4231a.c                           |   1 +
 hw/audio/es1370.c                            | 235 +-------
 hw/audio/gusemu_hal.c                        |   1 +
 hw/audio/sb16.c                              |  11 +-
 hw/display/cg3.c                             |   1 +
 hw/display/cirrus_vga.c                      |   3 +-
 hw/i2c/pm_smbus.c                            | 254 ++++++--
 hw/i2c/smbus.c                               |  37 +-
 hw/i2c/smbus_ich9.c                          |  26 +-
 hw/i386/pc.c                                 |  16 +-
 hw/intc/apic.c                               |  42 +-
 hw/ipmi/isa_ipmi_bt.c                        |  68 ++-
 hw/isa/vt82c686.c                            |   2 +-
 hw/mem/pc-dimm.c                             |  61 +-
 hw/misc/vmcoreinfo.c                         |   6 +-
 hw/ppc/prep.c                                |   3 +
 hw/ppc/spapr.c                               |  30 +-
 hw/scsi/lsi53c895a.c                         |   4 +
 hw/scsi/megasas.c                            |   2 +-
 hw/scsi/mptsas.c                             |   1 +
 hw/scsi/vhost-scsi-common.c                  |   3 +
 hw/scsi/vhost-scsi.c                         |   3 +
 hw/scsi/vhost-user-scsi.c                    |  28 +-
 hw/timer/mc146818rtc.c                       |  20 +-
 hw/timer/sh_timer.c                          |   1 +
 include/chardev/char-fe.h                    |  10 +-
 include/hw/i2c/pm_smbus.h                    |  24 +-
 include/hw/i2c/smbus.h                       |  17 +-
 include/hw/mem/pc-dimm.h                     |   5 +-
 include/hw/misc/vmcoreinfo.h                 |  12 +-
 include/hw/nvram/fw_cfg.h                    |  18 +-
 include/hw/nvram/fw_cfg_keys.h               |  45 --
 include/hw/virtio/vhost-scsi-common.h        |   1 +
 include/hw/virtio/vhost-user-scsi.h          |   1 -
 include/qemu/main-loop.h                     |   4 +-
 include/qemu/qht.h                           |   1 +
 include/qemu/qsp.h                           |  29 +
 include/qemu/rcu_queue.h                     | 135 ++++-
 include/qemu/seqlock.h                       |  22 +-
 include/qemu/thread-posix.h                  |   4 +-
 include/qemu/thread-win32.h                  |   5 +-
 include/qemu/thread.h                        |  66 ++-
 include/qom/cpu.h                            |  11 +-
 include/standard-headers/linux/qemu_fw_cfg.h |  97 ++++
 linux-user/main.c                            |   2 +-
 linux-user/syscall.c                         |   2 +-
 monitor.c                                    |  11 +
 pc-bios/optionrom/linuxboot_dma.c            |   4 +-
 pc-bios/optionrom/optionrom.h                |  15 +-
 qemu-options.hx                              |  10 +
 scripts/checkpatch.pl                        |   7 +-
 scripts/qemu-guest-agent/fsfreeze-hook       |   2 +-
 scripts/update-linux-headers.sh              |   4 +-
 scsi/qemu-pr-helper.c                        |   4 +
 stubs/iothread-lock.c                        |   2 +-
 target/arm/helper.c                          |   1 +
 target/i386/cpu.c                            |   9 +-
 target/i386/cpu.h                            |   7 +-
 target/i386/kvm.c                            |   8 -
 target/i386/seg_helper.c                     | 196 +++++--
 target/i386/translate.c                      |   2 +
 target/s390x/cpu_models.c                    |   2 +-
 tests/Makefile.include                       |  15 +-
 tests/atomic_add-bench.c                     |   6 +-
 tests/boot-order-test.c                      |   2 +-
 tests/cpu-plug-test.c                        |   6 +-
 tests/device-introspect-test.c               |  55 +-
 tests/fw_cfg-test.c                          |   2 +-
 tests/libqos/malloc-pc.c                     |   2 +-
 tests/libqtest.c                             |  52 +-
 tests/libqtest.h                             |   4 +-
 tests/migration-test.c                       |  20 +-
 tests/qom-test.c                             |   2 +-
 tests/test-char.c                            |   4 -
 tests/test-hmp.c                             |   2 +-
 tests/test-rcu-list.c                        |  92 ++-
 tests/test-rcu-simpleq.c                     |   2 +
 tests/test-rcu-tailq.c                       |   2 +
 tests/test-x86-cpuid-compat.c                |   6 -
 tests/vhost-user-test.c                      |   4 -
 tests/virtio-ccw-test.c                      | 110 ++++
 util/Makefile.objs                           |   1 +
 util/module.c                                |  22 +-
 util/oslib-win32.c                           |  15 +-
 util/qemu-thread-win32.c                     |   4 +-
 util/qht.c                                   |  47 +-
 util/qsp.c                                   | 828 +++++++++++++++++++++++++++
 vl.c                                         |   7 +-
 101 files changed, 2529 insertions(+), 736 deletions(-)
 delete mode 100644 include/hw/nvram/fw_cfg_keys.h
 create mode 100644 include/qemu/qsp.h
 create mode 100644 include/standard-headers/linux/qemu_fw_cfg.h
 create mode 100644 tests/test-rcu-simpleq.c
 create mode 100644 tests/test-rcu-tailq.c
 create mode 100644 tests/virtio-ccw-test.c
 create mode 100644 util/qsp.c
-- 
2.17.1
