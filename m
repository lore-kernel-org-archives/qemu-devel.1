Received: from eggs.gnu.org ([2001:4830:134:3::10]:48920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK7W-0006Hx-TR
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK7S-0004c3-KT
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:18:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dqK7S-0004bB-C6
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:18:54 -0400
Date: Fri, 8 Sep 2017 17:18:52 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1504880304-12069-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/17] pc, pci,
 virtio: patches queued before 2.10
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

The following changes since commit 74bbfe024da80a50dbe51fbb17f219d2f3e4d2=
dd:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' i=
nto staging (2017-09-08 12:57:28 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 6f6f4aec749ba9a4fb58c7c20536a61b0381ff35:

  fw_cfg: rename read callback (2017-09-08 16:15:17 +0300)

----------------------------------------------------------------
pc, pci, virtio: patches queued before 2.10

A bunch of stuff that was posted before the 2.10 timeframe,
mostly fixes/cleanups.  New PCI bridges.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Aleksandr Bezzubikov (4):
      hw/pci: introduce pcie-pci-bridge device
      hw/pci: introduce bridge-only vendor-specific capability to provide=
 some hints to firmware
      hw/pci: add QEMU-specific PCI capability to the Generic PCI Express=
 Root Port
      docs: update documentation considering PCIE-PCI bridge

Alex Williamson (1):
      vhost: Release memory references on cleanup

Anthony PERARD (3):
      hw/acpi: Limit hotplug to root bus on legacy mode
      hw/acpi: Move acpi_set_pci_info to pcihp
      Revert "ACPI: don't call acpi_pcihp_device_plug_cb on xen"

Marc-Andr=C3=A9 Lureau (4):
      libvhost-user: support resuming vq->last_avail_idx based on used_id=
x
      vhost-user-bridge: fix resume regression (since 2.9)
      vmgenid: replace x-write-pointer-available hack
      fw_cfg: rename read callback

Marcel Apfelbaum (1):
      pc: add 2.11 machine types

Mark Cave-Ayland (2):
      pci: move check for existing devfn into new pci_bus_devfn_available=
() helper
      pci: add reserved slot check to do_pci_register_device()

Peter Xu (1):
      intel_iommu: fix missing BQL in pt fast path

Yoni Bettan (1):
      acpi/vmgenid: change device category to misc

 docs/pcie.txt                         |  49 +++++----
 docs/pcie_pci_bridge.txt              | 114 ++++++++++++++++++++
 contrib/libvhost-user/libvhost-user.h |   7 ++
 include/hw/acpi/bios-linker-loader.h  |   2 +
 include/hw/acpi/vmgenid.h             |   1 -
 include/hw/compat.h                   |   4 -
 include/hw/i386/pc.h                  |   3 +
 include/hw/loader.h                   |   2 +-
 include/hw/nvram/fw_cfg.h             |   7 +-
 include/hw/pci/pci.h                  |   1 +
 include/hw/pci/pci_bridge.h           |  25 +++++
 include/hw/pci/pci_bus.h              |   1 +
 include/hw/pci/pcie_port.h            |   1 +
 contrib/libvhost-user/libvhost-user.c |  13 +++
 hw/acpi/bios-linker-loader.c          |  10 ++
 hw/acpi/pcihp.c                       |  40 ++++++-
 hw/acpi/piix4.c                       |  11 +-
 hw/acpi/vmgenid.c                     |  10 +-
 hw/core/loader.c                      |   2 +-
 hw/i386/acpi-build.c                  |  32 ------
 hw/i386/intel_iommu.c                 |  15 +++
 hw/i386/pc_piix.c                     |  15 ++-
 hw/i386/pc_q35.c                      |  13 ++-
 hw/nvram/fw_cfg.c                     |  30 +++---
 hw/pci-bridge/gen_pcie_root_port.c    |  36 +++++++
 hw/pci-bridge/pcie_pci_bridge.c       | 192 ++++++++++++++++++++++++++++=
++++++
 hw/pci/pci.c                          |  26 ++++-
 hw/pci/pci_bridge.c                   |  46 ++++++++
 hw/virtio/vhost.c                     |   4 +
 stubs/pci-host-piix.c                 |   6 ++
 tests/vhost-user-bridge.c             |   7 ++
 hw/pci-bridge/Makefile.objs           |   2 +-
 stubs/Makefile.objs                   |   1 +
 33 files changed, 622 insertions(+), 106 deletions(-)
 create mode 100644 docs/pcie_pci_bridge.txt
 create mode 100644 hw/pci-bridge/pcie_pci_bridge.c
 create mode 100644 stubs/pci-host-piix.c
