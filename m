Received: from eggs.gnu.org ([2001:4830:134:3::10]:39988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNoj-0003sW-VQ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNog-0007Rw-TB
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:26 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:17844)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNog-0007QL-NI
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:22 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Fri, 21 Jul 2017 03:37:01 +0100
Message-ID: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 00/14] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 25d0233c1ac6cd14a15fcc834f1de3b179037b1d:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20170720-pull-request' into staging (2017-07-20 16:40:01 +0100)

are available in the git repository at:

  git://github.com/yongbok/upstream-qemu.git tags/mips-20170721

for you to fetch changes up to bad63a8008a0aaefcd00542c89bee01623d7c9de:

  target/mips: Enable CP0_EBase.WG on MIPS64 CPUs (2017-07-21 03:23:44 +0100)

----------------------------------------------------------------
MIPS patches 2017-07-21

Changes:
* Add Enhanced Virtual Addressing (EVA) support

----------------------------------------------------------------


James Hogan (14):
  target/mips: Fix MIPS64 MFC0 UserLocal on BE host
  target/mips: Fix TLBWI shadow flush for EHINV,XI,RI
  target/mips: Weaken TLB flush on UX,SX,KX,ASID changes
  target/mips: Add CP0_Ebase.WG (write gate) support
  target/mips: Prepare loads/stores for EVA
  target/mips: Decode MIPS32 EVA load & store instructions
  target/mips: Decode microMIPS EVA load & store instructions
  target/mips: Check memory permissions with mem_idx
  target/mips: Abstract mmu_idx from hflags
  target/mips: Add an MMU mode for ERL
  target/mips: Add segmentation control registers
  target/mips: Implement segmentation control
  target/mips: Add EVA support to P5600
  target/mips: Enable CP0_EBase.WG on MIPS64 CPUs

 target/mips/cpu.h            |  58 ++++++-
 target/mips/helper.c         | 224 ++++++++++++++++++------
 target/mips/helper.h         |   3 +
 target/mips/machine.c        |   9 +-
 target/mips/op_helper.c      |  64 ++++++-
 target/mips/translate.c      | 405 ++++++++++++++++++++++++++++++++++++++-----
 target/mips/translate_init.c |  17 +-
 7 files changed, 660 insertions(+), 120 deletions(-)

-- 
2.7.4
