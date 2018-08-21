Received: from eggs.gnu.org ([2001:4830:134:3::10]:58972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1frx8Y-0006qs-5u
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 23:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1frx8U-0002D0-8Q
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 23:15:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:48547)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1frx8U-0002BN-0R
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 23:15:14 -0400
From: Jing Liu <jing2.liu@linux.intel.com>
Date: Tue, 21 Aug 2018 11:18:05 +0800
Message-Id: <1534821487-14189-1-git-send-email-jing2.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 0/2] hw/pci: PCI resource reserve capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anthony.xu@intel.com, mst@redhat.com, marcel.apfelbaum@gmail.com, lersek@redhat.com, pbonzini@redhat.com, Jing Liu <jing2.liu@linux.intel.com>

This patch serial is about PCI resource reserve capability.

First patch refactors the resource reserve fields in GenPCIERoorPort
structure out to another new structure, called "PCIResReserve". Modify
the parameter list of pci_bridge_qemu_reserve_cap_init().

Second patch enables the resource reserve capability for legacy PCI bridge
so that firmware can reserve additional resources for this bridge.

Change Logs:
v3 -> v2
* remove the teardown patch because only need pci_del_capability
* keep the names to be consistent with firmware counterpart
* some minor fixes

v2 -> v1
* add refactoring patch
* add teardown function
* some other fixes

Jing Liu (2):
  hw/pci: factor PCI reserve resources to a separate structure
  hw/pci: add PCI resource reserve capability to legacy PCI bridge

 hw/pci-bridge/gen_pcie_root_port.c | 33 +++++++++++++++++----------------
 hw/pci-bridge/pci_bridge_dev.c     | 24 ++++++++++++++++++++++++
 hw/pci/pci_bridge.c                | 38 +++++++++++++++++---------------------
 include/hw/pci/pci_bridge.h        | 18 +++++++++++++-----
 4 files changed, 71 insertions(+), 42 deletions(-)

-- 
1.8.3.1
