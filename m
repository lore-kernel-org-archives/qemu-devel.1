Received: from eggs.gnu.org ([2001:4830:134:3::10]:44601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEFi-00084E-Mf
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEFf-0003Qa-ID
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:45:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 18 May 2017 15:45:19 +1000
Message-Id: <20170518054522.13141-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 0/3] pseries: Reverse behaviour change for
 older machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: abologna@redhat.com, thuth@redhat.com, lvivier@redhat.com
Cc: mdroth@linux.vnet.ibm.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

152ef80 "pseries: Rewrite CAS PVR compatibility logic" incorrectly
introduced a guest-visible behaviour change into existing versioned
machine type.  Patch 2/2 corrects this change, while 1/2 is a
preliminary clean up to make that easier.

Unfortunately, this bug is already in the released qemu-2.9.0.  Once
this is ready to merge for master, I'll make a backport to apply for
2.9.1 as well.

Changes since RFC:
 * Corrected serious bug in vector address calculation which would
   have broken all the rest of the CAS process
 * Added a third patch with tracing cleanup
 * Correct error in commit message

David Gibson (3):
  pseries: Split CAS PVR negotiation out into a separate function
  pseries: Restore PVR negotiation logic for pre-2.9 machine types
  pseries: Improve tracing of CPU compatibility negotiation

 hw/ppc/spapr.c         |   3 ++
 hw/ppc/spapr_hcall.c   | 141 ++++++++++++++++++++++++++++++++++++++++++-------
 hw/ppc/trace-events    |   6 ++-
 include/hw/ppc/spapr.h |   1 +
 4 files changed, 131 insertions(+), 20 deletions(-)

-- 
2.9.4
