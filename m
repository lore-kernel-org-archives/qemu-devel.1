Received: from eggs.gnu.org ([2001:4830:134:3::10]:48115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQuNo-0008Aa-93
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQuNl-0004mU-5y
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:46:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dQuNl-0004mE-0U
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:46:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 30 Jun 2017 12:46:28 +0100
Message-Id: <20170630114635.9286-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] Block patches
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

The following changes since commit 464588675455afda2899e20a0b120e4075de50c7:

  Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20170627-tag' into staging (2017-06-29 11:45:01 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to c324fd0a39cee43c13f6d1fb34f74fc5e2fb007b:

  virtio-pci: use ioeventfd even when KVM is disabled (2017-06-30 11:03:45 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Stefan Hajnoczi (7):
  virtio-blk: trace vdev so devices can be distinguished
  libqos: fix typo in virtio.h QVirtQueue->used comment
  libqos: add virtio used ring support
  tests: fix virtio-scsi-test ISR dependence
  tests: fix virtio-blk-test ISR dependence
  tests: fix virtio-net-test ISR dependence
  virtio-pci: use ioeventfd even when KVM is disabled

 tests/libqos/virtio.h    |  8 ++++++-
 hw/block/virtio-blk.c    | 12 ++++++----
 hw/virtio/virtio-pci.c   |  2 +-
 tests/libqos/virtio.c    | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/virtio-blk-test.c  | 27 ++++++++++++++--------
 tests/virtio-net-test.c  |  6 ++---
 tests/virtio-scsi-test.c |  2 +-
 hw/block/trace-events    | 10 ++++----
 8 files changed, 101 insertions(+), 26 deletions(-)

-- 
2.9.4
