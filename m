Received: from eggs.gnu.org ([2001:4830:134:3::10]:43884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dICeq-0000TD-Uo
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dICel-0002jB-Qy
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:28:20 -0400
Received: from [59.151.112.132] (port=55441 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dICel-0002g4-Eg
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:28:15 -0400
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
	by cn.fujitsu.com (Postfix) with ESMTP id 367D947C7C61
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 19:27:52 +0800 (CST)
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Tue, 6 Jun 2017 19:26:25 +0800
Message-ID: <cover.1496746390.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/7] Convert to realize and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

v3:
* patch2: explain the specified means of the return value, also
          improve the commit message. [Marcel Apfelbaum]
* patch3: simplify the subject and commit message, fix another 
          wrong assert. [Marcel Apfelbaum]
* patch4: adjust the subject.
* patch5: fix a wrong optimization for errp. [Eduardo Habkost]
* patch7: a new patch that converts shpc_init() to Error in order 
          to propagate the error better.                                                                                                                                                              
v2:
* patch1: subject and commit message was rewrited by markus.
* patch2: comment was added to pci_add_capability2().
* patch3: a new patch that fix the wrong return value judgment condition.
* patch4: a new patch that fix code style problems.
* patch5: add an errp argument for pci_add_capability to pass
          error for its callers.
* patch6: convert part of pci-bridge device to realize.

v1:
* patch1: fix unreasonable return value check

Mao Zhongyi (7):
  pci: Clean up error checking in pci_add_capability()
  pci: Add comment for pci_add_capability2()
  pci: Fix the return value checking
  net/eepro100: Fix code style
  pci: Make errp the last parameter of pci_add_capability()
  pci: Convert to realize
  pci: Convert shpc_init() to Error

 hw/i386/amd_iommu.c                | 24 ++++++++----
 hw/net/e1000e.c                    |  9 ++++-
 hw/net/eepro100.c                  | 80 +++++++++++++++++++++-----------------
 hw/pci-bridge/i82801b11.c          | 12 +++---
 hw/pci-bridge/pci_bridge_dev.c     | 21 ++++------
 hw/pci-bridge/pcie_root_port.c     | 15 +++----
 hw/pci-bridge/xio3130_downstream.c | 20 +++++-----
 hw/pci-bridge/xio3130_upstream.c   | 20 +++++-----
 hw/pci/pci.c                       | 20 +++++-----
 hw/pci/pci_bridge.c                |  8 +++-
 hw/pci/pcie.c                      | 15 +++++--
 hw/pci/shpc.c                      | 10 +++--
 hw/pci/slotid_cap.c                | 12 ++++--
 hw/usb/hcd-xhci.c                  |  2 +-
 hw/vfio/pci.c                      |  5 ++-
 hw/virtio/virtio-pci.c             | 19 ++++++---
 include/hw/pci/pci.h               |  3 +-
 include/hw/pci/pci_bridge.h        |  3 +-
 include/hw/pci/pcie.h              |  3 +-
 include/hw/pci/shpc.h              |  3 +-
 include/hw/pci/slotid_cap.h        |  3 +-
 21 files changed, 176 insertions(+), 131 deletions(-)

-- 
2.9.3
