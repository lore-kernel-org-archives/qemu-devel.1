Received: from eggs.gnu.org ([2001:4830:134:3::10]:34640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dLPxw-0007uH-26
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dLPxs-0001uL-49
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:17:20 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:52963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dLPxr-0001ty-OR
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:17:16 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 15 Jun 2017 10:17:07 +0200
Message-Id: <20170615081711.25347-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 0/4] M68k for 2.10 patches
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

The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b3ae91:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170613' into staging (2017-06-13 15:49:07 +0100)

are available in the git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.10-pull-request

for you to fetch changes up to 69e698220f68a17ce9584b068f68ed09e527a6ad:

  target-m68k: define ext_opsize (2017-06-15 09:16:38 +0200)

----------------------------------------------------------------

----------------------------------------------------------------

Laurent Vivier (4):
  target/m68k: fix V flag for CC_OP_SUBx
  softfloat: define 680x0 specific values
  target-m68k: move FPU helpers to fpu_helper.c
  target-m68k: define ext_opsize

 fpu/softfloat-specialize.h |  34 ++++++++++++--
 target/m68k/Makefile.objs  |   2 +-
 target/m68k/fpu_helper.c   | 112 +++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.c       |  88 -----------------------------------
 target/m68k/translate.c    |  45 ++++++++++--------
 5 files changed, 169 insertions(+), 112 deletions(-)
 create mode 100644 target/m68k/fpu_helper.c

-- 
2.9.4
