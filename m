Received: from eggs.gnu.org ([2001:4830:134:3::10]:36779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQBxi-00042w-LV
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQBxe-0001om-95
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:20:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dQBxe-0001nZ-24
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:20:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 28 Jun 2017 13:20:39 +0100
Message-Id: <20170628122041.13558-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit 577caa2672ccde7352fda3ef17e44993de862f0e:

  Merge remote-tracking branch 'remotes/edgar/tags/edgar/mmio-exec-v2.for-upstream' into staging (2017-06-27 16:56:55 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 439778e6b4a20c8fe6a6a92a17013b09c4ae55d0:

  virtio-pci: use ioeventfd even when KVM is disabled (2017-06-28 13:18:53 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Stefan Hajnoczi (2):
  virtio-blk: trace vdev so devices can be distinguished
  virtio-pci: use ioeventfd even when KVM is disabled

 hw/block/virtio-blk.c  | 12 +++++++-----
 hw/virtio/virtio-pci.c |  2 +-
 hw/block/trace-events  | 10 +++++-----
 3 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.9.4
