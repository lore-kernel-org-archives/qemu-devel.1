Received: from eggs.gnu.org ([2001:4830:134:3::10]:45094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8G-0004Uk-Bq
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8B-0001AN-BC
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:00 -0500
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:33846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdO8B-0001AD-6O
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:25:55 -0500
Received: by mail-qt0-x236.google.com with SMTP id w20so94945317qtb.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 13:25:55 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 14 Feb 2017 08:25:12 +1100
Message-Id: <20170213212536.31871-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/24] target/openrisc patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is the v2 patch set that I posted last week.
It even acquired some new R-b.  Whee!


r~



The following changes since commit 305e6c8a2ff7a6e3f4942b50e853230f18eeb5a9:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2017-02-13 16:44:04 +0000)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-or-20170214

for you to fetch changes up to 6597c28d618a3d16d468770b7c30a0237a8c8ea9:

  target/openrisc: Optimize for r0 being zero (2017-02-14 08:15:00 +1100)

----------------------------------------------------------------
Queued openrisc patches

----------------------------------------------------------------
Richard Henderson (23):
      target/openrisc: Rename the cpu from or32 to or1k
      linux-user: Add MMAP_SHIFT for openrisc
      linux-user: Fix openrisc cpu_loop
      linux-user: Honor CLONE_SETTLS for openrisc
      target/openrisc: Implement lwa, swa
      target/openrisc: Tidy insn dumping
      target/openrisc: Rationalize immediate extraction
      target/openrisc: Streamline arithmetic and OVE
      target/openrisc: Put SR[OVE] in TB flags
      target/openrisc: Invert the decoding in dec_calc
      target/openrisc: Keep SR_F in a separate variable
      target/openrisc: Keep SR_CY and SR_OV in a separate variables
      target/openrisc: Use movcond where appropriate
      target/openrisc: Set flags on helpers
      target/openrisc: Enable trap, csync, msync, psync for user mode
      target/openrisc: Implement msync
      target/openrisc: Represent MACHI:MACLO as a single unit
      target/openrisc: Implement muld, muldu, macu, msbu
      target/openrisc: Fix madd
      target/openrisc: Optimize l.jal to next
      target/openrisc: Tidy ppc/npc implementation
      target/openrisc: Tidy handling of delayed branches
      target/openrisc: Optimize for r0 being zero

Stafford Horne (1):
      target/openrisc: Fix exception handling status registers

 configure                            |    6 +-
 default-configs/or1k-linux-user.mak  |    1 +
 default-configs/or1k-softmmu.mak     |    4 +
 default-configs/or32-linux-user.mak  |    1 -
 default-configs/or32-softmmu.mak     |    4 -
 hw/openrisc/openrisc_sim.c           |    4 +-
 linux-user/elfload.c                 |    3 +-
 linux-user/main.c                    |   98 +--
 linux-user/openrisc/target_cpu.h     |    4 +-
 linux-user/openrisc/target_syscall.h |    2 +
 target/openrisc/Makefile.objs        |    2 +-
 target/openrisc/cpu.c                |    1 +
 target/openrisc/cpu.h                |   50 +-
 target/openrisc/exception_helper.c   |   32 +
 target/openrisc/fpu_helper.c         |   68 +-
 target/openrisc/gdbstub.c            |   17 +-
 target/openrisc/helper.h             |   33 +-
 target/openrisc/int_helper.c         |   61 --
 target/openrisc/interrupt.c          |   14 +-
 target/openrisc/interrupt_helper.c   |    4 +-
 target/openrisc/machine.c            |   62 +-
 target/openrisc/mmu.c                |    1 +
 target/openrisc/sys_helper.c         |   62 +-
 target/openrisc/translate.c          | 1389 ++++++++++++++++------------------
 tests/tcg/openrisc/Makefile          |    4 +-
 25 files changed, 915 insertions(+), 1012 deletions(-)
 create mode 100644 default-configs/or1k-linux-user.mak
 create mode 100644 default-configs/or1k-softmmu.mak
 delete mode 100644 default-configs/or32-linux-user.mak
 delete mode 100644 default-configs/or32-softmmu.mak
 delete mode 100644 target/openrisc/int_helper.c
