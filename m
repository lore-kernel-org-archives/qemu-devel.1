Received: from eggs.gnu.org ([2001:4830:134:3::10]:42326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJB3b-00055M-8i
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 23:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJB3a-00026L-Ck
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 23:30:11 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 27 Nov 2017 15:30:01 +1100
Message-Id: <20171127043003.15034-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/2] ppc-for-2.11 queue 20171127
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: surajjs@au1.ibm.com, agraf@suse.de, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit e7b47c22e2df14d55e3e4426688c929bf8e3f7fb:

  osdep.h: Make TIME_MAX handle different time_t types (2017-11-24 13:23:36 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171127

for you to fetch changes up to e07cc1929515cfb808b5c2fcc60c079e6be110cf:

  target/ppc: Fix setting of cpu->compat_pvr on incoming migration (2017-11-27 12:20:11 +1100)

----------------------------------------------------------------
ppc patch queue 2017-11-27

This series contains a couple of migration fixes for hash guests on
POWER9 radix MMU hosts.

----------------------------------------------------------------
Suraj Jitindar Singh (2):
      target/ppc: Move setting of patb_entry on hash table init
      target/ppc: Fix setting of cpu->compat_pvr on incoming migration

 hw/ppc/spapr.c       | 4 ++--
 target/ppc/machine.c | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)
