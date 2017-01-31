Received: from eggs.gnu.org ([2001:4830:134:3::10]:59953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdOH-0006Y2-UH
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdOD-0008Um-Rk
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:42:54 -0500
Received: from mail.kernel.org ([198.145.29.136]:37558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdOD-0008UE-IZ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:42:49 -0500
Date: Tue, 31 Jan 2017 20:42:44 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485888144-16531-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v4 00/23] virtio, vhost, pci: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit a0def594286d9110a6035e02eef558cf3cf5d8=
47:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-01-30 10:23:20 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 08e53904f541e987e264e522b573920755c5a939:

  arm: add trailing ; after MISMATCH_CHECK (2017-01-31 16:50:42 +0200)

----------------------------------------------------------------
virtio, vhost, pci: fixes, features

generic pci root port support
disable shpc by default
safer version of ARRAY_SIZE and QEMU_BUILD_BUG_ON
fixes and cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Cao jin (3):
      msix: Follow CODING_STYLE
      hcd-xhci: check & correct param before using it
      pci: Convert msix_init() to Error and fix callers

Haozhong Zhang (1):
      hw/i386: check if nvdimm is enabled before plugging

Jason Wang (1):
      intel_iommu: fix and simplify size calculation in process_device_io=
tlb_desc()

Marc-Andr=C3=A9 Lureau (1):
      vhost-user: delete chardev on cleanup

Marcel Apfelbaum (4):
      hw/pcie: Introduce a base class for PCI Express Root Ports
      hw/ioh3420: derive from PCI Express Root Port base class
      hw/pcie: Introduce Generic PCI Express Root Port
      hw/pci: disable pci-bridge's shpc by default

Michael S. Tsirkin (12):
      compiler: drop ; after BUILD_BUG_ON
      qxl: switch to constants within BUILD_BUG_ON
      ppc: switch to constants within BUILD_BUG_ON
      QEMU_BUILD_BUG_ON: use __COUNTER__
      compiler: rework BUG_ON using a struct
      QEMU_BUILD_BUG_ON: use __COUNTER__
      compiler: expression version of QEMU_BUILD_BUG_ON
      ARRAY_SIZE: check that argument is an array
      pci: mark ROMs read-only
      vhost: skip ROM sections
      arm: better stub version for MISMATCH_CHECK
      arm: add trailing ; after MISMATCH_CHECK

Paolo Bonzini (1):
      virtio: make virtio_should_notify static

 default-configs/arm-softmmu.mak    |   1 +
 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 include/hw/compat.h                |   4 +
 include/hw/pci/msix.h              |   5 +-
 include/hw/pci/pci.h               |   1 +
 include/hw/pci/pcie_port.h         |  19 +++++
 include/hw/virtio/virtio.h         |   1 -
 include/qemu/compiler.h            |  19 ++++-
 include/qemu/osdep.h               |   9 +-
 target/arm/kvm-consts.h            | 102 +++++++++++-----------
 hw/block/nvme.c                    |   2 +-
 hw/display/qxl.c                   |   9 +-
 hw/i386/intel_iommu.c              |  10 ++-
 hw/i386/pc.c                       |   5 ++
 hw/misc/ivshmem.c                  |   8 +-
 hw/net/e1000e.c                    |   2 +-
 hw/net/rocker/rocker.c             |   4 +-
 hw/net/vmxnet3.c                   |   2 +-
 hw/pci-bridge/gen_pcie_root_port.c |  87 +++++++++++++++++++
 hw/pci-bridge/ioh3420.c            | 121 ++++----------------------
 hw/pci-bridge/pci_bridge_dev.c     |   2 +-
 hw/pci-bridge/pcie_root_port.c     | 171 +++++++++++++++++++++++++++++++=
++++++
 hw/pci/msix.c                      |  44 ++++++++--
 hw/pci/pci.c                       |   2 +-
 hw/ppc/spapr.c                     |  14 +--
 hw/scsi/megasas.c                  |   4 +-
 hw/usb/hcd-xhci.c                  |  41 +++++----
 hw/vfio/pci.c                      |   8 +-
 hw/virtio/vhost.c                  |   3 +-
 hw/virtio/virtio-pci.c             |   4 +-
 hw/virtio/virtio.c                 |   2 +-
 net/vhost-user.c                   |   3 +
 hw/pci-bridge/Makefile.objs        |   1 +
 34 files changed, 493 insertions(+), 219 deletions(-)
 create mode 100644 hw/pci-bridge/gen_pcie_root_port.c
 create mode 100644 hw/pci-bridge/pcie_root_port.c
