Received: from eggs.gnu.org ([2001:4830:134:3::10]:50161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f45zF-0007RI-IB
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f45zB-0001Qq-Kx
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:35:37 -0400
From: Serhii Popovych <spopovyc@redhat.com>
Date: Thu,  5 Apr 2018 10:35:21 -0400
Message-Id: <1522938923-96058-1-git-send-email-spopovyc@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.13 0/2] target/ppc: Support adding memory
 to initially memory-less NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: bharata@linux.vnet.ibm.com, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

Now PowerPC Linux kernel supports hot-add to NUMA nodes not populated
initially with memory we can enable such support in qemu. This requires
two changes:

  o Add device tree property "ibm,max-associativity-domains" to let
    guest kernel chance to find max possible NUMA node

  o Revert  commit b556854bd852 ("spapr: Don't allow memory hotplug to
    memory less nodes") to remove check for hot-add to memory-less node.

See description messges for individual changes for more details.

Serhii Popovych (2):
  Revert "spapr: Don't allow memory hotplug to memory less nodes"
  spapr: Add ibm,max-associativity-domains property

 hw/ppc/spapr.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

-- 
1.8.3.1
