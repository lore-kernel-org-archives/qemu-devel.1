Received: from eggs.gnu.org ([2001:4830:134:3::10]:60756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fyOex-00004v-O6
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fyOeu-0005ml-Rf
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:51:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51484 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fyOeu-0005ma-L0
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:51:20 -0400
Date: Fri, 7 Sep 2018 17:51:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180907215109.146867-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/7] pci, pc, virtio: fixes, features
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

The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd241557452:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27-v2' into staging (2018-08-27 16:44:20 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to d2a1b1d602986a5f02658f6d4fc9ed422f8ddebf:

  tests: update acpi expected files (2018-09-07 17:43:22 -0400)

----------------------------------------------------------------
pci, pc, virtio: fixes, features

pci resource capability + misc fixes everywhere.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Igor Mammedov (2):
      pc: acpi: revert back to 1 SRAT entry for hotpluggable area
      pc: make sure that guest isn't able to unplug the first cpu

Jing Liu (2):
      hw/pci: factor PCI reserve resources to a separate structure
      hw/pci: add PCI resource reserve capability to legacy PCI bridge

Michael S. Tsirkin (1):
      tests: update acpi expected files

Paolo Bonzini (1):
      virtio: update MemoryRegionCaches when guest negotiates features

Yury Kotov (1):
      vhost: fix invalid downcast

 include/hw/pci/pci_bridge.h           |  18 ++++++---
 hw/acpi/cpu.c                         |  10 +++--
 hw/i386/acpi-build.c                  |  73 ++++++----------------------------
 hw/pci-bridge/gen_pcie_root_port.c    |  33 +++++++--------
 hw/pci-bridge/pci_bridge_dev.c        |  24 +++++++++++
 hw/pci/pci_bridge.c                   |  38 ++++++++----------
 hw/virtio/vhost.c                     |   4 +-
 hw/virtio/virtio.c                    |  15 ++++++-
 tests/acpi-test-data/pc/DSDT          | Bin 5144 -> 5131 bytes
 tests/acpi-test-data/pc/DSDT.bridge   | Bin 7003 -> 6990 bytes
 tests/acpi-test-data/pc/DSDT.cphp     | Bin 5607 -> 5594 bytes
 tests/acpi-test-data/pc/DSDT.dimmpxm  | Bin 6803 -> 6790 bytes
 tests/acpi-test-data/pc/DSDT.ipmikcs  | Bin 5216 -> 5203 bytes
 tests/acpi-test-data/pc/DSDT.memhp    | Bin 6509 -> 6496 bytes
 tests/acpi-test-data/pc/DSDT.numamem  | Bin 5150 -> 5137 bytes
 tests/acpi-test-data/pc/SRAT.dimmpxm  | Bin 472 -> 392 bytes
 tests/acpi-test-data/pc/SRAT.memhp    | Bin 264 -> 264 bytes
 tests/acpi-test-data/q35/DSDT         | Bin 7828 -> 7815 bytes
 tests/acpi-test-data/q35/DSDT.bridge  | Bin 7845 -> 7832 bytes
 tests/acpi-test-data/q35/DSDT.cphp    | Bin 8291 -> 8278 bytes
 tests/acpi-test-data/q35/DSDT.dimmpxm | Bin 9487 -> 9474 bytes
 tests/acpi-test-data/q35/DSDT.ipmibt  | Bin 7903 -> 7890 bytes
 tests/acpi-test-data/q35/DSDT.memhp   | Bin 9193 -> 9180 bytes
 tests/acpi-test-data/q35/DSDT.numamem | Bin 7834 -> 7821 bytes
 tests/acpi-test-data/q35/SRAT.dimmpxm | Bin 472 -> 392 bytes
 tests/acpi-test-data/q35/SRAT.memhp   | Bin 264 -> 264 bytes
 26 files changed, 103 insertions(+), 112 deletions(-)
