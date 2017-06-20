Received: from eggs.gnu.org ([2001:4830:134:3::10]:60124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dN8Mb-0005pU-II
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 21:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dN8MX-0004Bl-1Z
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 21:53:53 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 20 Jun 2017 09:53:27 +0800
Message-Id: <20170620015332.13874-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 0/5] spapr: DRC cleanups (part V)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This fifth set of cleanups to the DRC code mostly deals with removing
unnecessary differences between different cases on the various hot
plug and unplug paths.

David Gibson (5):
  spapr: Leave DR-indicator management to the guest
  spapr: Uniform DRC reset paths
  spapr: Add DRC release method
  spapr: Remove unnecessary differences between hotplug and coldplug
    paths
  spapr: Use unplug_request for PCI hot unplug

 hw/ppc/spapr.c             | 44 +++++++-------------------------------------
 hw/ppc/spapr_drc.c         | 37 ++++++++++++-------------------------
 hw/ppc/spapr_pci.c         | 10 +++++-----
 include/hw/ppc/spapr_drc.h |  3 ++-
 4 files changed, 26 insertions(+), 68 deletions(-)

-- 
2.9.4
