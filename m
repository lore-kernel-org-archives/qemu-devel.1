Received: from eggs.gnu.org ([2001:4830:134:3::10]:49026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cvQUN-0005dV-Bs
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cvQUJ-0006ls-Bk
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:35:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cvQUJ-0006kY-6k
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:35:19 -0400
Date: Tue, 4 Apr 2017 18:35:17 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1491320063-12719-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/1] pci: fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jcody@redhat.com

The following changes since commit 87cc4c61020addea6a001b94b662596b1896d1b3:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-04-04 11:40:55 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 193982c6f9424779b53a168fe32ebc30a776cbf1:

  pci: Only unmap bus_master_enabled_region if was added previously (2017-04-04 18:32:25 +0300)

----------------------------------------------------------------
pci: fix

A single bugfix for a error handling issue in pci.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pci: Only unmap bus_master_enabled_region if was added previously

 hw/pci/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
