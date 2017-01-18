Received: from eggs.gnu.org ([2001:4830:134:3::10]:46820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cTyIv-0004ua-C0
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cTyIs-0001dO-5R
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:02:05 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:47923)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1cTyIr-0001Xp-SL
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:02:02 -0500
From: Marek Vasut <marex@denx.de>
Date: Wed, 18 Jan 2017 23:01:39 +0100
Message-Id: <20170118220146.489-1-marex@denx.de>
Subject: [Qemu-devel] [PATCH 0/7] Nios2 architecture support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>, Jeff Da Silva <jdasilva@altera.com>, Ley Foon Tan <lftan@altera.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

This patchset adds support for new Nios2 architecture as well as
the initial set of models for hardware blocks and emulation of
the Altera 10M50 GHRD devkit.

Cc: Chris Wulff <crwulff@gmail.com>
Cc: Jeff Da Silva <jdasilva@altera.com>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Sandra Loosemore <sandra@codesourcery.com>
Cc: Yves Vandervennet <yvanderv@altera.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Richard Henderson <rth@twiddle.net>

Chris Wulff (3):
  nios2: Add architecture emulation support
  nios2: Add IIC interrupt controller emulation
  nios2: Add periodic timer emulation

Marek Vasut (4):
  nios2: Add disas entries
  nios2: Add usermode binaries emulation
  nios2: Add Altera 10M50 GHRD emulation
  nios2: Add support for Nios-II R1

 MAINTAINERS                          |    8 +
 arch_init.c                          |    2 +
 configure                            |    5 +
 default-configs/nios2-linux-user.mak |    1 +
 default-configs/nios2-softmmu.mak    |    6 +
 disas/Makefile.objs                  |    1 +
 disas/nios2.c                        | 3534 ++++++++++++++++++++++++++++++++++
 hw/intc/Makefile.objs                |    1 +
 hw/intc/nios2_iic.c                  |  103 +
 hw/nios2/10m50_devboard.c            |  126 ++
 hw/nios2/Makefile.objs               |    1 +
 hw/nios2/boot.c                      |  223 +++
 hw/nios2/boot.h                      |   11 +
 hw/nios2/cpu_pic.c                   |   70 +
 hw/timer/Makefile.objs               |    1 +
 hw/timer/altera_timer.c              |  237 +++
 include/disas/bfd.h                  |    6 +
 include/elf.h                        |    2 +
 include/sysemu/arch_init.h           |    1 +
 linux-user/elfload.c                 |   57 +
 linux-user/main.c                    |  140 +-
 linux-user/nios2/syscall_nr.h        |  329 ++++
 linux-user/nios2/target_cpu.h        |   39 +
 linux-user/nios2/target_signal.h     |   26 +
 linux-user/nios2/target_structs.h    |   58 +
 linux-user/nios2/target_syscall.h    |   37 +
 linux-user/nios2/termbits.h          |  220 +++
 linux-user/signal.c                  |  238 ++-
 linux-user/syscall_defs.h            |    8 +-
 qemu-doc.texi                        |    3 +
 target/nios2/Makefile.objs           |    4 +
 target/nios2/cpu.c                   |  239 +++
 target/nios2/cpu.h                   |  272 +++
 target/nios2/helper.c                |  313 +++
 target/nios2/helper.h                |   27 +
 target/nios2/mmu.c                   |  296 +++
 target/nios2/mmu.h                   |   50 +
 target/nios2/monitor.c               |   35 +
 target/nios2/op_helper.c             |   47 +
 target/nios2/translate.c             |  958 +++++++++
 40 files changed, 7728 insertions(+), 7 deletions(-)
 create mode 100644 default-configs/nios2-linux-user.mak
 create mode 100644 default-configs/nios2-softmmu.mak
 create mode 100644 disas/nios2.c
 create mode 100644 hw/intc/nios2_iic.c
 create mode 100644 hw/nios2/10m50_devboard.c
 create mode 100644 hw/nios2/Makefile.objs
 create mode 100644 hw/nios2/boot.c
 create mode 100644 hw/nios2/boot.h
 create mode 100644 hw/nios2/cpu_pic.c
 create mode 100644 hw/timer/altera_timer.c
 create mode 100644 linux-user/nios2/syscall_nr.h
 create mode 100644 linux-user/nios2/target_cpu.h
 create mode 100644 linux-user/nios2/target_signal.h
 create mode 100644 linux-user/nios2/target_structs.h
 create mode 100644 linux-user/nios2/target_syscall.h
 create mode 100644 linux-user/nios2/termbits.h
 create mode 100644 target/nios2/Makefile.objs
 create mode 100644 target/nios2/cpu.c
 create mode 100644 target/nios2/cpu.h
 create mode 100644 target/nios2/helper.c
 create mode 100644 target/nios2/helper.h
 create mode 100644 target/nios2/mmu.c
 create mode 100644 target/nios2/mmu.h
 create mode 100644 target/nios2/monitor.c
 create mode 100644 target/nios2/op_helper.c
 create mode 100644 target/nios2/translate.c

-- 
2.11.0
