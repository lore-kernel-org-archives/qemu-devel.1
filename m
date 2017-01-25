Received: from eggs.gnu.org ([2001:4830:134:3::10]:33171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWVYj-0006nM-Js
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 16:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWVYg-0003Yl-Jq
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 16:56:53 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:55546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cWVYg-0003YF-9T
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 16:56:50 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 25 Jan 2017 22:56:34 +0100
Message-Id: <20170125215637.2992-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 0/3] linux-user: some patches for hppa
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

v2:
    added the hppa UTS machine name fix
    added R-b and T-b

Laurent Vivier (3):
  linux-user: add hppa magic numbers in qemu-binfmt-conf.sh
  linux-user: fix "apt-get update" on linux-user hppa
  linux-user: define correct UTS machine name for hppa

 linux-user/syscall.c        | 1 -
 linux-user/uname.c          | 2 ++
 scripts/qemu-binfmt-conf.sh | 9 +++++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.9.3
