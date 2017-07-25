Received: from eggs.gnu.org ([2001:4830:134:3::10]:51531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZseo-0000XI-Gc
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZsen-0006FH-Jz
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:45:22 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 25 Jul 2017 15:45:06 +1000
Message-Id: <20170725054510.15177-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/4] ppc-for-2.10 queue 20170725
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, lvivier@redhat.com, groug@kaod.org, bharata@linux.vnet.ibm.com, thuth@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit b5a74cd81d76cb467552f38f2b39520d07c65ea2:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170724' into staging (2017-07-24 18:15:45 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170725

for you to fetch changes up to 86844c213348a596ea716a44a6f337555e07ad09:

  pseries: Update SLOF firmware image (2017-07-25 14:35:42 +1000)

----------------------------------------------------------------
ppc patch queue 2017-07-25

Last pull request for the 2.10 hard freeze, and correspondingly small.
There are a handful of bugfixes here plus an update for the "pseries"
guest firmware (SLOF).

This is later than ideal for a guest firmware update.  However, this
does include a number of fixes in that guest firmware, so I think it's
worth the risk of squeezing this in just before the hard freeze.

----------------------------------------------------------------
Alexey Kardashevskiy (2):
      spapr_pci: Fix obsolete comment about MSIX encoding in addr/data
      pseries: Update SLOF firmware image

Bharata B Rao (1):
      spapr: Fix QEMU abort during memory unplug

Laurent Vivier (1):
      spapr/htab: fix savevm

 hw/ppc/spapr.c     |  40 +++++++++++++++++++++++-----------------
 hw/ppc/spapr_pci.c |   4 +---
 pc-bios/README     |   2 +-
 pc-bios/slof.bin   | Bin 902120 -> 905200 bytes
 roms/SLOF          |   2 +-
 5 files changed, 26 insertions(+), 22 deletions(-)
