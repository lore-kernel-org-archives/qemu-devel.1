Received: from eggs.gnu.org ([2001:4830:134:3::10]:43405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzs1-00075P-0G
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzrw-0002Ix-5X
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:17 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:57659)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1edzrv-0002HV-RE
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:12 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 23 Jan 2018 15:47:54 +0100
Message-Id: <20180123144807.5618-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/13] Linux user for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

The following changes since commit 52483b067cce4a88ffbf8fbeea26de7549d2ad23:

  Merge remote-tracking branch 'remotes/huth/tags/pull-request-2018-01-22' into staging (2018-01-23 10:15:09 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-2.12-pull-request

for you to fetch changes up to 95d0307cc10ca3df879c1be519f1ad650efb20a8:

  linux-user: implement renameat2 (2018-01-23 14:27:33 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Andreas Schwab (1):
  linux-user: implement renameat2

Laurent Vivier (1):
  linux-user: remove nmi.c and fw-path-provider.c

Marco A L Barbosa (1):
  linux-user: Add AT_SECURE auxval

Maximilian Riemensberger (1):
  linux-user/mmap.c: Avoid choosing NULL as start address

Peter Maydell (7):
  linux-user: Fix locking order in fork_start()
  linux-user: wrap fork() in a start/end exclusive section
  linux-user: Fix length calculations in host_to_target_cmsg()
  linux-user: Don't use CMSG_ALIGN(sizeof struct cmsghdr)
  linux-user: Translate flags argument to dup3 syscall
  linux-user: Propagate siginfo_t through to handle_cpu_signal()
  page_unprotect(): handle calls to pages that are PAGE_WRITE

Samuel Thibault (2):
  linux-user: Fix sched_get/setaffinity conversion
  linux-user: Add getcpu() support

 accel/tcg/translate-all.c |  50 ++++++++-----
 accel/tcg/user-exec.c     |  52 +++++++-------
 hw/core/Makefile.objs     |   5 +-
 hw/core/qdev-fw.c         |  96 +++++++++++++++++++++++++
 hw/core/qdev.c            |  77 --------------------
 linux-user/elfload.c      |   3 +-
 linux-user/main.c         |   9 ++-
 linux-user/mmap.c         |   2 +-
 linux-user/syscall.c      | 177 +++++++++++++++++++++++++++++++++++++++++-----
 linux-user/syscall_defs.h |   6 +-
 10 files changed, 328 insertions(+), 149 deletions(-)
 create mode 100644 hw/core/qdev-fw.c

-- 
2.14.3
