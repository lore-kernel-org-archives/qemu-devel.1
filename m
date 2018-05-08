Received: from eggs.gnu.org ([2001:4830:134:3::10]:43164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG8Te-0006vJ-14
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG8Ta-0002UO-OL
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:40:46 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50697)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fG8Ta-0002SJ-Ey
	for qemu-devel@nongnu.org; Tue, 08 May 2018 15:40:42 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  8 May 2018 21:40:21 +0200
Message-Id: <20180508194026.1281-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/5] linux-user: fix sparc32plus
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

This series fixes several problems with sparc and
allows to debootstrap a chroot using qemu-sparc32plus and
debian sparc/wheezy.

For the moment, networking doesn't work.

Laurent Vivier (5):
  linux-user: define correct fcntl() values for sparc
  linux-user: fix flock/flock64 padding
  linux-user: update sparc/syscall_nr.h to linux header 4.16
  linux-user: fix convertion of flock/flock64 l_type field
  linux-user: add sparc/sparc64 specific errno

 linux-user/sparc/syscall_nr.h       |  32 +++++-
 linux-user/sparc/target_syscall.h   | 203 ++++++++++++++++++++++++++++++++++++
 linux-user/sparc64/syscall_nr.h     |  20 ++--
 linux-user/sparc64/target_syscall.h | 203 ++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c                |  48 ++++++---
 linux-user/syscall_defs.h           |  25 ++++-
 6 files changed, 504 insertions(+), 27 deletions(-)

-- 
2.14.3
