Received: from eggs.gnu.org ([2001:4830:134:3::10]:49086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fBu4s-0007M0-Vd
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fBu4p-0002bd-RQ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:29:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39170 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fBu4p-0002bD-Ml
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:29:39 -0400
Date: Fri, 27 Apr 2018 06:29:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1524799751-151698-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/4] pc, pci, virtio: fixes, features
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

The following changes since commit 4743c23509a51bd4ee85cc272287a41917d1be35:

  Update version for v2.12.0 release (2018-04-24 16:44:55 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to fb6fd86f712c73a40fbe0c6be86d4635239b1304:

  virtio-balloon: add hugetlb page allocation counts (2018-04-27 06:25:27 +0300)

----------------------------------------------------------------
pc, pci, virtio: fixes, features

A bugfix that just missed 2.12, a new PCI,
and a new virtio balloon stat.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Gerd Hoffmann (1):
      allocate pci id for mdpy

Jonathan Helman (1):
      virtio-balloon: add hugetlb page allocation counts

Peter Xu (1):
      intel-iommu: send PSI always when notify_unmap set

Zihan Yang (1):
      hw/pci-host/q35: Replace hardcoded value with macro

 docs/specs/pci-ids.txt                          |  1 +
 docs/virtio-balloon-stats.txt                   |  2 ++
 include/hw/pci/pci.h                            |  1 +
 include/standard-headers/linux/virtio_balloon.h |  4 ++-
 hw/i386/intel_iommu.c                           | 42 ++++++++++++++++++-------
 hw/pci-host/q35.c                               | 17 ++++++----
 hw/virtio/virtio-balloon.c                      |  2 ++
 7 files changed, 50 insertions(+), 19 deletions(-)
