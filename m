Received: from eggs.gnu.org ([2001:4830:134:3::10]:46254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWX-0004Mg-23
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWS-0007Oc-Il
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:56 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWS-0007NM-9F
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:52 -0400
Received: by mail-wm0-x236.google.com with SMTP id i127so156606607wma.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:14:50 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51]) by smtp.gmail.com with ESMTPSA id
	y35sm22202793wrc.51.2017.07.05.00.14.46 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jul 2017 00:14:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:03 +0200
Message-Id: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/42] Misc changes for 2017-07-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 0c7a8b9baa744ae4323bb46cb4fe942355beaa85:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-07-04 11:17:02 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 44eff673411381062b826d048ba9d6630d2b2bdb:

  target/i386: add the CONFIG_TCG into Makefiles (2017-07-05 09:12:44 +0200)

----------------------------------------------------------------
* qemu-thread portability improvement (Fam)
* virtio-scsi IOMMU fix (Jason)
* poisoning and common-obj-y cleanups (Thomas)
* initial Hypervisor.framework refactoring (Sergio)
* x86 TCG interrupt injection fixes (Wu Xiang, me)
* --disable-tcg support for x86 (Yang Zhong, me)
* various other bugfixes and cleanups (Daniel, Peter, Thomas)

----------------------------------------------------------------
Alistair Francis (1):
      util/oslib-win32: Remove if conditional

Daniel P. Berrange (1):
      sockets: avoid formatting buffer that may not be NUL terminated

Fam Zheng (1):
      qemu-thread: Assert locks are initialized before using

Jason Wang (1):
      virtio-scsi: finalize IOMMU support

Paolo Bonzini (14):
      nbd: fix NBD over TLS
      target/i386: simplify handling of conforming code segments on interrupt
      checkpatch: should not use signal except for SIG_DFL or SIG_IGN
      qemu-doc: do not refer to years-old version numbers
      configure: factor out list of supported Xen/KVM/HAX targets
      configure: early test for supported targets
      configure: add --disable-tcg configure option
      vl: convert -tb-size to qemu_strtoul
      cpu: move interrupt handling out of translate-common.c
      monitor: disable "info jit" and "info opcount" if !TCG
      vapic: use tcg_enabled
      tcg: move tb_lock out of translate-all.h
      exec: elide calls to tb_lock and tb_unlock
      target/i386: move TLB refill function out of helper.c

Peter Maydell (2):
      tests/test-char.c: Don't use main_loop_wait()'s return value
      main_loop: Make main_loop_wait() return void

Sergio Andres Gomez Del Real (2):
      vcpu_dirty: share the same field in CPUState for all accelerators
      xsave_helper: pull xsave and xrstor out of kvm.c into helper function

Thomas Huth (8):
      qemu-doc: Add missing "@c man end" statements
      include/exec/poison: Add some more missing TARGET and CONFIG defines
      Move CONFIG_KVM related definitions to kvm_i386.h
      include/exec/poison: Mark CONFIG_KVM as poisoned, too
      cpu: Introduce a wrapper for tlb_flush() that can be used in common code
      include/exec/poison: Mark CONFIG_SOFTMMU as poisoned
      Makefile: Move bootdevice.o to common-obj-y
      hw/misc/edu: Compile the edu device as common object

Wu Xiang (1):
      target/i386: fix interrupt CPL error when using ist in x86-64

Yang Zhong (11):
      vl: add tcg_enabled() for tcg related code
      tcg: move page_size_init() function
      tcg: make tcg_allowed global
      tcg: add the tcg-stub.c file into accel/stubs/
      tcg: add CONFIG_TCG guards in headers
      tcg: add the CONFIG_TCG into Makefiles
      target/i386: move cpu_sync_bndcs_hflags() function
      target/i386: make cpu_get_fp80()/cpu_set_fp80() static
      target/i386: split cpu_set_mxcsr() and make cpu_set_fpuc() inline
      target/i386: add the tcg_enabled() in target/i386/
      target/i386: add the CONFIG_TCG into Makefiles

 Makefile.objs                |   2 +-
 Makefile.target              |   6 +-
 accel/Makefile.objs          |   2 +-
 accel/kvm/kvm-all.c          |  29 ++--
 accel/stubs/Makefile.objs    |   1 +
 accel/stubs/tcg-stub.c       |  22 +++
 accel/tcg/Makefile.objs      |   2 +-
 accel/tcg/cpu-exec-common.c  |   2 +
 accel/tcg/tcg-all.c          |  35 +++-
 accel/tcg/translate-all.c    |  37 ++---
 accel/tcg/translate-common.c |  56 -------
 block/nbd-client.c           |   4 +-
 bootdevice.c                 |   2 +-
 bsd-user/main.c              |   1 -
 configure                    | 184 ++++++++++++++-------
 exec.c                       |  23 +++
 hmp-commands-info.hx         |   4 +
 hw/acpi/ich9.c               |   1 -
 hw/i386/kvmvapic.c           |   5 +-
 hw/i386/pc_q35.c             |   1 +
 hw/misc/Makefile.objs        |   2 +-
 hw/scsi/virtio-scsi.c        |   3 +-
 include/exec/cpu-common.h    |   2 +
 include/exec/cpu-defs.h      |   4 +-
 include/exec/exec-all.h      |   7 +
 include/exec/poison.h        |   8 +
 include/hw/i386/pc.h         |  13 --
 include/qemu-common.h        |   7 +-
 include/qemu/main-loop.h     |   2 +-
 include/qemu/thread-posix.h  |   4 +
 include/qemu/thread-win32.h  |   5 +
 include/qom/cpu.h            |  13 +-
 include/sysemu/accel.h       |   2 +-
 include/sysemu/kvm.h         |  31 ++--
 monitor.c                    |   2 +
 qemu-doc.texi                |  14 +-
 qom/cpu.c                    |  18 ++-
 scripts/checkpatch.pl        |   4 +
 target/i386/Makefile.objs    |   9 +-
 target/i386/cpu.c            |   4 +-
 target/i386/cpu.h            |  33 +++-
 target/i386/excp_helper.c    | 343 +++++++++++++++++++++++++++++++++++++++
 target/i386/fpu_helper.c     |  29 +---
 target/i386/hax-all.c        |  12 +-
 target/i386/helper.c         | 376 ++++---------------------------------------
 target/i386/kvm.c            |  91 +----------
 target/i386/kvm_i386.h       |  23 +++
 target/i386/machine.c        |  31 +++-
 target/i386/mpx_helper.c     |  30 ----
 target/i386/seg_helper.c     |  28 ++--
 target/i386/xsave_helper.c   | 114 +++++++++++++
 target/mips/kvm.c            |   4 +-
 tcg/tcg.h                    |   4 -
 tests/test-char.c            |   6 +-
 util/main-loop.c             |   8 +-
 util/oslib-win32.c           |   6 +-
 util/qemu-sockets.c          |   2 +-
 util/qemu-thread-posix.c     |  27 ++++
 util/qemu-thread-win32.c     |  34 +++-
 vl.c                         |  14 +-
 60 files changed, 1009 insertions(+), 779 deletions(-)
 create mode 100644 accel/stubs/tcg-stub.c
 delete mode 100644 accel/tcg/translate-common.c
 create mode 100644 target/i386/xsave_helper.c
-- 
1.8.3.1
