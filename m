Received: from eggs.gnu.org ([2001:4830:134:3::10]:53650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1enoxq-0004tp-0H
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1enoxm-0005QF-K4
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:10:53 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:51455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1enoxm-0005PG-8w
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:10:50 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 19 Feb 2018 18:10:29 +0100
Message-Id: <20180219171037.24539-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/8] Linux user for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

The following changes since commit f0fa81767555fe2c4b5f8c9e0725a80eac1d7f56:

  cuda.h: Fix multiple typedef (2018-02-16 18:38:21 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-2.12-pull-request

for you to fetch changes up to f352a021329f73d0219018cdfb39369687e8cadd:

  linux-user: MIPS set cpu to r6 CPU if binary is R6 (2018-02-18 18:52:32 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Andreas Schwab (1):
  linux-user: Implement ioctl cmd TIOCGPTPEER

Guido Günther (1):
  linux-user: Fix register used for 6th and 7th syscall argument on
    aarch64

Laurent Vivier (2):
  linux-user: Move CPU type name selection to a function
  linux-user, m68k: select CPU according to ELF header values

Peter Maydell (1):
  linux-user: Remove THREAD macro

Samuel Thibault (1):
  linux-user: Fix sched_getaffinity mask size

YunQiang Su (2):
  linux-user: introduce functions to detect CPU type
  linux-user: MIPS set cpu to r6 CPU if binary is R6

 include/elf.h                              | 32 ++++++++++++++++
 linux-user/aarch64/target_elf.h            | 14 +++++++
 linux-user/aarch64/termbits.h              |  2 +
 linux-user/alpha/target_elf.h              | 14 +++++++
 linux-user/alpha/termbits.h                |  1 +
 linux-user/arm/target_elf.h                | 14 +++++++
 linux-user/arm/termbits.h                  |  1 +
 linux-user/cris/target_elf.h               | 14 +++++++
 linux-user/cris/termbits.h                 |  1 +
 linux-user/elfload.c                       | 35 +++++++++++++++++
 linux-user/host/aarch64/safe-syscall.inc.S |  6 +--
 linux-user/hppa/target_elf.h               | 14 +++++++
 linux-user/hppa/termbits.h                 |  2 +
 linux-user/i386/target_elf.h               | 14 +++++++
 linux-user/i386/termbits.h                 |  1 +
 linux-user/ioctls.h                        |  3 ++
 linux-user/m68k/target_elf.h               | 20 ++++++++++
 linux-user/m68k/termbits.h                 |  1 +
 linux-user/main.c                          | 61 ++++++------------------------
 linux-user/microblaze/target_elf.h         | 14 +++++++
 linux-user/microblaze/termbits.h           |  1 +
 linux-user/mips/target_elf.h               | 17 +++++++++
 linux-user/mips/termbits.h                 |  1 +
 linux-user/mips64/target_elf.h             | 17 +++++++++
 linux-user/nios2/target_elf.h              | 14 +++++++
 linux-user/nios2/termbits.h                |  2 +
 linux-user/openrisc/target_elf.h           | 14 +++++++
 linux-user/openrisc/termbits.h             |  2 +
 linux-user/ppc/target_elf.h                | 18 +++++++++
 linux-user/ppc/termbits.h                  |  1 +
 linux-user/qemu.h                          |  5 +--
 linux-user/s390x/target_elf.h              | 14 +++++++
 linux-user/s390x/termbits.h                |  1 +
 linux-user/sh4/target_elf.h                | 14 +++++++
 linux-user/sh4/termbits.h                  |  1 +
 linux-user/sparc/target_elf.h              | 14 +++++++
 linux-user/sparc/termbits.h                |  1 +
 linux-user/sparc64/target_elf.h            | 14 +++++++
 linux-user/sparc64/termbits.h              |  1 +
 linux-user/syscall.c                       | 13 ++++++-
 linux-user/tilegx/target_elf.h             | 14 +++++++
 linux-user/tilegx/termbits.h               |  1 +
 linux-user/unicore32/target_elf.h          | 14 +++++++
 linux-user/x86_64/target_elf.h             | 14 +++++++
 linux-user/x86_64/termbits.h               |  1 +
 45 files changed, 417 insertions(+), 56 deletions(-)
 create mode 100644 linux-user/aarch64/target_elf.h
 create mode 100644 linux-user/alpha/target_elf.h
 create mode 100644 linux-user/arm/target_elf.h
 create mode 100644 linux-user/cris/target_elf.h
 create mode 100644 linux-user/hppa/target_elf.h
 create mode 100644 linux-user/i386/target_elf.h
 create mode 100644 linux-user/m68k/target_elf.h
 create mode 100644 linux-user/microblaze/target_elf.h
 create mode 100644 linux-user/mips/target_elf.h
 create mode 100644 linux-user/mips64/target_elf.h
 create mode 100644 linux-user/nios2/target_elf.h
 create mode 100644 linux-user/openrisc/target_elf.h
 create mode 100644 linux-user/ppc/target_elf.h
 create mode 100644 linux-user/s390x/target_elf.h
 create mode 100644 linux-user/sh4/target_elf.h
 create mode 100644 linux-user/sparc/target_elf.h
 create mode 100644 linux-user/sparc64/target_elf.h
 create mode 100644 linux-user/tilegx/target_elf.h
 create mode 100644 linux-user/unicore32/target_elf.h
 create mode 100644 linux-user/x86_64/target_elf.h

-- 
2.14.3
