Received: from eggs.gnu.org ([2001:4830:134:3::10]:60383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMxW-0005wm-45
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMxT-00037y-2d
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:48:26 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Nov 2017 15:48:11 +1100
Message-Id: <20171122044814.3001-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/3] ppc-for-2.11 queue 20171122
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit a15d835f00dce270fd3194e83d9910f4b5b44ac0:

  Update version for v2.11.0-rc2 release (2017-11-21 17:50:36 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171122

for you to fetch changes up to 6dd836f5d32b989e18c6dda655a26f4d73a52f6a:

  ppc: fix VTB migration (2017-11-22 15:28:37 +1100)

----------------------------------------------------------------
ppc patch queue 2017-11-22

Several more fixes to merge for qemu-2.11.

----------------------------------------------------------------
David Gibson (1):
      spapr: Implement bug in spapr-vty device to be compatible with PowerVM

Laurent Vivier (1):
      ppc: fix VTB migration

Thomas Huth (1):
      hw/ppc/spapr: Fix virtio-scsi bootindex handling for LUNs >= 256

 hw/char/spapr_vty.c         | 18 ++++++++++++++++++
 hw/ppc/spapr.c              |  4 ++++
 target/ppc/translate_init.c |  4 ++--
 3 files changed, 24 insertions(+), 2 deletions(-)
