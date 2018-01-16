Received: from eggs.gnu.org ([2001:4830:134:3::10]:47910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebJ9j-0007zC-8V
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:47:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebJ9g-0004mR-5P
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:47:27 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 16 Jan 2018 15:47:12 +1100
Message-Id: <20180116044714.12571-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 0/2] Further VSMT fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, joserz@linux.vnet.ibm.com, surajjs@au1.ibm.com, sam.bobroff@au1.ibm.com
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Here are some follow on fixes to Ziviani's proposed changes to VSMT
handling.  This should fix migration of POWER8 compat mode guests
between POWER8 and POWER9 hosts.

The changes are simple, the rationale's rather more complex.

Changes since v2:
  * Dropped one patch, already merged
  * Discovered that the previous version broken running KVM PR in
    almost all cases, even ones that should still be ok
      - Added a new 1/2 patch to address that

David Gibson (2):
  spapr: Allow some cases where we can't set VSMT mode in the kernel
  spapr: Adjust default VSMT value for better migration compatibility

 hw/ppc/spapr.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

-- 
2.14.3
