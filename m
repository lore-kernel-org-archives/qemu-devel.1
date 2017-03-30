Received: from eggs.gnu.org ([2001:4830:134:3::10]:36364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctckN-0002Mn-I1
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctckI-00023O-Fz
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:16:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ctckI-00021J-AU
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:16:22 -0400
Date: Thu, 30 Mar 2017 19:16:20 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1490890571-2786-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/2] vhost, pc: fixes
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

The following changes since commit e839001d5bb6c84932e2d82bd383477b2023f407:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2017-03-30 15:28:19 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 0d876080a394993a8dea494ebf2d806dc0983107:

  tests/acpi: don't pack a structure (2017-03-30 19:12:44 +0300)

----------------------------------------------------------------
vhost, pc: fixes

More fixes for 2.9. Region caching is still causing
issues around reset, but we seem to be getting there.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jason Wang (1):
      vhost: generalize iommu memory region

Michael S. Tsirkin (1):
      tests/acpi: don't pack a structure

 include/hw/virtio/vhost.h | 11 +++++++
 tests/acpi-utils.h        |  2 +-
 hw/virtio/vhost.c         | 84 ++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 76 insertions(+), 21 deletions(-)
