Received: from eggs.gnu.org ([2001:4830:134:3::10]:39757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ciTrd-0001Po-Tn
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ciTrZ-0003pv-2H
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:33:53 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:57853)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ciTrY-0003iR-O3
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:33:49 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 27 Feb 2017 23:33:31 +0100
Message-Id: <20170227223337.17434-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/6] Linux user for upstream patches
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

The following changes since commit 8f2d7c341184a95d05476ea3c45dbae2b9ddbe51:

  Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-02-27-1' into staging (2017-02-27 15:33:21 +0000)

are available in the git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-upstream-pull-request

for you to fetch changes up to 98a3331a552f6e033da10bd07b14ccdd81d05e61:

  syscall: fixed mincore(2) not failing with ENOMEM (2017-02-27 23:10:02 +0100)

----------------------------------------------------------------
Tested with ltp-full-20170116, target ppc, host x86_64,
debian version 8.7

Total Tests: 1111
Total Skipped Tests: 174
Total Failures: 67
Kernel Version: 4.9.10-200.fc25.x86_64
Machine Architecture: ppc

Changes since last pull request:
-mincore01                      FAIL       1    
+mincore01                      PASS       0    

[tested on top of 2f16960, as 3725794 is broken]
----------------------------------------------------------------

Franklin \"Snaipe\" Mathieu (1):
  syscall: fixed mincore(2) not failing with ENOMEM

Helge Deller (1):
  linux-user: Add sockopts for IPv6 ping and IPv6 traceroute

Laurent Vivier (2):
  linux-user: fix fork()
  linux-user: correctly manage SR in ucontext

Michael Karcher (1):
  linux-user: fix do_rt_sigreturn on m68k linux userspace emulation

Pranith Kumar (1):
  linux-user: Add signal handling support for x86_64

 linux-user/signal.c       | 286 +++++++++++++++++++++++++++++++++++++---------
 linux-user/syscall.c      | 148 +++++++++++++++++++++++-
 linux-user/syscall_defs.h |   8 ++
 target/i386/cpu.h         |   2 +
 target/i386/fpu_helper.c  |  12 ++
 5 files changed, 395 insertions(+), 61 deletions(-)

-- 
2.9.3
