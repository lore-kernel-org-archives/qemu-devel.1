Received: from eggs.gnu.org ([2001:4830:134:3::10]:45318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkgs-0007Iq-6U
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkgo-0007wu-RO
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:41 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:57320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cKkgo-0007wX-GH
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:38 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 24 Dec 2016 12:40:21 +0100
Message-Id: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 00/12] M68k for 2.9 patches
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

The following changes since commit a470b33259bf82ef2336bfcd5d07640562d3f63b:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2016-12-22 19:23:51 +0000)

are available in the git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.9-pull-request

for you to fetch changes up to ed3c95af3dd314a58a83b83126633e4efbad817b:

  target-m68k: free TCG variables that are not (2016-12-24 12:31:21 +0100)

----------------------------------------------------------------
A series of patches queued since the beginning of the freeze period.
Compared to the m68k-for-2.9 branch, 3 patches implementing bitfield
ops are missing as they need new TCG functions. They will be pushed
later.
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
