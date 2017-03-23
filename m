Received: from eggs.gnu.org ([2001:4830:134:3::10]:35137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cqzhs-0004gB-P2
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cqzhp-00067g-LL
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:11:00 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 23 Mar 2017 21:10:47 +1100
Message-Id: <20170323101048.24848-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/1] ppc-for-2.9 queue 20170323
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 55a19ad8b2d0797e3a8fe90ab99a9bb713824059:

  Update version for v2.9.0-rc1 release (2017-03-21 17:13:29 +0000)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170323

for you to fetch changes up to 55641213fc81cdfc3bcd56c9e9991faa119201b2:

  numa,spapr: align default numa node memory size to 256MB (2017-03-22 11:32:42 +1100)

----------------------------------------------------------------
ppc patch queue for 2017-03-23

Just a single bugfix in this batch.  It's not strictly in ppc code,
though it's for the pseries machine's benefit.  Eduardo suggested it
go through my tree however.

----------------------------------------------------------------
Laurent Vivier (1):
      numa,spapr: align default numa node memory size to 256MB

 hw/core/machine.c   | 5 +++++
 hw/ppc/spapr.c      | 6 ++++++
 include/hw/boards.h | 1 +
 numa.c              | 6 +++---
 4 files changed, 15 insertions(+), 3 deletions(-)
