Received: from eggs.gnu.org ([2001:4830:134:3::10]:41478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eRJsB-0004rr-Hi
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eRJr7-0001C3-7F
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:32:03 -0500
Received: from heinz.dinsnail.net
	([2a01:238:43b4:3200:9392:5dcc:2f0e:a960]:46390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eRJr6-00015z-Bl
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:30:56 -0500
From: Michael Weiser <michael.weiser@gmx.de>
Date: Tue, 19 Dec 2017 16:16:32 +0100
Message-Id: <20171219151636.5162-1-michael.weiser@gmx.de>
Subject: [Qemu-devel] [PATCH 0/4] Add aarch64_be-linux-user target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Weiser <michael.weiser@gmx.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Hello,

below patches add support for big-endian aarch64 to linux-user. Almost
everything is already in place. The patches just set up the CPU flags as
required for big-endianess, add a distinction in uname and make sure the
instructions for the signal trampoline end up in memory little-endian.
Finally, configure is extended to allow building of a
aarch64_be-linux-user target.

With this I am able to run individual aarch64_be binaries as well as
chroot into a full-blown aarch64_be userland using binfmt_misc, running
and compiling things (Gentoo crossdev/native).

Thanks,
Michael

Michael Weiser (4):
  linux-user: Add support for big-endian aarch64
  linux-user: Add separate aarch64_be uname
  linux-user: Fix endianess of aarch64 signal trampoline
  configure: Add aarch64_be-linux-user target

 configure                                 |  9 +++++----
 default-configs/aarch64_be-linux-user.mak |  1 +
 linux-user/aarch64/target_syscall.h       |  4 ++++
 linux-user/main.c                         |  6 ++++++
 linux-user/signal.c                       | 10 +++++++---
 5 files changed, 23 insertions(+), 7 deletions(-)
 create mode 100644 default-configs/aarch64_be-linux-user.mak

-- 
2.15.1
