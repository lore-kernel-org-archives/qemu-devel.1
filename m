Received: from eggs.gnu.org ([2001:4830:134:3::10]:34343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eZrya-0004em-DN
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 00:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eZryZ-0007Gj-K1
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 00:34:00 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 12 Jan 2018 16:33:42 +1100
Message-Id: <20180112053345.13075-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 0/3] target/ppc: Rework spapr_caps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, paulus@ozlabs.org, sjitindarsingh@gmail.com

The following patch series reworks the implementation of spapr_caps
to allow for a increased number of possible values in the internal
representation.

It also adds 3 new tristate capabilities.

A new H-Call is implemented which a guest will use to query the 
requirement for and availability of workarounds for certain cpu 
behaviours.

Applies on top of David's series - spapr: Add optional capabilities
Based on ppc-for-2.12

The patches could be split up more, but in the interest of getting
them out there they are as they are.

Suraj Jitindar Singh (3):
  hw/ppc/spapr_caps: Rework spapr_caps to use uint8 internal
    representation
  hw/spapr/spapr_caps: Add new caps
    safe_[cache/bounds_check/indirect_branch]
  target/ppc: Add H-Call H_GET_CPU_CHARACTERISTICS

 hw/ppc/spapr.c            |  51 ++++-
 hw/ppc/spapr_caps.c       | 483 ++++++++++++++++++++++++++++++++--------------
 hw/ppc/spapr_hcall.c      |  78 ++++++++
 include/hw/ppc/spapr.h    |  61 +++---
 linux-headers/linux/kvm.h |   3 +
 target/ppc/kvm.c          |  28 +++
 target/ppc/kvm_ppc.h      |  18 ++
 7 files changed, 544 insertions(+), 178 deletions(-)

-- 
2.13.6
