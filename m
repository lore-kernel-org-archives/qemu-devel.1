Received: from eggs.gnu.org ([2001:4830:134:3::10]:53417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f9X2u-0003hC-84
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f9X2p-0002tH-2x
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:29:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f9X2o-0002rY-PS
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:29:46 -0400
Date: Fri, 20 Apr 2018 17:29:37 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1524234528-373013-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/1] pc: bugfix
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

The following changes since commit 27e757e29cc79f3f104d2a84d17cdb3b4c11c8ff:

  Update version for v2.12.0-rc4 release (2018-04-17 22:26:44 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to f256f05c94d12eed2c1a0e9b6ed4fb1fb9d8ec72:

  intel-iommu: send PSI always when notify_unmap set (2018-04-20 17:26:23 +0300)

----------------------------------------------------------------
pc: bugfix

Adds missing invalidations in vtd.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Peter Xu (1):
      intel-iommu: send PSI always when notify_unmap set

 hw/i386/intel_iommu.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)
