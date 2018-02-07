Received: from eggs.gnu.org ([2001:4830:134:3::10]:41539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ejRbB-0001pc-2R
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:25:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ejRb7-00046o-HL
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:25:25 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:53516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ejRb7-00045y-65
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:25:21 -0500
Received: by mail-wm0-x22a.google.com with SMTP id t74so3871588wme.3
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 07:25:20 -0800 (PST)
Received: from 640k.lan ([82.84.122.246]) by smtp.gmail.com with ESMTPSA id
	g64sm1657094wmf.20.2018.02.07.07.25.17 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 07 Feb 2018 07:25:18 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  7 Feb 2018 16:25:14 +0100
Message-Id: <1518017115-43611-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/47] Misc patches for 2018-02-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit f24ee107a07f093bd7ed475dd48d7ba57ea3d8fe:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180202-pull-request' into staging (2018-02-02 18:54:11 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 19306806ae30b7fb5fe61a9130c6995402acad00:

  Add the WHPX acceleration enlightenments (2018-02-07 14:09:26 +0100)

----------------------------------------------------------------
* socket option parsing fix (Daniel)
* SCSI fixes (Fam)
* Readline double-free fix (Greg)
* More HVF attribution fixes (Izik)
* WHPX (Windows Hypervisor Platform Extensions) support (Justin)
* POLLHUP handler (Klim)
* ivshmem fixes (Ladi)
* memfd memory backend (Marc-André)
* improved error message (Marcelo)
* Memory fixes (Peter Xu, Zhecheng)
* Remove obsolete code and comments (Peter M.)
* qdev API improvements (Philippe)
* Add CONFIG_I2C switch (Thomas)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      kvm: Add kvm_set_user_memory tracepoint

Daniel P. Berrange (1):
      sockets: fix parsing of ipv4/ipv6 opts in parse_socket_addr

Fam Zheng (1):
      scsi-generic: Simplify error handling code

Greg Kurz (2):
      readline: don't free completions in readline_free()
      scripts/qemu-gdb/timers.py: define encoding in header comment

Izik Eidus (1):
      Add missing hvdos public domain attribution:

Jay Zhou (1):
      memory: update comments and fix some typos

Justin Terry (VM) (4):
      Add the Windows Hypervisor Platform accelerator.
      Add the WHPX vcpu API
      Introduce the WHPX impl
      Add the WHPX acceleration enlightenments

Klim Kireev (2):
      chardev/char-socket: add POLLHUP handler
      tests/test-filter-redirector: move close()

Ladi Prosek (4):
      ivshmem: Don't update non-existent MSI routes
      ivshmem: Always remove irqfd notifiers
      ivshmem: Improve MSI irqfd error handling
      ivshmem: Disable irqfd on device reset

Marc-André Lureau (10):
      exynos4210: workaround UBSAN compilation error
      build-sys: add --enable-sanitizers
      ucontext: annotate coroutine stack for ASAN
      memfd: add error argument, instead of perror()
      memfd: add hugetlb support
      memfd: add hugetlbsize argument
      Add memfd based hostmem
      tests: keep compiling failing vhost-user tests
      vhost-user-test: make read-guest-mem setup its own qemu
      tests: use memfd in vhost-user-test

Marcelo Tosatti (1):
      qemu: improve hugepage allocation failure message

Paolo Bonzini (7):
      hvf: ept_emulation_fault() needs NetApp BSD attribution
      cpus: hax: register/unregister thread with RCU, exit loop on unplug
      cpus: kvm: unregister thread with RCU
      cpus: dummy: unregister thread with RCU, exit loop on unplug
      cpus: tcg: unregister thread with RCU, fix exiting of loop on unplug
      cpus: hvf: unregister thread with RCU
      cpus: join thread when removing a vCPU

Peter Maydell (2):
      memory-internal.h: Remove obsolete claim that header is obsolete
      Drop remaining bits of ia64 host support

Peter Xu (5):
      chardev: fix incorrect unref of source
      vhost: add traces for memory listeners
      arm: postpone device listener unregister
      vfio: listener unregister before unset container
      memory: do explicit cleanup when remove listeners

Philippe Mathieu-Daudé (3):
      qdev: rename typedef qdev_resetfn() -> DeviceReset()
      qdev: add helpers to be more explicit when using abstract QOM parent functions
      qdev: use device_class_set_parent_realize/unrealize/reset()

Thomas Huth (1):
      i2c: Add a CONFIG_I2C master switch to the configuration files

linzhecheng (1):
      memory: set ioeventfd_update_pending after address_space_update_ioeventfds

 .travis.yml                             |    3 +-
 accel/kvm/kvm-all.c                     |    6 +-
 accel/kvm/trace-events                  |    1 +
 accel/stubs/Makefile.objs               |    9 +-
 accel/stubs/whpx-stub.c                 |   48 ++
 accel/tcg/user-exec.c                   |   33 -
 backends/Makefile.objs                  |    2 +
 backends/hostmem-memfd.c                |  170 ++++
 chardev/char-pty.c                      |   38 +-
 chardev/char-socket.c                   |   22 +
 configure                               |  113 ++-
 cpus.c                                  |  109 ++-
 default-configs/arm-softmmu.mak         |    1 +
 default-configs/i386-softmmu.mak        |    1 +
 default-configs/mips-softmmu-common.mak |    1 +
 default-configs/ppc-softmmu.mak         |    1 +
 default-configs/ppcemb-softmmu.mak      |    1 +
 default-configs/x86_64-softmmu.mak      |    1 +
 hw/core/qdev.c                          |   24 +
 hw/display/exynos4210_fimd.c            |    2 +-
 hw/i2c/Makefile.objs                    |    2 +-
 hw/i386/kvm/i8254.c                     |    4 +-
 hw/i386/kvm/i8259.c                     |    3 +-
 hw/input/adb-kbd.c                      |    4 +-
 hw/input/adb-mouse.c                    |    4 +-
 hw/intc/arm_gic.c                       |    3 +-
 hw/intc/arm_gic_kvm.c                   |    7 +-
 hw/intc/arm_gicv3.c                     |    3 +-
 hw/intc/arm_gicv3_its_kvm.c             |    3 +-
 hw/intc/arm_gicv3_kvm.c                 |    7 +-
 hw/intc/i8259.c                         |    3 +-
 hw/misc/ivshmem.c                       |   79 +-
 hw/net/vmxnet3.c                        |    4 +-
 hw/nvram/Makefile.objs                  |    2 +-
 hw/pci-bridge/gen_pcie_root_port.c      |    3 +-
 hw/scsi/scsi-generic.c                  |    9 +-
 hw/scsi/vmw_pvscsi.c                    |    4 +-
 hw/timer/i8254.c                        |    3 +-
 hw/vfio/amd-xgbe.c                      |    4 +-
 hw/vfio/calxeda-xgmac.c                 |    4 +-
 hw/vfio/common.c                        |   16 +-
 hw/virtio/trace-events                  |    6 +
 hw/virtio/vhost.c                       |   19 +-
 hw/virtio/virtio-pci.c                  |    4 +-
 include/exec/memory-internal.h          |    7 +-
 include/exec/memory.h                   |   27 +-
 include/hw/qdev-core.h                  |   14 +-
 include/qemu/compiler.h                 |    4 +
 include/qemu/memfd.h                    |    5 +-
 include/qemu/processor.h                |    3 -
 include/qemu/timer.h                    |    9 -
 include/sysemu/hw_accel.h               |   13 +
 include/sysemu/whpx.h                   |   40 +
 linux-user/syscall.c                    |    7 +-
 memory.c                                |   28 +
 numa.c                                  |    1 +
 qemu-options.hx                         |   30 +-
 scripts/qemugdb/timers.py               |    1 +
 target/alpha/cpu.c                      |    4 +-
 target/arm/cpu.c                        |    4 +-
 target/arm/kvm.c                        |    2 +-
 target/cris/cpu.c                       |    4 +-
 target/hppa/cpu.c                       |    4 +-
 target/i386/Makefile.objs               |    1 +
 target/i386/cpu.c                       |    8 +-
 target/i386/helper.c                    |    2 +-
 target/i386/hvf/hvf.c                   |   27 +
 target/i386/hvf/vmx.h                   |    3 +
 target/i386/whpx-all.c                  | 1366 +++++++++++++++++++++++++++++++
 target/lm32/cpu.c                       |    5 +-
 target/m68k/cpu.c                       |    5 +-
 target/microblaze/cpu.c                 |    5 +-
 target/mips/cpu.c                       |    5 +-
 target/moxie/cpu.c                      |    5 +-
 target/nios2/cpu.c                      |    4 +-
 target/openrisc/cpu.c                   |    5 +-
 target/ppc/translate_init.c             |    8 +-
 target/s390x/cpu.c                      |    4 +-
 target/sh4/cpu.c                        |    4 +-
 target/sparc/cpu.c                      |    4 +-
 target/tilegx/cpu.c                     |    4 +-
 target/tricore/cpu.c                    |    4 +-
 target/unicore32/cpu.c                  |    4 +-
 target/xtensa/cpu.c                     |    4 +-
 tests/test-filter-redirector.c          |    2 +-
 tests/vhost-user-test.c                 |  128 ++-
 util/coroutine-ucontext.c               |   48 ++
 util/memfd.c                            |   78 +-
 util/qemu-sockets.c                     |   44 +-
 util/readline.c                         |    3 -
 90 files changed, 2445 insertions(+), 328 deletions(-)
 create mode 100644 accel/stubs/whpx-stub.c
 create mode 100644 backends/hostmem-memfd.c
 create mode 100644 include/sysemu/whpx.h
 create mode 100644 target/i386/whpx-all.c
-- 
1.8.3.1
