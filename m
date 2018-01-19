Received: from eggs.gnu.org ([2001:4830:134:3::10]:60196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1ecOmw-0007N6-7n
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:00:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1ecOmv-0004ns-HS
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:00:26 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 19 Jan 2018 15:59:58 +1100
Message-Id: <20180119050005.29392-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V5 0/7] target/ppc: Rework spapr_caps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, paulus@ozlabs.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The following patch series adds 3 new tristate capabilities and their
associated handling.

A new H-Call is implemented which a guest will use to query the 
requirement for and availability of workarounds for certain cpu 
behaviours.

Applies on top of David's tree: ppc-for-2.12

The main changes to V5 are:
- Add patch 2/7 to series to introduce macros to generate migration fields
- Fix bisect breakage in 3/7 due to unused function
- Use assert in 7/7 for invalid cap values

Suraj Jitindar Singh (7):
  target/ppc/kvm: Add cap_ppc_safe_[cache/bounds_check/indirect_branch]
  target/ppc/spapr_caps: Add macro to generate spapr_caps migration
    vmstate
  target/ppc/spapr_caps: Add support for tristate spapr_capabilities
  target/ppc/spapr_caps: Add new tristate cap safe_cache
  target/ppc/spapr_caps: Add new tristate cap safe_bounds_check
  target/ppc/spapr_caps: Add new tristate cap safe_indirect_branch
  target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS

 hw/ppc/spapr.c                  |   6 ++
 hw/ppc/spapr_caps.c             | 202 +++++++++++++++++++++++++++++-----------
 hw/ppc/spapr_hcall.c            |  58 ++++++++++++
 include/hw/ppc/spapr.h          |  28 +++++-
 linux-headers/asm-powerpc/kvm.h |   8 ++
 linux-headers/linux/kvm.h       |   3 +
 target/ppc/kvm.c                |  58 ++++++++++++
 target/ppc/kvm_ppc.h            |  18 ++++
 8 files changed, 326 insertions(+), 55 deletions(-)

-- 
2.13.6
