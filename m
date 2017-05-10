Received: from eggs.gnu.org ([2001:4830:134:3::10]:44774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d8Wxw-00055H-H8
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d8Wxs-0004bB-GB
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:08:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d8Wxs-0004b3-9X
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:08:00 -0400
Date: Wed, 10 May 2017 22:07:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1494443192-17177-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] pci, virtio, vhost: fixes
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

The following changes since commit 76d20ea0f1b26ebd5da2f5fb2fdf3250cde887=
bb:

  Merge remote-tracking branch 'armbru/tags/pull-qapi-2017-05-04-v3' into=
 staging (2017-05-09 15:49:14 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 8b12e48950a3d59188489b2ff6c5ad9cc09e9866:

  acpi-defs: clean up open brace usage (2017-05-10 22:04:23 +0300)

----------------------------------------------------------------
pci, virtio, vhost: fixes

A bunch of fixes that missed the release.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Ard Biesheuvel (2):
      hw/acpi-defs: replace leading X with x_ in FADT field names
      hw/arm/virt: generate 64-bit addressable ACPI objects

Bruce Rogers (1):
      ACPI: don't call acpi_pcihp_device_plug_cb on xen

Eduardo Habkost (1):
      iommu: Don't crash if machine is not PC_MACHINE

Igor Mammedov (1):
      pc/fwcfg: unbreak migration from qemu-2.5 and qemu-2.6 during firmw=
are boot

Marc-Andr=C3=A9 Lureau (1):
      libvhost-user: fix crash when rings aren't ready

Michael S. Tsirkin (1):
      acpi-defs: clean up open brace usage

Peter Xu (1):
      pc: add 2.10 machine type

Zhiyong Yang (1):
      hw/virtio: fix vhost user fails to startup when MQ

 contrib/libvhost-user/libvhost-user.h |  6 ++---
 include/hw/acpi/acpi-defs.h           | 45 ++++++++++++++++++-----------=
------
 include/hw/acpi/aml-build.h           |  3 +++
 include/hw/i386/pc.h                  | 10 ++++----
 contrib/libvhost-user/libvhost-user.c | 26 +++++++++++++++-----
 hw/acpi/aml-build.c                   | 27 +++++++++++++++++++++
 hw/acpi/piix4.c                       | 11 ++++++---
 hw/arm/virt-acpi-build.c              | 26 ++++++++++----------
 hw/i386/acpi-build.c                  |  4 ++--
 hw/i386/amd_iommu.c                   | 15 +++++++++++-
 hw/i386/intel_iommu.c                 | 14 +++++++++--
 hw/i386/pc.c                          |  9 ++++---
 hw/i386/pc_piix.c                     | 16 ++++++++++---
 hw/i386/pc_q35.c                      | 14 +++++++++--
 hw/virtio/vhost-user.c                | 21 +++++++++-------
 tests/bios-tables-test.c              |  4 ++--
 16 files changed, 175 insertions(+), 76 deletions(-)
