Received: from eggs.gnu.org ([2001:4830:134:3::10]:53250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=6PQq=ZI=redhat.com=mst@kernel.org>)
	id 1cWmhg-0001Bh-EG
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:15:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=6PQq=ZI=redhat.com=mst@kernel.org>)
	id 1cWmhb-0003rs-Ja
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:15:16 -0500
Received: from mail.kernel.org ([198.145.29.136]:38268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=6PQq=ZI=redhat.com=mst@kernel.org>)
	id 1cWmhb-0003qQ-AS
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 11:15:11 -0500
Date: Thu, 26 Jan 2017 18:15:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485447262-27014-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/18] virtio, vhost, pci: fixes, features
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

The following changes since commit ae5045ae5b2bbd8ce1335d1b05f9ecacca83a6=
cf:

  Merge remote-tracking branch 'remotes/rth/tags/pull-nios-20170124' into=
 staging (2017-01-25 13:30:23 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 1954d8b17bbccad723c193edba961d49b7ac4a43:

  hw/pci: disable pci-bridge's shpc by default (2017-01-26 18:13:33 +0200=
)

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

Michael S. Tsirkin (7):
      compiler: drop ; after BUILD_BUG_ON
      qxl: switch to constants within BUILD_BUG_ON
      compiler: rework BUG_ON using a struct
      compiler: expression version of QEMU_BUILD_BUG_ON
      ARRAY_SIZE: check that argument is an array
      pci: mark ROMs read-only
      vhost: skip ROM sections

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
 include/qemu/compiler.h            |  11 ++-
 include/qemu/osdep.h               |   9 +-
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
 hw/scsi/megasas.c                  |   4 +-
 hw/usb/hcd-xhci.c                  |  41 +++++----
 hw/vfio/pci.c                      |   8 +-
 hw/virtio/vhost.c                  |   3 +-
 hw/virtio/virtio-pci.c             |   4 +-
 hw/virtio/virtio.c                 |   2 +-
 net/vhost-user.c                   |   3 +
 hw/pci-bridge/Makefile.objs        |   1 +
 32 files changed, 425 insertions(+), 163 deletions(-)
 create mode 100644 hw/pci-bridge/gen_pcie_root_port.c
 create mode 100644 hw/pci-bridge/pcie_root_port.c
