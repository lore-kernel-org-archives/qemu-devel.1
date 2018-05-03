Received: from eggs.gnu.org ([2001:4830:134:3::10]:54810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fELwo-0004jE-9r
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fELwk-00055M-2r
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:39:30 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:43853)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fELwj-00052N-OW
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:39:25 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  3 May 2018 23:38:57 +0200
Message-Id: <20180503213903.30335-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/6] Linux user for 2.13 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

The following changes since commit 59255887e6cafeff747250d2613003a41d1d9dff:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180502' into staging (2018-05-03 11:25:14 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-2.13-pull-request

for you to fetch changes up to 7f254c5cb80bc478794a4c3d7fe5d503b033be13:

  linux-user: remove useless padding in flock64 structure (2018-05-03 18:40:19 +0200)

----------------------------------------------------------------

----------------------------------------------------------------

Christophe Lyon (4):
  Remove CONFIG_USE_FDPIC.
  linux-user: ARM-FDPIC: Identify ARM FDPIC binaries
  linux-user: ARM-FDPIC: Add support of FDPIC for ARM.
  linux-user: ARM-FDPIC: Add support for signals for FDPIC targets

Laurent Vivier (2):
  linux-user: introduce target_sigsp() and target_save_altstack()
  linux-user: remove useless padding in flock64 structure

 include/elf.h                   |   1 +
 include/exec/user/abitypes.h    |   2 +-
 linux-user/aarch64/signal.c     |  13 +----
 linux-user/alpha/signal.c       |  17 ++----
 linux-user/arm/signal.c         | 122 ++++++++++++++++++++++++++++++----------
 linux-user/arm/target_structs.h |   7 +++
 linux-user/elfload.c            |  54 ++++++++++++++----
 linux-user/hppa/signal.c        |  14 ++---
 linux-user/i386/signal.c        |  12 +---
 linux-user/m68k/signal.c        |  15 +----
 linux-user/microblaze/signal.c  |   4 +-
 linux-user/mips/signal.c        |  15 +----
 linux-user/nios2/signal.c       |  21 +------
 linux-user/openrisc/signal.c    |  14 +----
 linux-user/ppc/signal.c         |  15 +----
 linux-user/qemu.h               |  13 ++++-
 linux-user/riscv/signal.c       |  28 +++------
 linux-user/s390x/signal.c       |  12 +---
 linux-user/sh4/signal.c         |  11 +---
 linux-user/signal-common.h      |  15 ++---
 linux-user/signal.c             |  32 +++++++++++
 linux-user/sparc/signal.c       |  28 ++++++---
 linux-user/syscall.c            |  14 ++---
 linux-user/syscall_defs.h       |  25 ++------
 linux-user/tilegx/signal.c      |  13 +----
 linux-user/xtensa/signal.c      |  15 ++---
 26 files changed, 271 insertions(+), 261 deletions(-)

-- 
2.14.3
