Received: from eggs.gnu.org ([2001:4830:134:3::10]:56789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1coqBo-0003lx-LI
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1coqBj-000714-PA
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:37:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:3814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1coqBj-0006zg-GD
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:36:55 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Fri, 17 Mar 2017 19:29:13 +0800
Message-Id: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [RFC PATCH 0/4] Qemu: Add Xen vIOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xensource.com
Cc: chao.gao@intel.com, kevin.tian@intel.com, Lan Tianyu <tianyu.lan@intel.com>, anthony.perard@citrix.com, ehabkost@redhat.com, marcel@redhat.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, sstabellini@kernel.org

This patchset is to add Xen vIOMMU device model and handle
irq remapping stuffs. Xen vIOMMU emulation is in the Xen hypervisor
and the new device module in Qemu works as hypercall wrappers to
create and destroy vIOMMU in hypervisor.

Xen only supports emulated I440 and so we enable vIOMMU with emulated
I440 chipset. This works on Linux and Windows guest.


Chao Gao (4):
  I440: Allow adding sysbus devices with -device on I440
  Xen: add a dummy vIOMMU to create/destroy vIOMMU in Xen
  xen-pt: bind/unbind interrupt remapping format MSI
  msi: taking interrupt format into consideration during judging a pirq
    is binded with a event channel

 hw/i386/pc_piix.c             |   1 +
 hw/pci/msi.c                  |   5 +-
 hw/pci/msix.c                 |   4 +-
 hw/xen/Makefile.objs          |   1 +
 hw/xen/xen_pt_msi.c           |  38 ++++++++++----
 hw/xen/xen_viommu.c           | 116 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/apic-msidef.h |   1 +
 include/hw/xen/xen.h          |   2 +-
 xen-hvm-stub.c                |   2 +-
 xen-hvm.c                     |   7 ++-
 10 files changed, 162 insertions(+), 15 deletions(-)
 create mode 100644 hw/xen/xen_viommu.c

-- 
1.8.3.1
