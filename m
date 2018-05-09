Received: from eggs.gnu.org ([2001:4830:134:3::10]:34917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fGYFY-0007z4-Jn
	for qemu-devel@nongnu.org; Wed, 09 May 2018 19:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fGYFU-0002fm-Ie
	for qemu-devel@nongnu.org; Wed, 09 May 2018 19:11:56 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:53741)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fGYFU-0002dj-AK
	for qemu-devel@nongnu.org; Wed, 09 May 2018 19:11:52 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 10 May 2018 01:11:17 +0200
Message-Id: <20180509231123.20864-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 0/6] linux-user: fix sparc32plus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Eric Blake <eblake@redhat.com>

This series fixes several problems with sparc and
allows to debootstrap a chroot using qemu-sparc32plus and
debian sparc/wheezy.

For the moment, networking doesn't work.

v2:
   - Add a patch to fix UNAME_MACHINE
   - move sparc errno definitions to linux-user/sparc/target_errno.h
   - add common switch macro to convert flock l_type to/from target
     to/from host
   - return -TARGET_EINVAL is l_type cannot be converted

Laurent Vivier (6):
  linux-user: define correct fcntl() values for sparc
  linux-user: fix flock/flock64 padding
  linux-user: update sparc/syscall_nr.h to linux header 4.16
  linux-user: fix conversion of flock/flock64 l_type field
  linux-user: add sparc/sparc64 specific errno
  linux-user: fix UNAME_MACHINE for sparc/sparc64

 linux-user/sparc/syscall_nr.h       |  32 +++++-
 linux-user/sparc/target_errno.h     | 207 ++++++++++++++++++++++++++++++++++++
 linux-user/sparc/target_syscall.h   |   4 +-
 linux-user/sparc64/syscall_nr.h     |  20 ++--
 linux-user/sparc64/target_syscall.h |   5 +-
 linux-user/syscall.c                |  66 ++++++++----
 linux-user/syscall_defs.h           |  25 ++++-
 7 files changed, 326 insertions(+), 33 deletions(-)
 create mode 100644 linux-user/sparc/target_errno.h

-- 
2.14.3
