Received: from eggs.gnu.org ([2001:4830:134:3::10]:47721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVmv2-0004H5-Lo
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 17:16:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVmv1-0007nK-BD
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 17:16:56 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVmv1-0007nE-4b
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 17:16:55 -0500
Received: by mail-qt0-x244.google.com with SMTP id f4so20495461qte.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 14:16:55 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 23 Jan 2017 14:16:43 -0800
Message-Id: <20170123221650.9267-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 0/7] Nios2 architecture support
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

This is me acking this new target.  Hopefully Chris and/or Marek
will be able to get some gpg keys signed relatively soon.

I had to make one change for the target, updating to rely on the
common tlb_flush during reset.


r~


The following changes since commit 3879284d6517dc22529395bdb259f4183b589127:

  Merge remote-tracking branch 'remotes/berrange/tags/pull-qio-2017-01-23-2' into staging (2017-01-23 15:59:09 +0000)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-nios-20170123

for you to fetch changes up to 9a6aa7cc59b7ff0535392241e19c73cde146c506:

  nios2: Add support for Nios-II R1 (2017-01-23 13:54:58 -0800)

----------------------------------------------------------------
nios2 target support

----------------------------------------------------------------
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
 target/nios2/cpu.c                   |  237 +++
 target/nios2/cpu.h                   |  272 +++
 target/nios2/helper.c                |  313 +++
 target/nios2/helper.h                |   27 +
 target/nios2/mmu.c                   |  296 +++
 target/nios2/mmu.h                   |   50 +
 target/nios2/monitor.c               |   35 +
 target/nios2/op_helper.c             |   47 +
 target/nios2/translate.c             |  958 +++++++++
 40 files changed, 7726 insertions(+), 7 deletions(-)
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
