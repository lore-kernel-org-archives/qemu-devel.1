Received: from eggs.gnu.org ([209.51.188.92]:55010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDksA-0005gV-Ln
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 03:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDks9-0005BB-RI
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 03:08:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  9 Apr 2019 17:08:28 +1000
Message-Id: <20190409070830.22430-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] ppc-for-4.0 queue 20190409
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, mst@redhat.com, marcel@redhat.com, alex.williamson@redhat.com, clg@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 5263724b78f89cdea2354c8e92c53bac1b4641=
a3:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-04-08 17:53:18 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190409

for you to fetch changes up to 5cf0d326a0fec9ebac2d47c42b5f08e6bc2f686c:

  spapr_pci: Fix extended config space accesses (2019-04-09 15:03:10 +100=
0)

----------------------------------------------------------------
ppc patch queue 2019-04-09

This is a small, hard freeze, pull request which fixes a regression on
the pseries machine handling of PCI-E extended config space accesses.

----------------------------------------------------------------
Greg Kurz (2):
      pci: Allow PCI bus subtypes to support extended config space access=
es
      spapr_pci: Fix extended config space accesses

 hw/pci/pci.c             | 24 ++++++++++++++++++++++++
 hw/pci/pci_host.c        |  2 +-
 hw/ppc/spapr_pci.c       | 28 ++++++++++++++++++++++++++--
 include/hw/pci/pci.h     |  2 ++
 include/hw/pci/pci_bus.h |  1 +
 5 files changed, 54 insertions(+), 3 deletions(-)
