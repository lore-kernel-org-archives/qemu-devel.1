Received: from eggs.gnu.org ([2001:4830:134:3::10]:40343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWULr-0005hy-IO
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:39:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWULp-0007bA-1R
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:39:31 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:51061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cWULk-0007QG-Cp
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:39:28 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 25 Jan 2017 21:38:50 +0100
Message-Id: <20170125203852.19254-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/2] linux-user: some patches for hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Laurent Vivier <laurent@vivier.eu>

This short series enables hppa in qemu-binfmt-conf.sh, and fixes
a bug in the netlink functions that has been found by Adrian Glaubitz
while he was testing a debian chroot with qemu-hppa. I think the problem
doesn't appear on other architectures I have tested as they should use
NR_socketcall syscall instead of NR_socket syscall.

Laurent Vivier (2):
  linux-user: add hppa magic numbers in qemu-binfmt-conf.sh
  linux-user: fix "apt-get update" on linux-user hppa

 linux-user/syscall.c        | 1 -
 scripts/qemu-binfmt-conf.sh | 9 +++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.9.3
