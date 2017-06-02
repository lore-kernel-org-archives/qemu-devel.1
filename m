Received: from eggs.gnu.org ([2001:4830:134:3::10]:43506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGh1z-0008Rf-Id
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGh1y-0006it-NY
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:29:59 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  2 Jun 2017 17:29:47 +1000
Message-Id: <20170602072952.25454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 0/5] spapr: DRC cleanups (part II)
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

Having merged my first batch of cleanups for the DRC code, this series
contains a second batch.

This adds the long-discussed QOM subtypes for different PAPR DRC
types.  It still only makes partial use of the QOM type structure, but
it's a start.  It also removes the artificial separation between
configure-connector and DRC state, which simplifies a number of things.

David Gibson (5):
  spapr: Introduce DRC subclasses
  spapr: Clean up spapr_dr_connector_by_*()
  spapr: Move configure-connector state into DRC
  spapr: Eliminate spapr_drc_get_type_str()
  spapr: Remove some non-useful properties on DRC objects

 hw/ppc/spapr.c             |  37 +++---
 hw/ppc/spapr_drc.c         | 275 +++++++++++++++++++--------------------------
 hw/ppc/spapr_events.c      |   2 +-
 hw/ppc/spapr_pci.c         |   9 +-
 include/hw/ppc/spapr.h     |  14 ---
 include/hw/ppc/spapr_drc.h |  60 +++++++++-
 6 files changed, 189 insertions(+), 208 deletions(-)

-- 
2.9.4
