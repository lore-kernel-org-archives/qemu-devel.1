Received: from eggs.gnu.org ([2001:4830:134:3::10]:54962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f5xl2-0007mR-Bn
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 14:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spopovyc@redhat.com>) id 1f5xkz-0000sx-7i
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 14:12:40 -0400
From: Serhii Popovych <spopovyc@redhat.com>
Date: Tue, 10 Apr 2018 14:12:24 -0400
Message-Id: <1523383946-37373-1-git-send-email-spopovyc@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.13 v2 0/2] target/ppc: Support adding
 memory to initially memory-less NUMA nodes
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

v2:
  - Reorder patches in series according to description above.
  - Add extra coment to revert noticing return to previous behaviour for
    guests without support for hot-add to empty node.
  - Drop max_cpus from topology in property due to vcpu id discontiguous
    allocations. Thanks to David Gibson for extra explanation.
  - Rebase to current state of master branch.

Serhii Popovych (2):
  spapr: Add ibm,max-associativity-domains property
  Revert "spapr: Don't allow memory hotplug to memory less nodes"

 hw/ppc/spapr.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

-- 
1.8.3.1
