Received: from eggs.gnu.org ([209.51.188.92]:48856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0p-0003Xb-Ob
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0n-0003Sn-Qa
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hCY0n-0003Gj-Fg
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id k2so9398603qtm.1
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 16:12:39 -0700 (PDT)
Date: Fri, 5 Apr 2019 19:12:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190405231225.30165-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/5] pci, pc, virtio: fixes
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

The following changes since commit 436960c95946007aca713330e7a488a6f2e0696f:

  Merge remote-tracking branch 'remotes/berrange/tags/filemon-next-pull-request' into staging (2019-04-02 14:52:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 81fb1e646e4da29f8e1639022241323b956b67e4:

  intel_iommu: Drop extended root field (2019-04-02 11:49:14 -0400)

----------------------------------------------------------------
pci, pc, virtio: fixes

intel-iommu fixes
virtio typo fixes
linker: a couple of asserts for consistency/security

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alex Williamson (1):
      intel_iommu: Correct caching-mode error message

Liam Merwick (1):
      acpi: verify file entries in bios_linker_loader_add_pointer()

Peter Xu (2):
      intel_iommu: Fix root_scalable migration breakage
      intel_iommu: Drop extended root field

Yuval Shaia (1):
      virtio-net: Fix typo in comment

 hw/i386/intel_iommu_internal.h |  1 -
 include/hw/i386/intel_iommu.h  |  1 -
 hw/acpi/bios-linker-loader.c   |  2 ++
 hw/i386/intel_iommu.c          | 32 +++++++++++++++++++++++---------
 hw/net/virtio-net.c            |  2 +-
 hw/i386/trace-events           |  2 +-
 6 files changed, 27 insertions(+), 13 deletions(-)
