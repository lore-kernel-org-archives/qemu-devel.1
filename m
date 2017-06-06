Received: from eggs.gnu.org ([2001:4830:134:3::10]:55006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI9ul-0003Ox-8f
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI9uf-00021J-LP
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:32:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 18:32:14 +1000
Message-Id: <20170606083221.9299-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 0/7] spapr: DRC cleanups (part III)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, David Gibson <david@gibson.dropbear.id.au>

A third batch of cleanups to the DRC code.  This continues to clear
away relatively simple cruft, to get a clearer look at the fundamental
state handling.

David Gibson (7):
  spapr: Clean up DR entity sense handling
  spapr: Abolish DRC get_name method
  spapr: Assign DRC names from owners
  spapr: Don't misuse DR-indicator in spapr_recover_pending_dimm_state()
  spapr: Clean up RTAS set-indicator
  spapr: Clean up handling of DR-indicator
  spapr: Change DRC attach & detach methods to functions

 hw/ppc/spapr.c             |  46 ++++----
 hw/ppc/spapr_drc.c         | 263 +++++++++++++++++++--------------------------
 hw/ppc/spapr_pci.c         |  44 ++++++--
 hw/ppc/trace-events        |   5 +-
 include/hw/ppc/spapr_drc.h |  33 +++---
 5 files changed, 183 insertions(+), 208 deletions(-)

-- 
2.9.4
