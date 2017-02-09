Received: from eggs.gnu.org ([2001:4830:134:3::10]:37924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgiI-0001v2-MA
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgiD-0007gv-DD
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:10 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbgiD-0007fz-6v
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:05 -0500
Received: by mail-pg0-x243.google.com with SMTP id 204so16791706pge.2
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 20:52:05 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  8 Feb 2017 20:51:32 -0800
Message-Id: <20170209045154.16868-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 00/22] target/openrisc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

The bulk of this patch set is 2-3 years old, and was mostly
reviewed by Bastian Koppelmann.  But it languished because
there were reports of it not booting kernel images, and I
had problems putting together a set of tools that could even
build a kernel.

The OpenRISC community has picked up activity recently,
with Stafford Horne upstreaming some of the compiler tools.
He has even done some testing for me of this patch set.


r~


Richard Henderson (21):
  target/openrisc: Rename the cpu from or32 to or1k
  linux-user: Add MMAP_SHIFT for openrisc
  linux-user: Fix openrisc cpu_loop
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

Stafford Horne (1):
  target/openrisc: Fix exception handling status registers

 configure                            |    6 +-
 default-configs/or1k-linux-user.mak  |    1 +
 default-configs/or1k-softmmu.mak     |    4 +
 default-configs/or32-linux-user.mak  |    1 -
 default-configs/or32-softmmu.mak     |    4 -
 hw/openrisc/openrisc_sim.c           |    4 +-
 linux-user/main.c                    |   95 ++-
 linux-user/openrisc/target_syscall.h |    2 +
 target/openrisc/Makefile.objs        |    2 +-
 target/openrisc/cpu.c                |    1 +
 target/openrisc/cpu.h                |   47 +-
 target/openrisc/exception_helper.c   |   31 +
 target/openrisc/fpu_helper.c         |   68 +-
 target/openrisc/gdbstub.c            |   17 +-
 target/openrisc/helper.h             |   33 +-
 target/openrisc/int_helper.c         |   61 --
 target/openrisc/interrupt.c          |   14 +-
 target/openrisc/interrupt_helper.c   |    4 +-
 target/openrisc/machine.c            |   62 +-
 target/openrisc/mmu.c                |    1 +
 target/openrisc/sys_helper.c         |   62 +-
 target/openrisc/translate.c          | 1314 +++++++++++++++-------------------
 tests/tcg/openrisc/Makefile          |    4 +-
 23 files changed, 851 insertions(+), 987 deletions(-)
 create mode 100644 default-configs/or1k-linux-user.mak
 create mode 100644 default-configs/or1k-softmmu.mak
 delete mode 100644 default-configs/or32-linux-user.mak
 delete mode 100644 default-configs/or32-softmmu.mak
 delete mode 100644 target/openrisc/int_helper.c

-- 
2.9.3
