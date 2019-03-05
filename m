Received: from eggs.gnu.org ([209.51.188.92]:55933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1BZh-0006rW-3p
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1BZe-00020h-BH
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:01:44 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:45424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1BZa-0001Q7-Kx
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:01:40 -0500
Received: by mail-pg1-x52b.google.com with SMTP id 125so5573628pgc.12
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 07:01:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  5 Mar 2019 07:01:23 -0800
Message-Id: <20190305150123.25048-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/73] tcg: per-cpu locks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, cota@braap.org

This is Emilio's v7, unchanged, so I'm not re-posting the 73 patches.

I also didn't want to add Signed-off-by to 73 patches, so I verified
that there was nothing on Emilio's branch that shouldn't be there and
then used git-merge -S --signoff.


r~


The following changes since commit 0984a157c1c053394adbf64ed7de97f1aebe6a2d:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2019-03-05 09:33:20 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190305

for you to fetch changes up to af7b762dc2dc519d12d1a36373c3e4f6e0f6d105:

  Merge branch 'cpu-lock-v7' of https://github.com/cota/qemu into staging (2019-03-05 06:41:07 -0800)

----------------------------------------------------------------
* Per-cpu locks

----------------------------------------------------------------
Emilio G. Cota (69):
      cpu: convert queued work to a QSIMPLEQ
      cpu: rename cpu->work_mutex to cpu->lock
      cpu: introduce cpu_mutex_lock/unlock
      cpu: make qemu_work_cond per-cpu
      cpu: move run_on_cpu to cpus-common
      cpu: introduce process_queued_cpu_work_locked
      cpu: make per-CPU locks an alias of the BQL in TCG rr mode
      tcg-runtime: define helper_cpu_halted_set
      ppc: convert to helper_cpu_halted_set
      cris: convert to helper_cpu_halted_set
      hppa: convert to helper_cpu_halted_set
      m68k: convert to helper_cpu_halted_set
      alpha: convert to helper_cpu_halted_set
      microblaze: convert to helper_cpu_halted_set
      cpu: define cpu_halted helpers
      tcg-runtime: convert to cpu_halted_set
      arm: convert to cpu_halted
      ppc: convert to cpu_halted
      sh4: convert to cpu_halted
      i386: convert to cpu_halted
      lm32: convert to cpu_halted
      m68k: convert to cpu_halted
      mips: convert to cpu_halted
      riscv: convert to cpu_halted
      s390x: convert to cpu_halted
      sparc: convert to cpu_halted
      xtensa: convert to cpu_halted
      gdbstub: convert to cpu_halted
      openrisc: convert to cpu_halted
      cpu-exec: convert to cpu_halted
      cpu: convert to cpu_halted
      cpu: define cpu_interrupt_request helpers
      exec: use cpu_reset_interrupt
      arm: convert to cpu_interrupt_request
      i386: convert to cpu_interrupt_request
      i386/kvm: convert to cpu_interrupt_request
      i386/hax-all: convert to cpu_interrupt_request
      i386/whpx-all: convert to cpu_interrupt_request
      i386/hvf: convert to cpu_request_interrupt
      ppc: convert to cpu_interrupt_request
      sh4: convert to cpu_interrupt_request
      cris: convert to cpu_interrupt_request
      hppa: convert to cpu_interrupt_request
      lm32: convert to cpu_interrupt_request
      m68k: convert to cpu_interrupt_request
      mips: convert to cpu_interrupt_request
      nios: convert to cpu_interrupt_request
      s390x: convert to cpu_interrupt_request
      alpha: convert to cpu_interrupt_request
      moxie: convert to cpu_interrupt_request
      sparc: convert to cpu_interrupt_request
      openrisc: convert to cpu_interrupt_request
      unicore32: convert to cpu_interrupt_request
      microblaze: convert to cpu_interrupt_request
      accel/tcg: convert to cpu_interrupt_request
      cpu: convert to interrupt_request
      cpu: call .cpu_has_work with the CPU lock held
      cpu: introduce cpu_has_work_with_iothread_lock
      ppc: convert to cpu_has_work_with_iothread_lock
      mips: convert to cpu_has_work_with_iothread_lock
      s390x: convert to cpu_has_work_with_iothread_lock
      riscv: convert to cpu_has_work_with_iothread_lock
      sparc: convert to cpu_has_work_with_iothread_lock
      xtensa: convert to cpu_has_work_with_iothread_lock
      cpu: rename all_cpu_threads_idle to qemu_tcg_rr_all_cpu_threads_idle
      cpu: protect CPU state with cpu->lock instead of the BQL
      cpus-common: release BQL earlier in run_on_cpu
      cpu: add async_run_on_cpu_no_bql
      cputlb: queue async flush jobs without the BQL

Paolo Bonzini (4):
      ppc: use cpu_reset_interrupt
      i386: use cpu_reset_interrupt
      s390x: use cpu_reset_interrupt
      openrisc: use cpu_reset_interrupt

Richard Henderson (1):
      Merge branch 'cpu-lock-v7' of https://github.com/cota/qemu into staging

 accel/tcg/tcg-runtime.h         |   2 +
 include/qom/cpu.h               | 195 ++++++++++++++++---
 target/i386/cpu.h               |   2 +-
 target/ppc/helper_regs.h        |   2 +-
 accel/tcg/cpu-exec.c            |  40 ++--
 accel/tcg/cputlb.c              |  10 +-
 accel/tcg/tcg-all.c             |  12 +-
 accel/tcg/tcg-runtime.c         |   7 +
 accel/tcg/translate-all.c       |   2 +-
 cpus-common.c                   | 129 ++++++++----
 cpus.c                          | 422 ++++++++++++++++++++++++++++++++--------
 exec.c                          |   2 +-
 gdbstub.c                       |   4 +-
 hw/arm/omap1.c                  |   4 +-
 hw/arm/pxa2xx_gpio.c            |   2 +-
 hw/arm/pxa2xx_pic.c             |   2 +-
 hw/intc/s390_flic.c             |   4 +-
 hw/mips/cps.c                   |   2 +-
 hw/misc/mips_itu.c              |   4 +-
 hw/openrisc/cputimer.c          |   2 +-
 hw/ppc/e500.c                   |   4 +-
 hw/ppc/ppc.c                    |  12 +-
 hw/ppc/ppce500_spin.c           |   6 +-
 hw/ppc/spapr_cpu_core.c         |   4 +-
 hw/ppc/spapr_hcall.c            |   4 +-
 hw/ppc/spapr_rtas.c             |   6 +-
 hw/sparc/leon3.c                |   2 +-
 hw/sparc/sun4m.c                |   8 +-
 hw/sparc64/sparc64.c            |   8 +-
 qom/cpu.c                       |  27 ++-
 stubs/cpu-lock.c                |  28 +++
 target/alpha/cpu.c              |   8 +-
 target/alpha/translate.c        |   6 +-
 target/arm/arm-powerctl.c       |   6 +-
 target/arm/cpu.c                |   8 +-
 target/arm/helper.c             |  16 +-
 target/arm/machine.c            |   2 +-
 target/arm/op_helper.c          |   2 +-
 target/cris/cpu.c               |   2 +-
 target/cris/helper.c            |   6 +-
 target/cris/translate.c         |   5 +-
 target/hppa/cpu.c               |   2 +-
 target/hppa/translate.c         |   3 +-
 target/i386/cpu.c               |   4 +-
 target/i386/hax-all.c           |  36 ++--
 target/i386/helper.c            |   8 +-
 target/i386/hvf/hvf.c           |  12 +-
 target/i386/hvf/x86hvf.c        |  38 ++--
 target/i386/kvm.c               |  82 ++++----
 target/i386/misc_helper.c       |   2 +-
 target/i386/seg_helper.c        |  13 +-
 target/i386/svm_helper.c        |   6 +-
 target/i386/whpx-all.c          |  57 +++---
 target/lm32/cpu.c               |   2 +-
 target/lm32/op_helper.c         |   4 +-
 target/m68k/cpu.c               |   2 +-
 target/m68k/op_helper.c         |   2 +-
 target/m68k/translate.c         |   9 +-
 target/microblaze/cpu.c         |   2 +-
 target/microblaze/translate.c   |   4 +-
 target/mips/cpu.c               |  11 +-
 target/mips/kvm.c               |   4 +-
 target/mips/op_helper.c         |   8 +-
 target/mips/translate.c         |   4 +-
 target/moxie/cpu.c              |   2 +-
 target/nios2/cpu.c              |   2 +-
 target/openrisc/cpu.c           |   4 +-
 target/openrisc/sys_helper.c    |   4 +-
 target/ppc/excp_helper.c        |   6 +-
 target/ppc/kvm.c                |   8 +-
 target/ppc/translate.c          |   6 +-
 target/ppc/translate_init.inc.c |  36 ++--
 target/riscv/cpu.c              |   5 +-
 target/riscv/op_helper.c        |   2 +-
 target/s390x/cpu.c              |  28 ++-
 target/s390x/excp_helper.c      |   4 +-
 target/s390x/kvm.c              |   2 +-
 target/s390x/sigp.c             |   8 +-
 target/sh4/cpu.c                |   2 +-
 target/sh4/helper.c             |   2 +-
 target/sh4/op_helper.c          |   2 +-
 target/sparc/cpu.c              |   6 +-
 target/sparc/helper.c           |   2 +-
 target/unicore32/cpu.c          |   2 +-
 target/unicore32/softmmu.c      |   2 +-
 target/xtensa/cpu.c             |   6 +-
 target/xtensa/exc_helper.c      |   2 +-
 target/xtensa/helper.c          |   2 +-
 stubs/Makefile.objs             |   1 +
 89 files changed, 1024 insertions(+), 456 deletions(-)
 create mode 100644 stubs/cpu-lock.c
