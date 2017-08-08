Received: from eggs.gnu.org ([2001:4830:134:3::10]:51663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dexgt-0001tQ-7C
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dexgo-00033z-9e
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:08:31 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  8 Aug 2017 16:08:15 +1000
Message-Id: <20170808060817.2832-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH for-2.10 0/2] Add some missing POWER9 SPRs for
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, clg@kaod.org
Cc: mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, agraf@suse.de, David Gibson <david@gibson.dropbear.id.au>

This series adds a couple of new POWER9 SPRs: TIDR and PSSCR.

These aren't particularly complete implementations - the registers
aren't all that interesting from a TCG / qemu point of view.  However
having them at least minimally represented means that state is synced
with KVM and migrated, which fixes some bugs.

David Gibson (2):
  target/ppc: Implement TIDR
  target/ppc: Add stub implementation of the PSSCR

 target/ppc/cpu.h            |  2 ++
 target/ppc/translate_init.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

-- 
2.13.4
