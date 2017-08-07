Received: from eggs.gnu.org ([2001:4830:134:3::10]:57471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dekKS-0007xR-LC
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dekKN-0005mW-Mk
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:52:28 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Mon,  7 Aug 2017 17:50:44 +0200
Message-Id: <1502121048-1816-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH for-2.11 0/4] ppc64: add e6500
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, agraf@suse.de
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, frederic.konrad@adacore.com

Hi,

Those are some patches to add basic e6500 support for the moment e5500 with a
correct MMU configuration and supported instructions.
Some (maybe a lot of) things are missing (ie: the thread support) but it is
enough to boot a propietary OS on my side.

The first two patches are fixes when using MAV 2.0 MMU.
The two last patches introduces the e6500.

This can be cloned here:
https://github.com/FredKonrad/qemu.git branch e6500

Thanks,
Fred

KONRAD Frederic (4):
  booke206: fix booke206_tlbnps for mav 2.0
  booke206: fix tlbnps for fixed size TLB
  booke206: allow to specify an mmucfg value at the init
  ppc64: introduce e6500

 target/ppc/cpu-models.c     |   2 +
 target/ppc/cpu-models.h     |   1 +
 target/ppc/cpu.h            |  26 +++++++++++-
 target/ppc/mmu_helper.c     |  16 ++++---
 target/ppc/translate_init.c | 100 +++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 132 insertions(+), 13 deletions(-)

-- 
1.8.3.1
