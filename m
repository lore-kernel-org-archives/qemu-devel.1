Received: from eggs.gnu.org ([2001:4830:134:3::10]:37396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cLvwy-0008UM-TJ
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cLvwu-00006w-3G
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:54:12 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:60230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cLvwt-00006o-Or
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 12:54:08 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 27 Dec 2016 18:53:49 +0100
Message-Id: <1482861241-17678-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 00/12] M68k for 2.9 patches
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

The following changes since commit e5fdf663cf01f824f0e29701551a2c29554d80a4:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20161223' into staging (2016-12-27 14:56:47 +0000)

are available in the git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.9-pull-request

for you to fetch changes up to 2b5e2170678af36df48ab4b05dff81fe40b41a65:

  target-m68k: free TCG variables that are not (2016-12-27 18:28:40 +0100)

----------------------------------------------------------------
A series of patches queued since the beginning of the freeze period.
Compared to the m68k-for-2.9 branch, 3 patches implementing bitfield
ops are missing as they need new TCG functions. They will be pushed
later.
v2: remove warning for unused variables.
----------------------------------------------------------------

Laurent Vivier (8):
  target-m68k: add cmpm
  target-m68k: add 64bit mull
  target-m68k: add 680x0 divu/divs variants
  target-m68k: add abcd/sbcd/nbcd
  target-m68k: add cas/cas2 ops
  target-m68k: Implement 680x0 movem
  target-m68k: add rol/ror/roxl/roxr instructions
  target-m68k: free TCG variables that are not

Richard Henderson (4):
  target-m68k: Delay autoinc writeback
  target-m68k: Split gen_lea and gen_ea
  target-m68k: Do not cpu_abort on undefined insns
  target-m68k: Inline shifts

 linux-user/main.c       |    7 +
 target/m68k/cpu.h       |    4 -
 target/m68k/helper.c    |   52 --
 target/m68k/helper.h    |   13 +-
 target/m68k/op_helper.c |  292 ++++++++-
 target/m68k/qregs.def   |    2 -
 target/m68k/translate.c | 1520 +++++++++++++++++++++++++++++++++++++++++------
 7 files changed, 1624 insertions(+), 266 deletions(-)

-- 
2.7.4
