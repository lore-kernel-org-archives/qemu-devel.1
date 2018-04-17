Received: from eggs.gnu.org ([2001:4830:134:3::10]:57929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8Krt-0003RV-CX
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8Krq-0008SQ-72
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:17:33 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Apr 2018 17:17:12 +1000
Message-Id: <20180417071722.9399-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH for-2.13 00/10] spapr: Cleanups to PAPR mode
 setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: benh@kernel.crashing.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This series contains a number of cleanups to the way we set up and
start a guest in PAPR mode.

Applies on top of my ppc-for-2.13 branch.

David Gibson (10):
  spapr: Avoid redundant calls to spapr_cpu_reset()
  spapr: Remove support for PowerPC 970 with pseries machine type
  target/ppc: Remove unnecessary initialization of LPCR_UPRT
  spapr: Set compatibility mode before the rest of spapr_cpu_reset()
  spapr: Move PAPR mode register initialization to spapr code
  target/ppc: Add ppc_store_lpcr() helper
  spapr: Make a helper to set up cpu entry point state
  spapr: Clean up handling of LPCR power-saving exit bits
  target/ppc: Don't bother with MSR_EP in cpu_ppc_set_papr()
  spapr: Move PAPR specific cpu logic to pseries machine type

 hw/ppc/spapr.c                  | 71 ++++++++++++++---------------------------
 hw/ppc/spapr_cpu_core.c         | 71 +++++++++++++++++++++++++++++++----------
 hw/ppc/spapr_rtas.c             | 10 ++----
 include/hw/ppc/spapr_cpu_core.h |  5 +++
 target/ppc/cpu.h                |  2 +-
 target/ppc/kvm.c                | 40 +++--------------------
 target/ppc/kvm_ppc.h            |  6 ----
 target/ppc/mmu-hash64.c         | 15 ++++++---
 target/ppc/mmu-hash64.h         |  3 +-
 target/ppc/translate_init.c     | 71 +++--------------------------------------
 10 files changed, 109 insertions(+), 185 deletions(-)

-- 
2.14.3
