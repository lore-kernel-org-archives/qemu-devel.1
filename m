Received: from eggs.gnu.org ([2001:4830:134:3::10]:50643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDEk-00033I-4w
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDEg-0006i1-8y
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:26 -0400
Received: from mail.kernel.org ([198.145.29.136]:58972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDEg-0006hK-2i
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:22 -0400
Date: Wed, 15 Mar 2017 20:01:17 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1489600837-11541-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/7] virtio, pc: fixes
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

The following changes since commit d84f714eafedd8bb9d4aaec8b76417bef8e3535e:

  Update version for v2.9.0-rc0 release (2017-03-14 19:18:23 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 60a8d8023473dd24957b3a66824f66cd35b80d64:

  virtio-pci: reset modern vq meta data (2017-03-15 19:59:18 +0200)

----------------------------------------------------------------
virtio, pc: fixes

Some fixes to fallback from using virtio caching,
pls a minor vm gen id fix.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Ben Warren (1):
      Bugfix: Handle error if VM Generation ID device not present

Jason Wang (6):
      virtio: guard against NULL pfn
      virtio: destroy region cache during reset
      virtio: validate address space cache during init
      pci: introduce a bus master container
      Revert "virtio: unbreak virtio-pci with IOMMU after caching ring translations"
      virtio-pci: reset modern vq meta data

 include/hw/pci/pci.h   |   1 +
 hmp.c                  |   4 +-
 hw/acpi/vmgenid.c      |   1 +
 hw/pci/pci.c           |   9 ++++-
 hw/virtio/virtio-pci.c |   6 ++-
 hw/virtio/virtio.c     | 104 +++++++++++++++++++++++++++++++++++++++----------
 6 files changed, 100 insertions(+), 25 deletions(-)
