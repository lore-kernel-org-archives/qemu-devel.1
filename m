Received: from eggs.gnu.org ([2001:4830:134:3::10]:36233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f3JJr-0000ox-1P
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f3JJn-00043B-Ui
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:37:39 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:47173)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f3JJn-00041e-Jl
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:37:35 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  3 Apr 2018 12:35:37 +0200
Message-Id: <20180403103540.7303-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/3] linux-user fixes for -rc2
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

The following changes since commit f184de7553272223d6af731d7d623a7cebf710b5:

  Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-critical-fixes' into staging (2018-03-31 09:42:33 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-2.12-pull-request

for you to fetch changes up to 3ea7f4a226cd3a4d107772569976dbb13400a632:

  linux-user: fix TARGET___O_TMPFILE for sparc (2018-04-03 11:50:24 +0200)

----------------------------------------------------------------
Alpha and sparc32plus have broken signal frame handler.
With these fixes, we can now:
- with alpha target, successfully debootstrap debian sid
- with sparc32plus target, run "ls" in a bash in a chroot without error
----------------------------------------------------------------

Laurent Vivier (3):
  linux-user: fix alpha signal emulation
  linux-user: define TARGET_ARCH_HAS_KA_RESTORER
  linux-user: fix TARGET___O_TMPFILE for sparc

 linux-user/signal.c       | 8 ++++----
 linux-user/syscall.c      | 7 +++++--
 linux-user/syscall_defs.h | 5 +++++
 3 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.14.3
