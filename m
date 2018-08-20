Received: from eggs.gnu.org ([2001:4830:134:3::10]:52159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frqlr-0003MF-98
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frqll-0004CA-PO
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:27:27 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:42009)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1frqld-0003eF-9F
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:27:16 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 20 Aug 2018 22:25:57 +0200
Message-Id: <20180820202604.14218-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/7] Linux user for 3.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

The following changes since commit 0abaa41d936becd914a16ee1fe2a981d96d19428:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-08-17 09:46:00 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-3.1-pull-request

for you to fetch changes up to 70c61d4f78cc8475b597f1ef26faf232302b81d1:

  linux-user: add QEMU_IFLA_INFO_KIND nested type for tun (2018-08-20 22:07:40 +0200)

----------------------------------------------------------------
linux-user fixes:
- netlink fixes (add missing types, fix MSG_TRUNC)
- sh4 fix (tcg state)
- sparc32plus fix (truncate address space to 32bit)
- add x86_64 binfmt data

----------------------------------------------------------------

Laurent Vivier (7):
  qemu-binfmt-conf.sh: add x86_64 target
  linux-user: fix 32bit g2h()/h2g()
  sh4: fix use_icount with linux-user
  linux-user: fix recvmsg()/recvfrom() with netlink and MSG_TRUNC
  linux-user: introduce QEMU_RTA_* to use with rtattr_type_t
  linux-user: update netlink route types
  linux-user: add QEMU_IFLA_INFO_KIND nested type for tun

 include/exec/cpu_ldst.h                   |  23 +++-
 include/exec/cpu_ldst_useronly_template.h |  12 +-
 linux-user/syscall.c                      | 134 +++++++++++++++++++---
 scripts/qemu-binfmt-conf.sh               |   6 +-
 target/sh4/translate.c                    |   1 +
 5 files changed, 150 insertions(+), 26 deletions(-)

-- 
2.17.1
