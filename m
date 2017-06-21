Received: from eggs.gnu.org ([2001:4830:134:3::10]:40346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNbmu-0003By-Fo
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNbmt-0001yL-JE
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 05:19:00 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 21 Jun 2017 17:18:43 +0800
Message-Id: <20170621091848.28256-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 0/5] spapr: DRC cleanups (part VI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: bharata@linux.vnet.ibm.com, groug@kaod.org, sursingh@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This sixth set of DRC cleanup patches (to be applied on top of the
patches from part V) is a complete rework of DRC state management.  We
stop tracking some unnecessary things, and change the basic state
representation to a simpler and more robust model.

Most of the patches in this set "break" migration from earlier git
snapshots, but not from any released qemu version.  The previous
migration stream format had multiple problems, so better to fix them
now, before 2.10 is out.

David Gibson (5):
  spapr: Remove 'awaiting_allocation' DRC flag
  spapr: Refactor spapr_drc_detach()
  spapr: Cleanups relating to DRC awaiting_release field
  spapr: Consolidate DRC state variables
  spapr: Remove sPAPRConfigureConnectorState sub-structure

 hw/ppc/spapr.c             |   9 +-
 hw/ppc/spapr_drc.c         | 321 +++++++++++++++++++++------------------------
 hw/ppc/spapr_pci.c         |  13 +-
 hw/ppc/trace-events        |   3 +-
 include/hw/ppc/spapr_drc.h |  53 +++++---
 5 files changed, 187 insertions(+), 212 deletions(-)

-- 
2.9.4
