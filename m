Received: from eggs.gnu.org ([2001:4830:134:3::10]:51344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dfdfg-00038w-OE
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 22:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dfdfc-0002Zi-UL
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 22:58:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:46883)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dfdfc-0002Yg-Lt
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 22:58:00 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Wed,  9 Aug 2017 16:51:19 -0400
Message-Id: <1502311882-11038-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [PATCH v2 0/3] Qemu: Add Xen vIOMMU interrupt
 remapping function support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, anthony.perard@citrix.com, ehabkost@redhat.com, marcel@redhat.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, sstabellini@kernel.org, chao.gao@intel.com, kevin.tian@intel.com

This patchset is to deal with MSI interrupt remapping request when guest
updates MSI registers.

Chao Gao (3):
  i386/msi: Correct mask of destination ID in MSI address
  xen-pt: bind/unbind interrupt remapping format MSI
  msi: Handle remappable format interrupt request

 configure                     |  4 +++-
 hw/i386/xen/xen-hvm.c         |  8 ++++++-
 hw/pci/msi.c                  |  5 +++--
 hw/pci/msix.c                 |  4 +++-
 hw/xen/xen_pt_msi.c           | 52 +++++++++++++++++++++++++++++++------------
 include/hw/i386/apic-msidef.h |  3 ++-
 include/hw/xen/xen.h          |  2 +-
 include/hw/xen/xen_common.h   | 25 +++++++++++++++++++++
 stubs/xen-hvm.c               |  2 +-
 9 files changed, 83 insertions(+), 22 deletions(-)

-- 
1.8.3.1
