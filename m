Received: from eggs.gnu.org ([2001:4830:134:3::10]:54691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fII4Y-0005Dn-3K
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fII4U-00059r-5C
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:19:46 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47831)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fII4T-00057T-SJ
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:19:42 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 14 May 2018 20:19:21 +0200
Message-Id: <20180514181928.18034-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/7] Linux user for 2.13 patches
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

The following changes since commit c74e62ee3e2dc2955e07d004c71badecb68a84eb:

  Merge remote-tracking branch 'remotes/rth/tags/cota-target-pull-request' into staging (2018-05-11 15:41:29 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-2.13-pull-request

for you to fetch changes up to f606e4d6258fa82c3f6c1cc762ebe483db5f5db6:

  linux-user: correctly align types in thunking code (2018-05-14 12:01:21 +0200)

----------------------------------------------------------------
Mostly sparc fixes, allowing to do a "debootstrap --second-stage",
including some structures alignment fixes.
This series fixes following LTP 20180118 tests on a x86_64 host:
armhf:    epoll_wait02 getpriority01 nice03 pselect01 pselect01_64
arm64:    epoll_wait02 getpriority01 nice03 poll02 pselect01 pselect01_64 select04
s390x:    epoll_wait02 getpriority01 nice03 poll02 pselect01 pselect01_64 select04
mips:     epoll_wait02 getpriority01 nice03 poll02 pselect01 pselect01_64
mips64el: epoll_wait02 getpriority01 nice03 pselect01 pselect01_64 select04
mipsel:   epoll_wait02 getpriority01 nice03 madvise06 poll02 select04
ppc64:    epoll_wait02 getpriority01 nice03 poll02 select04
ppc64el:  getpriority01 nice03 pselect01 select04      
sh4:      getpriority01 nice03 madvise06 poll02 pselect01 select04     
----------------------------------------------------------------

Laurent Vivier (7):
  linux-user: define correct fcntl() values for sparc
  linux-user: fix flock/flock64 padding
  linux-user: update sparc/syscall_nr.h to linux header 4.16
  linux-user: fix conversion of flock/flock64 l_type field
  linux-user: add sparc/sparc64 specific errno
  linux-user: fix UNAME_MACHINE for sparc/sparc64
  linux-user: correctly align types in thunking code

 include/exec/user/thunk.h           |  22 +++-
 linux-user/sparc/syscall_nr.h       |  32 +++++-
 linux-user/sparc/target_errno.h     | 207 ++++++++++++++++++++++++++++++++++++
 linux-user/sparc/target_syscall.h   |   4 +-
 linux-user/sparc64/syscall_nr.h     |  20 ++--
 linux-user/sparc64/target_syscall.h |   5 +-
 linux-user/syscall.c                |  66 ++++++++----
 linux-user/syscall_defs.h           |  25 ++++-
 8 files changed, 343 insertions(+), 38 deletions(-)
 create mode 100644 linux-user/sparc/target_errno.h

-- 
2.14.3
