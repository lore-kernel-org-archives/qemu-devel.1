Received: from eggs.gnu.org ([2001:4830:134:3::10]:33550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFNDK-0005ma-3x
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFNDF-0000Ju-8H
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:40:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eFNDE-0000JE-V7
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:40:25 -0500
Date: Thu, 16 Nov 2017 18:40:23 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1510850407-17266-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] pc, pci, virtio: fixes for rc1
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

The following changes since commit 6a7cb8c3d674815cab08d884740d203fded122=
49:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20171115' into =
staging (2017-11-16 12:45:14 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 3831c07b89ab1f7aa1427bc56e9cdf70f5367933:

  tests/bios-tables-test: Fix endianess problems when passing data to ias=
l (2017-11-16 18:36:54 +0200)

----------------------------------------------------------------
pc, pci, virtio: fixes for rc1

A bunch of fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pci: Initialize pci_dev->name before use

Dou Liyang (1):
      NUMA: Enable adding NUMA node implicitly

Marc-Andr=C3=A9 Lureau (2):
      vmcoreinfo: put it in the 'misc' device category
      build-sys: restrict vmcoreinfo to fw_cfg+dma capable targets

Marcel Apfelbaum (2):
      hw/pci-host: Fix x86 Host Bridges 64bit PCI hole
      hw/pcie-pci-bridge: restrict to X86 and ARM

Michael S. Tsirkin (1):
      tests/acpi-test-data: update _CRS in DSDT

Thomas Huth (1):
      tests/bios-tables-test: Fix endianess problems when passing data to=
 iasl

linzhecheng (1):
      fix: unrealize virtio device if we fail to hotplug it

 default-configs/arm-softmmu.mak      |   2 ++
 default-configs/i386-softmmu.mak     |   1 +
 default-configs/x86_64-softmmu.mak   |   1 +
 include/hw/boards.h                  |   1 +
 include/hw/i386/pc.h                 |  10 ++++++++-
 include/hw/pci-host/q35.h            |   1 +
 tests/acpi-utils.h                   |  27 +++++-----------------
 hw/i386/pc.c                         |  23 +++++++++++++++++++
 hw/i386/pc_piix.c                    |   1 +
 hw/i386/pc_q35.c                     |   1 +
 hw/misc/vmcoreinfo.c                 |   1 +
 hw/pci-host/piix.c                   |  32 ++++++++++++++++++++++++--
 hw/pci-host/q35.c                    |  42 +++++++++++++++++++++++++++++=
+++---
 hw/pci/pci.c                         |   2 +-
 hw/virtio/virtio.c                   |   1 +
 numa.c                               |  21 +++++++++++++++++-
 tests/bios-tables-test.c             |  42 ++++++++++++++++++-----------=
------
 tests/vmgenid-test.c                 |  22 +++++++++---------
 vl.c                                 |   3 +--
 hw/misc/Makefile.objs                |   2 +-
 hw/pci-bridge/Makefile.objs          |   4 ++--
 tests/acpi-test-data/pc/DSDT         | Bin 5098 -> 5144 bytes
 tests/acpi-test-data/pc/DSDT.bridge  | Bin 6957 -> 7003 bytes
 tests/acpi-test-data/pc/DSDT.cphp    | Bin 5561 -> 5607 bytes
 tests/acpi-test-data/pc/DSDT.ipmikcs | Bin 5170 -> 5216 bytes
 tests/acpi-test-data/pc/DSDT.memhp   | Bin 6463 -> 6509 bytes
 tests/acpi-test-data/q35/DSDT        | Bin 7782 -> 7828 bytes
 tests/acpi-test-data/q35/DSDT.bridge | Bin 7799 -> 7845 bytes
 tests/acpi-test-data/q35/DSDT.cphp   | Bin 8245 -> 8291 bytes
 tests/acpi-test-data/q35/DSDT.ipmibt | Bin 7857 -> 7903 bytes
 tests/acpi-test-data/q35/DSDT.memhp  | Bin 9147 -> 9193 bytes
 31 files changed, 175 insertions(+), 65 deletions(-)
