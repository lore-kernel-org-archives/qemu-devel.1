Received: from eggs.gnu.org ([2001:4830:134:3::10]:41569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIEB4-0005xf-2T
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIEB3-0000rq-65
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:05:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 23:05:31 +1000
Message-Id: <20170606130534.11019-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC 0/3] spapr: DRC cleanups (part IV)
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

This is an RFC draft of the fourth batch of DRC cleanup patches.

This is RFC because patches 2&3 are making the first real changes to
the DRC state management, and I'm substantially less confident about
this than the earlier more straightforward cleanups.  Especially since
I haven't had a chance to test this yet.

This gets rid of 'signalled', one of what looks to me like an
excessive number of state variables we have currently.  AFAICT it's
there only as a workaround for a pre-existing oddity in state
management.

David Gibson (3):
  spapr: Fold spapr_phb_add_pci_device() into its only caller
  spapr: Start hotplugged PCI devices in ISOLATED state
  spapr: Eliminate DRC 'signalled' state variable

 hw/ppc/spapr_drc.c         | 55 +---------------------------------------------
 hw/ppc/spapr_events.c      | 10 ---------
 hw/ppc/spapr_pci.c         | 53 +++++++++++++++++++-------------------------
 include/hw/ppc/spapr_drc.h |  2 --
 4 files changed, 23 insertions(+), 97 deletions(-)

-- 
2.9.4
