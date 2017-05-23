Received: from eggs.gnu.org ([2001:4830:134:3::10]:48444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dDAxg-0008IZ-7o
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dDAxf-0002Zk-2g
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:39:00 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 May 2017 16:38:45 +0200
Message-Id: <1495550330-34087-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] numa: code consolidation and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

changelog since v1:
  (Eduardo)
     - user error_abort in numa_cpu_pre_plug()
     - make default_mapping boolean
     - redo default mapping detection loop as a combo of for/if
     - return back lost TODO comment
     - new patch removing numa_node from generic CPUState
  - drop silence test patch as it's already in pull req on list
  - new patch [3/5] to fix missing _PXM/fdt nodes for implicitly mapped CPUs
  - new patch dropping fallback to node 0


git repo for testing:
   https://github.com/imammedo/qemu.git cphp_numa_cfg_follow_up_v3_cleanups_v2

CC: qemu-arm@nongnu.org
CC: qemu-ppc@nongnu.org
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Andrew Jones <drjones@redhat.com>

Igor Mammedov (5):
  numa: consolidate cpu_preplug fixups/checks for pc/arm/spapr
  numa: move default mapping init to machine
  numa: make sure that all cpus in has has_node_id set if numa is
    enabled
  numa: fallback to default NUMA node instead of node 0
  numa: move numa_node from CPUState into target specific classes

 include/qom/cpu.h        |  2 --
 include/sysemu/numa.h    |  1 +
 target/arm/cpu.h         |  2 ++
 target/i386/cpu.h        |  1 +
 target/ppc/cpu.h         |  1 +
 hw/arm/virt-acpi-build.c |  4 +---
 hw/arm/virt.c            | 16 ++--------------
 hw/core/machine.c        | 34 ++++++++++++++++++++++++----------
 hw/i386/acpi-build.c     |  3 +--
 hw/i386/pc.c             | 21 ++-------------------
 hw/ppc/spapr.c           | 41 ++++++++++++-----------------------------
 hw/ppc/spapr_cpu_core.c  |  4 +++-
 monitor.c                | 11 +++++++----
 numa.c                   | 43 +++++++++++++++++--------------------------
 target/arm/cpu.c         |  2 +-
 target/i386/cpu.c        |  2 +-
 16 files changed, 76 insertions(+), 112 deletions(-)

-- 
2.7.4
