Received: from eggs.gnu.org ([2001:4830:134:3::10]:50526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dGhRX-00008A-6p
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dGhRU-0001MN-5P
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:56:23 -0400
Received: from [59.151.112.132] (port=6328 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dGhRT-0001Jk-PQ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:56:20 -0400
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
	by cn.fujitsu.com (Postfix) with ESMTP id BE23047C652D
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 15:56:05 +0800 (CST)
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 2 Jun 2017 15:54:36 +0800
Message-ID: <cover.1496387804.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/6] Convert to realize and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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

Mao Zhongyi (6):
  pci: Clean up error checking in pci_add_capability()
  pci: Add comment for pci_add_capability2()
  pci: Fix the wrong return value judgment condition
  net/eepro100: Fixed code style
  pci: Make errp the last parameter of pci_add_capability()
  pci: Convert to realize

 hw/i386/amd_iommu.c                | 24 ++++++++----
 hw/net/e1000e.c                    |  9 ++++-
 hw/net/eepro100.c                  | 77 +++++++++++++++++++++-----------------
 hw/pci-bridge/i82801b11.c          | 12 +++---
 hw/pci-bridge/pcie_root_port.c     | 15 +++-----
 hw/pci-bridge/xio3130_downstream.c | 20 +++++-----
 hw/pci-bridge/xio3130_upstream.c   | 20 +++++-----
 hw/pci/pci.c                       | 18 ++++-----
 hw/pci/pci_bridge.c                |  8 +++-
 hw/pci/pcie.c                      | 15 ++++++--
 hw/pci/shpc.c                      |  5 ++-
 hw/pci/slotid_cap.c                |  7 +++-
 hw/vfio/pci.c                      |  5 ++-
 hw/virtio/virtio-pci.c             | 19 +++++++---
 include/hw/pci/pci.h               |  3 +-
 include/hw/pci/pci_bridge.h        |  3 +-
 include/hw/pci/pcie.h              |  3 +-
 17 files changed, 154 insertions(+), 109 deletions(-)

-- 
2.9.3
