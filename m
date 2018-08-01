Received: from eggs.gnu.org ([2001:4830:134:3::10]:34183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkiDG-0000ys-JB
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 23:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkiDF-0005wH-Pw
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 23:54:14 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Aug 2018 13:53:55 +1000
Message-Id: <20180801035357.7804-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/2] ppc-for-3.0 queue 20180801
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit f7502360397d291be04bc040e9f96c92ff2d8030:

  Update version for v3.0.0-rc3 release (2018-07-31 19:30:17 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180801

for you to fetch changes up to 6484ab3dffadc79020a71376010f517d60b81b83:

  sam460ex: Fix PCI interrupts with multiple devices (2018-08-01 11:01:38 +1000)

----------------------------------------------------------------
ppc patch queue for 2018-08-01

Here are a final couple of fixes for the 3.0 release.

----------------------------------------------------------------
BALATON Zoltan (1):
      sam460ex: Fix PCI interrupts with multiple devices

Thomas Huth (1):
      hw/misc/macio: Fix device introspection problems in macio devices

 hw/misc/macio/cuda.c  |  5 ++---
 hw/misc/macio/macio.c | 24 ++++++++----------------
 hw/misc/macio/pmu.c   |  5 ++---
 hw/ppc/ppc440_pcix.c  | 21 ++++++++-------------
 hw/ppc/sam460ex.c     |  6 ++----
 5 files changed, 22 insertions(+), 39 deletions(-)
