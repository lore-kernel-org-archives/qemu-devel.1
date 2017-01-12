Received: from eggs.gnu.org ([2001:4830:134:3::10]:44370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cRjnc-0000Vt-0f
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cRjnX-0005JE-W3
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:31 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:51689)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cRjnX-0005IM-L3
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:27 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 12 Jan 2017 19:08:17 +0100
Message-Id: <1484244501-20283-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/4] M68k for 2.9 patches
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

The following changes since commit 4201e616c0fa48de99a505a6ade979f0c2c65e28:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-audio-20170111-1' into staging (2017-01-12 15:57:18 +0000)

are available in the git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.9-pull-request

for you to fetch changes up to ad9075ac2cc6cfe4003f5e47d421c0e5b2ad08a3:

  m68k: Remove PCI and USB from config file (2017-01-12 18:49:09 +0100)

----------------------------------------------------------------
This is the list of the remaining patches that was part of series 
reviewed during the freeze period. They use the new new deposit
and extract ops.
There is also a cleanup patch from Thomas.
----------------------------------------------------------------

Richard Henderson (3):
  target-m68k: Implement bitfield ops for registers
  target-m68k: Implement bitfield ops for memory
  target-m68k: Implement bfffo

Thomas Huth (1):
  m68k: Remove PCI and USB from config file

 default-configs/m68k-softmmu.mak |   2 -
 target/m68k/cpu.h                |   1 +
 target/m68k/helper.h             |  10 +
 target/m68k/op_helper.c          | 206 +++++++++++++++++++++
 target/m68k/translate.c          | 387 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 603 insertions(+), 3 deletions(-)

-- 
2.7.4
