Received: from eggs.gnu.org ([209.51.188.92]:56958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hBtB4-0000xh-QH
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hBtB3-0000Bp-V4
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:36:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:25553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hBtB3-0008F1-K6
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:36:33 -0400
From: Tao Xu <tao3.xu@intel.com>
Date: Thu,  4 Apr 2019 11:34:26 +0800
Message-Id: <20190404033429.17232-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH 0/3] numa: move numa global variables into
 MachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: imammedo@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, jingqi.liu@intel.com, tao3.xu@intel.com

The aim of this patch is to add struct NumaState in MachineState
and move existing numa global nb_numa_nodes into NumaState.
And add variable numa_support into MachineClass to decide which
submachines support NUMA.

Tao Xu (3):
  numa: move numa global variable nb_numa_nodes into MachineState
  numa: move numa global variable have_numa_distance into MachineState
  numa: move numa global variable numa_info into MachineState

 exec.c                              |  3 +++
 hw/acpi/aml-build.c                 |  3 +++
 hw/arm/boot.c                       |  3 +++
 hw/arm/virt-acpi-build.c            |  8 +++++++-
 hw/arm/virt.c                       |  7 ++++++-
 hw/core/machine.c                   |  9 ++++++--
 hw/i386/acpi-build.c                |  2 +-
 hw/i386/pc.c                        |  9 +++++++-
 hw/mem/pc-dimm.c                    |  2 ++
 hw/pci-bridge/pci_expander_bridge.c |  2 ++
 hw/ppc/spapr.c                      | 23 ++++++++++++++++-----
 hw/ppc/spapr_pci.c                  |  2 ++
 include/hw/boards.h                 | 21 +++++++++++++++++++
 include/sysemu/numa.h               | 11 ----------
 monitor.c                           |  2 ++
 numa.c                              | 32 +++++++++++++++++++++--------
 16 files changed, 109 insertions(+), 30 deletions(-)

-- 
2.17.1
