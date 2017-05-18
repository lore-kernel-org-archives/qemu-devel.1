Received: from eggs.gnu.org ([2001:4830:134:3::10]:35050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dBJl1-0005hK-LT
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dBJkx-00010s-8u
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:38:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:26000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dBJkx-000108-0D
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:38:11 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Thu, 18 May 2017 01:32:58 -0400
Message-Id: <1495085580-10631-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [RFC PATCH V2 0/2] Qemu: Add Xen vIOMMU interrupt
 remapping function.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, anthony.perard@citrix.com, marcel@redhat.com, mst@redhat.com, sstabellini@kernel.org, kevin.tian@intel.com, chao.gao@intel.com

Change since V1:
       1) Move create/destroy vIOMMU and query vIOMMU capabilities to tool stack.
       2) Fix some code style issue.

This patchset is to deal with MSI interrupt remapping request when guest
updates MSI registers.

Repo:
https://github.com/lantianyu/qemu/tree/xen_viommu_rfc_v2

Chao Gao (2):
  xen-pt: bind/unbind interrupt remapping format MSI
  msi: Handle remappable format interrupt request

 hw/pci/msi.c                  |  5 +++--
 hw/pci/msix.c                 |  4 +++-
 hw/xen/xen_pt_msi.c           | 52 +++++++++++++++++++++++++++++++------------
 include/hw/i386/apic-msidef.h |  3 ++-
 include/hw/xen/xen.h          |  2 +-
 xen-hvm-stub.c                |  2 +-
 xen-hvm.c                     |  7 +++++-
 7 files changed, 54 insertions(+), 21 deletions(-)

-- 
1.8.3.1
