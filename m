Received: from eggs.gnu.org ([2001:4830:134:3::10]:57276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eayKN-0007k1-JP
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 01:33:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eayKM-0006nR-UI
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 01:33:03 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon, 15 Jan 2018 17:32:29 +1100
Message-Id: <20180115063235.7518-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V3 0/6] target/ppc: Rework spapr_caps
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

The following patch series adds 3 new tristate capabilities and their
associated handling.

A new H-Call is implemented which a guest will use to query the
requirement for and availability of workarounds for certain cpu
behaviours.

Applies on top of David's tree: ppc-for-2.12

The first patch from the previous revision has already been merged:
hw/ppc/spapr_caps: Rework spapr_caps to use uint8 internal representation

The main changes to V3 are:
- Split up the addition of the tristate caps into 5 patches
  - 1/6 query the caps from the hypervisor and parse the new return format
  - 2/6 add support for the new caps
  - 3-5/6 add each of the three new caps
- Patch 6/6 Unchanged

Suraj Jitindar Singh (6):
  target/ppc/kvm: Add cap_ppc_safe_[cache/bounds_check/indirect_branch]
  target/ppc/spapr_caps: Add support for tristate spapr_capabilities
  target/ppc/spapr_caps: Add new tristate cap safe_cache
  target/ppc/spapr_caps: Add new tristate cap safe_bounds_check
  target/ppc/spapr_caps: Add new tristate cap safe_indirect_branch
  target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS

 hw/ppc/spapr.c                  |   6 ++
 hw/ppc/spapr_caps.c             | 178 ++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_hcall.c            |  66 +++++++++++++++
 include/hw/ppc/spapr.h          |  28 ++++++-
 linux-headers/asm-powerpc/kvm.h |   8 ++
 linux-headers/linux/kvm.h       |   3 +
 target/ppc/kvm.c                |  58 +++++++++++++
 target/ppc/kvm_ppc.h            |  18 ++++
 8 files changed, 364 insertions(+), 1 deletion(-)

-- 
2.13.6
