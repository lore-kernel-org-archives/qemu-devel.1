Received: from eggs.gnu.org ([2001:4830:134:3::10]:37209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIphU-0006Ww-JT
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 01:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIphP-0008Nv-SU
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 01:09:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Jun 2017 15:09:24 +1000
Message-Id: <20170608050930.2613-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 0/6] spapr: DRC cleanups (part IV)
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

This fourth isntallment of cleanups to the DRC code introduces the
first changes to the fundamental state handling.  We change the
initial states in the reset code and attach code for PCI devices, and
are able to remove the 'signalled' state variable with those fixes.

There are also some more mechanical cleanups in preparation for
further cleanups and fixes to the state management.

David Gibson (6):
  spapr: Start hotplugged PCI devices in ISOLATED state
  spapr: Eliminate DRC 'signalled' state variable
  spapr: Split DRC release from DRC detach
  spapr: Make DRC reset force DRC into known state
  spapr: Clean up DRC set_allocation_state path
  spapr: Clean up DRC set_isolation_state() path

 hw/ppc/spapr.c             |  15 --
 hw/ppc/spapr_drc.c         | 363 +++++++++++++++++++++++----------------------
 hw/ppc/spapr_events.c      |  10 --
 include/hw/ppc/spapr_drc.h |  10 +-
 4 files changed, 188 insertions(+), 210 deletions(-)

-- 
2.9.4
