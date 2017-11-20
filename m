Received: from eggs.gnu.org ([2001:4830:134:3::10]:60633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGer4-00010w-VZ
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 00:42:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGer4-0004AQ-3n
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 00:42:51 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 20 Nov 2017 16:42:37 +1100
Message-Id: <20171120054239.8739-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/2] ppc-for-2.11 queue 20171120
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

The following changes since commit 2e02083438962d26ef9dcc7100f3b378104183db:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-11-17 19:08:07 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171120

for you to fetch changes up to 82512483940c756e2db1bd67ea91b02bc29c5e01:

  spapr: reset DRCs after devices (2017-11-20 10:10:56 +1100)

----------------------------------------------------------------
ppc patch queue 2017-11-20

Here's the current queue of ppc patches.  These 2 patches are both
more complex than I'd ideally like this late in the 2.11 cycle.
However, they do fix important bugs, so I think it's worth it on
balance.

----------------------------------------------------------------
Greg Kurz (1):
      spapr: reset DRCs after devices

Suraj Jitindar Singh (1):
      target/ppc: Update setting of cpu features to account for compat modes

 hw/ppc/spapr.c     | 64 +++++++++++++++++++++++++++++++++++-------------------
 hw/ppc/spapr_drc.c |  7 ------
 2 files changed, 42 insertions(+), 29 deletions(-)
