Received: from eggs.gnu.org ([2001:4830:134:3::10]:54751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eq0aS-0002Du-91
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 12:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eq0aO-0002lB-DM
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 12:59:48 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:54019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eq0aO-0002i9-3j
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 12:59:44 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 25 Feb 2018 18:59:24 +0100
Message-Id: <20180225175928.13101-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/4] Linux user for 2.12 patches
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

The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5af8c5c2a6d0:

  maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-2.12-pull-request

for you to fetch changes up to 45506bddba6fe73f61cf15fb682ffff73ce156c0:

  linux-user: MIPS set cpu to r6 CPU if binary is R6 (2018-02-25 17:29:45 +0100)

----------------------------------------------------------------
This pull request includes new version of patches of the previous
one that were breaking some linux-user targets.
----------------------------------------------------------------

Laurent Vivier (2):
  linux-user: Move CPU type name selection to a function
  linux-user, m68k: select CPU according to ELF header values

YunQiang Su (2):
  linux-user: introduce functions to detect CPU type
  linux-user: MIPS set cpu to r6 CPU if binary is R6

 include/elf.h                      | 35 ++++++++++++++++++++++
 linux-user/aarch64/target_elf.h    | 14 +++++++++
 linux-user/alpha/target_elf.h      | 14 +++++++++
 linux-user/arm/target_elf.h        | 14 +++++++++
 linux-user/cris/target_elf.h       | 14 +++++++++
 linux-user/elfload.c               | 35 ++++++++++++++++++++++
 linux-user/hppa/target_elf.h       | 14 +++++++++
 linux-user/i386/target_elf.h       | 14 +++++++++
 linux-user/m68k/target_elf.h       | 20 +++++++++++++
 linux-user/main.c                  | 59 +++++++-------------------------------
 linux-user/microblaze/target_elf.h | 14 +++++++++
 linux-user/mips/target_elf.h       | 17 +++++++++++
 linux-user/mips64/target_elf.h     | 17 +++++++++++
 linux-user/nios2/target_elf.h      | 14 +++++++++
 linux-user/openrisc/target_elf.h   | 14 +++++++++
 linux-user/ppc/target_elf.h        | 18 ++++++++++++
 linux-user/qemu.h                  |  1 +
 linux-user/s390x/target_elf.h      | 14 +++++++++
 linux-user/sh4/target_elf.h        | 14 +++++++++
 linux-user/sparc/target_elf.h      | 18 ++++++++++++
 linux-user/sparc64/target_elf.h    | 14 +++++++++
 linux-user/tilegx/target_elf.h     | 14 +++++++++
 linux-user/unicore32/target_elf.h  | 14 +++++++++
 linux-user/x86_64/target_elf.h     | 14 +++++++++
 24 files changed, 382 insertions(+), 48 deletions(-)
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
