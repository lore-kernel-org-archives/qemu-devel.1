Received: from eggs.gnu.org ([2001:4830:134:3::10]:45187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLtVL-0002mw-I7
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLtVI-0002mG-DW
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dLtVI-0002lC-7V
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:49:44 -0400
Date: Fri, 16 Jun 2017 18:49:36 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1497628168-30489-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/7] pc: fixes, cleanups, features
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

The following changes since commit edf8bc98424d62035d5e4c0f39542722d72d7979:

  Merge remote-tracking branch 'remotes/rth/tags/pull-s390-20170613' into staging (2017-06-15 13:45:15 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 7f3cf2d6e7d1231d854902c9016823961e59d1f4:

  hw/i386: fix nvdimm check error path (2017-06-16 18:44:56 +0300)

----------------------------------------------------------------
pc: fixes, cleanups, features

Some fixes and cleanups. Extended TSEG sizes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Laszlo Ersek (3):
      q35/mch: implement extended TSEG sizes
      tests/q35-test: push down qtest_start / qtest_end to test case(s)
      tests/q35-test: add TSEG size checks

Peter Xu (3):
      intel_iommu: switching the rest DPRINTF to trace
      intel_iommu: cleanup vtd_{do_}iommu_translate()
      intel_iommu: cleanup vtd_interrupt_remap_msi()

Stefan Hajnoczi (1):
      hw/i386: fix nvdimm check error path

 hw/i386/intel_iommu_internal.h |   1 +
 include/hw/i386/pc.h           |   5 +
 include/hw/pci-host/q35.h      |   6 +
 hw/i386/intel_iommu.c          | 421 +++++++++++++++--------------------------
 hw/i386/pc.c                   |  14 +-
 hw/pci-host/q35.c              |  41 +++-
 tests/q35-test.c               | 125 +++++++++++-
 hw/i386/trace-events           |  44 +++++
 8 files changed, 371 insertions(+), 286 deletions(-)
