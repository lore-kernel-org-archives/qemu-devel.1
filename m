Received: from eggs.gnu.org ([2001:4830:134:3::10]:37897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eazB0-0000ix-RD
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:27:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eazAw-0000cK-U1
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:27:26 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 15 Jan 2018 18:27:13 +1100
Message-Id: <20180115072715.25921-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 0/2] Further VSMT fixes
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

David Gibson (2):
  target/ppc: Clarify compat mode max_threads value
  spapr: Adjust default VSMT value for better migration compatibility

 hw/ppc/spapr.c      | 15 ++++++++++-----
 target/ppc/compat.c | 25 +++++++++++++++++--------
 target/ppc/cpu.h    |  2 +-
 3 files changed, 28 insertions(+), 14 deletions(-)

-- 
2.14.3
