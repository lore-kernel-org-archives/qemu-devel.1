Received: from eggs.gnu.org ([2001:4830:134:3::10]:47376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWf3R-0005jn-FW
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWf3M-0003dP-IA
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:05:13 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:50717)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cWf3M-0003bQ-8d
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:05:08 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 26 Jan 2017 09:04:46 +0100
Message-Id: <20170126080449.28255-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v3 0/3] linux-user: some patches for hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

This short series enables hppa in qemu-binfmt-conf.sh, and fixes
a bug in the netlink functions that has been found by Adrian Glaubitz
while he was testing a debian chroot with qemu-hppa. I think the problem
doesn't appear on other architectures I have tested as they should use
NR_socketcall syscall instead of NR_socket syscall.

v3:
    fix UNAME_MACHINE instead of cpu_to_uname_machine()

v2:
    added the hppa UTS machine name fix
    added R-b and T-b

Laurent Vivier (3):
  linux-user: add hppa magic numbers in qemu-binfmt-conf.sh
  linux-user: fix "apt-get update" on linux-user hppa
  linux-user: define correct UTS machine name for hppa

 linux-user/hppa/target_syscall.h | 2 +-
 linux-user/syscall.c             | 1 -
 scripts/qemu-binfmt-conf.sh      | 9 +++++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.9.3
