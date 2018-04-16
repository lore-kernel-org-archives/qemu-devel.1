Received: from eggs.gnu.org ([2001:4830:134:3::10]:52328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f87IG-0006i9-SI
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f87IC-0003Ir-Qt
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:47:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49043 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f87IC-0003Ht-Mh
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:47:48 -0400
Date: Mon, 16 Apr 2018 19:47:44 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1523895458-475479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/1] vhost: bugfix
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

The following changes since commit 38e83a71d02e026d4a6d0ab1ef9855c4924c2c68:

  Update version for v2.12.0-rc3 release (2018-04-11 19:03:24 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to aebbdbee559389a9f0d0e56670b9332534b6bb9b:

  vhost: do not verify ring mappings when IOMMU is enabled (2018-04-16 19:11:38 +0300)

----------------------------------------------------------------
vhost: bugfix

This fixes a regression in vhost.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jason Wang (1):
      vhost: do not verify ring mappings when IOMMU is enabled

 hw/virtio/vhost.c | 4 ++++
 1 file changed, 4 insertions(+)
