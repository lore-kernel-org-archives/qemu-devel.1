Received: from eggs.gnu.org ([2001:4830:134:3::10]:56444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dc2Ia-0005uI-2w
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 00:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dc2IZ-0003VK-7V
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 00:27:20 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 31 Jul 2017 14:27:08 +1000
Message-Id: <20170731042710.19924-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/2] ppc-for-2.10 queue 20170731
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, agraf@suse.de, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit a588c4985eff363154d65aee8607d0a4601655f7:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-07-28' into staging (2017-07-28 18:17:44 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170731

for you to fetch changes up to fc7e0765fc385eed08c19a8823a970f4e98379b0:

  Revert "spapr: populate device tree depending on XIVE_EXPLOIT option" (2017-07-29 16:22:14 +1000)

----------------------------------------------------------------
ppc patch queue 2017-07-31

This has a couple of last minute bugfixes for qemu 2.10.

----------------------------------------------------------------
David Gibson (1):
      Revert "spapr: populate device tree depending on XIVE_EXPLOIT option"

Greg Kurz (1):
      spapr_drc: fix realize and unrealize

 hw/ppc/spapr.c     | 10 ++++------
 hw/ppc/spapr_drc.c | 15 ++++++---------
 2 files changed, 10 insertions(+), 15 deletions(-)
