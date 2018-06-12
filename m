Received: from eggs.gnu.org ([2001:4830:134:3::10]:50234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSh0o-0003SS-IX
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSh0l-0007Ch-EC
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:58:54 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45659)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fSh0l-0007Bt-4N
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:58:51 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 12 Jun 2018 12:58:23 +0200
Message-Id: <20180612105831.25703-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/8] Linux user for 3.0 patches
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

The following changes since commit 9f55925b8f50a962d1d08d815044db7767ae3838:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-3.0-pull-request' into staging (2018-06-11 12:46:16 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-3.0-pull-request

for you to fetch changes up to dec1c928494f76ddd1484a7a4584ec18b1900a7a:

  linux-user/sparc64: Add inotify_rm_watch and tee syscalls (2018-06-11 14:47:45 +0200)

----------------------------------------------------------------
Fixes in syscall numbers,
disable the build of binaries not needed for linux-user,
update of qemu-binfmt-conf.sh and cleanup around is_error()

----------------------------------------------------------------

Laurent Vivier (2):
  linux-user: disable qemu-bridge-helper and socket_scm_helper build
  qemu-binfmt-conf.sh: ignore the OS/ABI field

Philippe Mathieu-Daudé (2):
  linux-user: Export use is_error(), use it to avoid warnings
  linux-user: Use is_error() to avoid warnings and make the code clearer

Richard Henderson (4):
  linux-user/alpha: Fix epoll syscalls
  linux-user/hppa: Fix typo in mknodat syscall
  linux-user/microblaze: Fix typo in accept4 syscall
  linux-user/sparc64: Add inotify_rm_watch and tee syscalls

 Makefile                           |  2 +-
 linux-user/alpha/syscall_nr.h      |  6 +++---
 linux-user/flatload.c              | 15 +++++++++------
 linux-user/hppa/syscall_nr.h       |  2 +-
 linux-user/microblaze/syscall_nr.h |  2 +-
 linux-user/qemu.h                  |  5 +++++
 linux-user/sparc64/syscall_nr.h    |  4 ++--
 linux-user/strace.list             |  9 ---------
 linux-user/syscall.c               |  5 -----
 scripts/qemu-binfmt-conf.sh        | 18 +++++++++---------
 tests/Makefile.include             |  2 +-
 11 files changed, 32 insertions(+), 38 deletions(-)

-- 
2.14.4
