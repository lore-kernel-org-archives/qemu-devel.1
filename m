Received: from eggs.gnu.org ([2001:4830:134:3::10]:38000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIRWJ-0003Zx-5Q
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIRWH-0002Tr-WE
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:20:31 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  7 Jun 2017 13:20:11 +1000
Message-Id: <20170607032018.19588-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 0/7] spapr: DRC cleanups (part III)
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

A third batch of cleanups to the DRC code.  This continues to clear
away relatively simple cruft, to get a clearer look at the fundamental
state handling.

Changes since v1:
  * Some comment updates suggested by Mike Roth
  * Changed approach to the get_name cleanup, using generated on the
    fly names, instead of externally assigned names
  * Added in some cleanups to hotplug code in spapr_pci.c

David Gibson (7):
  spapr: Clean up DR entity sense handling
  spapr: Don't misuse DR-indicator in spapr_recover_pending_dimm_state()
  spapr: Clean up RTAS set-indicator
  spapr: Clean up handling of DR-indicator
  spapr: Change DRC attach & detach methods to functions
  spapr: Fold spapr_phb_{add,remove}_pci_device() into their only
    callers
  spapr: Rework DRC name handling

 hw/ppc/spapr.c             |  30 ++---
 hw/ppc/spapr_drc.c         | 269 ++++++++++++++++++++-------------------------
 hw/ppc/spapr_pci.c         |  72 +++++-------
 hw/ppc/trace-events        |   5 +-
 include/hw/ppc/spapr_drc.h |  30 ++---
 5 files changed, 171 insertions(+), 235 deletions(-)

-- 
2.9.4
