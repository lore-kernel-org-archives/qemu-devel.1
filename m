Received: from eggs.gnu.org ([2001:4830:134:3::10]:34359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cS3HW-0003IH-NM
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cS3HT-0003L6-J5
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:56:42 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:36426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cS3HT-0003KO-Cq
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:56:39 -0500
Received: by mail-wm0-x22e.google.com with SMTP id c85so68295717wmi.1
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 06:56:39 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Jan 2017 14:56:30 +0000
Message-Id: <20170113145633.15384-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/3] Common TLB reset changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit b6c08970bc989bfddcf830684ea7a96b7a4d62a7:

  Merge remote-tracking branch 'remotes/bkoppelmann/tags/pull-tricore-2017-01-11-2' into staging (2017-01-12 18:29:49 +0000)

are available in the git repository at:

  https://github.com/stsquad/qemu.git tags/pull-tcg-common-tlb-reset-20170113-r1

for you to fetch changes up to d10eb08f5d8389c814b554d01aa2882ac58221bf:

  cputlb: drop flush_global flag from tlb_flush (2017-01-13 14:24:37 +0000)

----------------------------------------------------------------
This is the same as the v3 posted except a re-base and a few extra signoffs

----------------------------------------------------------------
Alex Bennée (3):
      qom/cpu: move tlb_flush to cpu_common_reset
      cpu_common_reset: wrap TCG specific code in tcg_enabled()
      cputlb: drop flush_global flag from tlb_flush

 cputlb.c                           | 21 ++++++---------------
 exec.c                             |  4 ++--
 hw/sh4/sh7750.c                    |  2 +-
 include/exec/exec-all.h            | 14 ++++++--------
 qom/cpu.c                          | 10 ++++++++--
 target/alpha/cpu.c                 |  2 +-
 target/alpha/sys_helper.c          |  2 +-
 target/arm/cpu.c                   |  5 ++---
 target/arm/cpu.h                   |  5 ++++-
 target/arm/helper.c                | 26 +++++++++++++-------------
 target/cris/cpu.c                  |  3 +--
 target/cris/cpu.h                  |  9 ++++++---
 target/i386/cpu.c                  |  2 --
 target/i386/cpu.h                  |  6 ++++--
 target/i386/fpu_helper.c           |  2 +-
 target/i386/helper.c               |  8 ++++----
 target/i386/machine.c              |  2 +-
 target/i386/misc_helper.c          |  2 +-
 target/i386/svm_helper.c           |  2 +-
 target/lm32/cpu.c                  |  3 +--
 target/lm32/cpu.h                  |  3 +++
 target/m68k/cpu.c                  |  3 +--
 target/m68k/cpu.h                  |  3 +++
 target/microblaze/cpu.c            |  3 +--
 target/microblaze/cpu.h            |  3 +++
 target/microblaze/mmu.c            |  2 +-
 target/mips/cpu.c                  |  3 +--
 target/mips/cpu.h                  |  5 ++++-
 target/mips/helper.c               |  6 +++---
 target/mips/op_helper.c            |  8 ++++----
 target/moxie/cpu.c                 |  4 +---
 target/moxie/cpu.h                 |  3 +++
 target/openrisc/cpu.c              |  9 +--------
 target/openrisc/cpu.h              |  3 +++
 target/openrisc/interrupt.c        |  2 +-
 target/openrisc/interrupt_helper.c |  2 +-
 target/openrisc/sys_helper.c       |  2 +-
 target/ppc/helper_regs.h           |  4 ++--
 target/ppc/misc_helper.c           |  4 ++--
 target/ppc/mmu_helper.c            | 32 ++++++++++++++++----------------
 target/ppc/translate_init.c        |  3 ---
 target/s390x/cpu.c                 |  7 ++-----
 target/s390x/cpu.h                 |  5 +++--
 target/s390x/gdbstub.c             |  2 +-
 target/s390x/mem_helper.c          |  8 ++++----
 target/sh4/cpu.c                   |  3 +--
 target/sh4/cpu.h                   |  3 +++
 target/sh4/helper.c                |  2 +-
 target/sparc/cpu.c                 |  3 +--
 target/sparc/cpu.h                 |  3 +++
 target/sparc/ldst_helper.c         | 12 ++++++------
 target/tilegx/cpu.c                |  3 +--
 target/tilegx/cpu.h                |  3 +++
 target/tricore/cpu.c               |  2 --
 target/unicore32/cpu.c             |  2 +-
 target/unicore32/helper.c          |  2 +-
 target/xtensa/op_helper.c          |  2 +-
 57 files changed, 151 insertions(+), 148 deletions(-)


--
2.11.0
