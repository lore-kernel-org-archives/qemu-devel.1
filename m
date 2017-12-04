Received: from eggs.gnu.org ([2001:4830:134:3::10]:48318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLhjn-0005Yv-2C
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 22:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLhjl-0004LV-SV
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 22:48:11 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Dec 2017 14:47:59 +1100
Message-Id: <20171204034802.7336-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/3] ppc-for-2.11 queue 20171204
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit c11d61271b9e6e7a1f0479ef1ca8fb55fa457a62:

  Update version for v2.11.0-rc3 release (2017-11-29 17:59:34 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171204

for you to fetch changes up to 768a20f3a491ed4afce73ebb65347d55251c0ebd:

  spapr: Include "pre-plugged" DIMMS in ram size calculation at reset (2017-12-04 11:31:22 +1100)

----------------------------------------------------------------
ppc patch queue 2017-12-04

We are, alas, not yet to the bottom of ppc bugs.  This pull request
fixes several more.  I believe they're important enough to include in
2.11. despite the late date.

----------------------------------------------------------------
David Gibson (1):
      spapr: Include "pre-plugged" DIMMS in ram size calculation at reset

Kurban Mallachiev (1):
      target-ppc: Don't invalidate non-supported msr bits

Laurent Vivier (1):
      pseries: fix TCG migration

 hw/ppc/spapr.c       | 7 +++++--
 target/ppc/machine.c | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)
