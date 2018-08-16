Received: from eggs.gnu.org ([2001:4830:134:3::10]:33484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fqEWr-0004HM-Cb
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fqEWn-00079B-8t
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:25:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:21412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1fqEWn-00077o-0F
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:25:13 -0400
From: Jing Liu <jing2.liu@linux.intel.com>
Date: Thu, 16 Aug 2018 17:28:13 +0800
Message-Id: <1534411696-6454-1-git-send-email-jing2.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 0/3] hw/pci: PCI resource reserve capability
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

Then we add the teardown function called pci_bridge_qemu_reserve_cap_uninit().

Last we enable the resource reserve capability for legacy PCI bridge
so that firmware can reserve additional resources for the bridge.

Change Log:
v2 -> v1
* add refactoring patch
* add teardown function
* some other fixes

Jing Liu (3):
  hw/pci: factor PCI reserve resources to a separate structure
  hw/pci: add teardown function for PCI resource reserve capability
  hw/pci: add PCI resource reserve capability to legacy PCI bridge

 hw/pci-bridge/gen_pcie_root_port.c | 32 +++++++++++++-------------
 hw/pci-bridge/pci_bridge_dev.c     | 25 ++++++++++++++++++++
 hw/pci/pci_bridge.c                | 47 +++++++++++++++++++++-----------------
 include/hw/pci/pci_bridge.h        | 18 +++++++++++----
 4 files changed, 80 insertions(+), 42 deletions(-)

-- 
1.8.3.1
