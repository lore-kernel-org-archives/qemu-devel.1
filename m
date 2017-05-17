Received: from eggs.gnu.org ([2001:4830:134:3::10]:59436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAsYz-0005Pa-WB
	for qemu-devel@nongnu.org; Wed, 17 May 2017 02:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAsYw-0005Aa-3L
	for qemu-devel@nongnu.org; Wed, 17 May 2017 02:36:02 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 May 2017 16:35:45 +1000
Message-Id: <20170517063547.23876-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC 0/2] pseries: Correct behaviour change for older
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: abologna@redhat.com, thuth@redhat.com, lvivier@redhat.com
Cc: mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, bharata@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

152ef80 "pseries: Rewrite CAS PVR compatibility logic" incorrectly
introduced a guest-visible behaviour change into existing versioned
machine type.  Patch 2/2 corrects this change, while 1/2 is a
preliminary clean up to make that easier.

Unfortunately, this bug is already in the released qemu-2.9.0.  Once
this is ready to merge for master, I'll make a backport to apply for
2.9.1 as well.

David Gibson (2):
  pseries: Split CAS PVR negotiation out into a separate function
  pseries: Restore PVR negotiation logic for pre-2.9 machine types

 hw/ppc/spapr.c         |   3 ++
 hw/ppc/spapr_hcall.c   | 131 +++++++++++++++++++++++++++++++++++++++++++------
 include/hw/ppc/spapr.h |   1 +
 3 files changed, 119 insertions(+), 16 deletions(-)

-- 
2.9.4
