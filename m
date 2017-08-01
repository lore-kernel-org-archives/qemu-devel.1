Received: from eggs.gnu.org ([2001:4830:134:3::10]:35748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcerB-0000xn-Lv
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcer8-0004Zy-Ef
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dcer8-0004ZY-7v
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:34 -0400
Date: Wed, 2 Aug 2017 00:37:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1501623438-31419-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 00/10] pc, acpi, virtio: fixes,
 test speedup for rc1
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

The following changes since commit 7d48cf8102a10e4a54333811bafb5eb566509268:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2017-08-01 14:33:56 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 3a3fcc75f92ab0d71ba0e7511af7dc575c4b4f6c:

  pc: acpi: force FADT rev1 for 440fx based machine types (2017-08-02 00:13:26 +0300)

----------------------------------------------------------------
pc, acpi, virtio: fixes, test speedup for rc1

Some fixes all over the place. Notably vhost-user gained a new message
to set endian-ness. Borderline for 2.10 but seems to be the only way to
fix legacy guests.  Also pc tests are run on kvm now. Not a fix at all
but doesn't touch qemu itself, so I merged it since I had to run these a
lot and I just got tired of waiting for these to finish.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      tests/bios-tables-test: Compiler warning fix

Felipe Franciosi (1):
      vhost-user: fix legacy cross-endian configurations

Igor Mammedov (2):
      pc: make 'pc.rom' readonly when machine has PCI enabled
      pc: acpi: force FADT rev1 for 440fx based machine types

Laurent Vivier (1):
      accel: cleanup error output

Michael S. Tsirkin (1):
      tests: switch pxe and vm gen id tests to use kvm

Peng Hao (1):
      vhost: fix a memory leak

Peter Xu (2):
      intel_iommu: fix iova for pt
      intel_iommu: use access_flags for iotlb

Yunjian Wang (1):
      vhost-user: fix watcher need be removed when vhost-user hotplug

 docs/interop/vhost-user.txt    | 16 ++++++++++++++++
 hw/i386/intel_iommu_internal.h |  1 -
 include/hw/i386/intel_iommu.h  |  3 +--
 accel/accel.c                  | 20 ++++++++++----------
 hw/i386/acpi-build.c           | 22 ++++++++++++++++++----
 hw/i386/intel_iommu.c          | 19 +++++++++----------
 hw/i386/pc.c                   |  3 +++
 hw/virtio/vhost-backend.c      |  2 ++
 hw/virtio/vhost-user.c         | 23 +++++++++++++++++++++--
 net/vhost-user.c               |  4 ++++
 tests/bios-tables-test.c       |  2 +-
 tests/pxe-test.c               |  2 +-
 tests/vmgenid-test.c           |  2 +-
 13 files changed, 87 insertions(+), 32 deletions(-)
