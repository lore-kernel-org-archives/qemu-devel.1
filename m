Received: from eggs.gnu.org ([2001:4830:134:3::10]:36077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fa8YN-0008WJ-PY
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 19:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fa8YJ-0007Fk-U5
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 19:48:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fa8YJ-0007E7-OE
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 19:48:15 -0400
Date: Tue, 3 Jul 2018 02:48:08 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180702234631.12268-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/3] pc, virtio: fixes
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

The following changes since commit 00928a421d47f49691cace1207481b7aad31b1f1:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180626' into staging (2018-06-26 18:23:49 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 5d9c9ea22ab4f3b3ee497523e34b6f4d3281f62d:

  virtio-rng: process pending requests on DRIVER_OK (2018-06-28 04:46:16 +0300)

----------------------------------------------------------------
pc, virtio: fixes

A couple of fixes to amd iommu, and a fix to virtio iommu.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jan Kiszka (2):
      hw/i386: Fix IVHD entry length for AMD IOMMU
      hw/i386: Fix AMDVI GATS and HATS encodings

Pankaj Gupta (1):
      virtio-rng: process pending requests on DRIVER_OK

 hw/i386/amd_iommu.h    |  4 ++--
 hw/i386/acpi-build.c   |  2 +-
 hw/virtio/virtio-rng.c | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 3 deletions(-)
