Received: from eggs.gnu.org ([2001:4830:134:3::10]:50178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cW8Q9-0007i6-PY
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 16:14:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cW8Q8-00084E-BU
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 16:14:29 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cW8Q8-00083h-5v
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 16:14:28 -0500
Received: by mail-pg0-x242.google.com with SMTP id 194so17562584pgd.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 13:14:28 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 24 Jan 2017 13:14:24 -0800
Message-Id: <20170124211424.2828-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 0/7] Nios2 architecture support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marex@denx.de, crwulff@gmail.com, peter.maydell@linaro.org

Version 2: Use PRIx64 in patch 1 to fix a 32-bit build failure.


r~


The following changes since commit a678502e4f7580a6f143f680404aaee57ac3f4b5:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging (2017-01-24 15:39:09 +0000)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-nios-20170124

for you to fetch changes up to e671711c9a8c1de540f035095e18458bc03968de:

  nios2: Add support for Nios-II R1 (2017-01-24 13:10:36 -0800)

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
 linux-user/signal.c                  |  239 ++-
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
 40 files changed, 7727 insertions(+), 7 deletions(-)
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
