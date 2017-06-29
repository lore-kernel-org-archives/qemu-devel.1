Received: from eggs.gnu.org ([2001:4830:134:3::10]:43990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dQY3y-0006ku-Gd
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dQY3u-00072Y-FS
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:56:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:52319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dQY3u-00071P-5E
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:56:42 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Thu, 29 Jun 2017 01:49:51 -0400
Message-Id: <1498715394-16402-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [PATCH 0/3] Qemu: Add Xen vIOMMU interrupt remapping
 function support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xensource.com
Cc: Lan Tianyu <tianyu.lan@intel.com>, anthony.perard@citrix.com, marcel@redhat.com, mst@redhat.com, sstabellini@kernel.org, chao.gao@intel.com, kevin.tian@intel.com

This patchset is to deal with MSI interrupt remapping request when guest
updates MSI registers.

Chao Gao (3):
  i386/msi: Correct mask of destination ID in MSI address
  xen-pt: bind/unbind interrupt remapping format MSI
  msi: Handle remappable format interrupt request

 configure                     | 54 +++++++++++++++++++++++++++++++++++++++++++
 hw/pci/msi.c                  |  5 ++--
 hw/pci/msix.c                 |  4 +++-
 hw/xen/xen_pt_msi.c           | 52 ++++++++++++++++++++++++++++++-----------
 include/hw/i386/apic-msidef.h |  3 ++-
 include/hw/xen/xen.h          |  2 +-
 include/hw/xen/xen_common.h   | 25 ++++++++++++++++++++
 xen-hvm-stub.c                |  2 +-
 xen-hvm.c                     |  8 ++++++-
 9 files changed, 134 insertions(+), 21 deletions(-)

-- 
1.8.3.1
