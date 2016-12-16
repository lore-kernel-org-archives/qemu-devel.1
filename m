Received: from eggs.gnu.org ([2001:4830:134:3::10]:38493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzqy-0002Yh-NG
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzqt-0005GL-Im
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:15:44 -0500
Received: from mail.kernel.org ([198.145.29.136]:48572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzqt-0005Df-8Y
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:15:39 -0500
Date: Fri, 16 Dec 2016 23:15:32 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1481922841-4324-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 0/9] virtio, vhost, pc: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com

The following changes since commit 6a928d25b6d8bc3729c3d28326c6db13b94810=
59:

  Update version for v2.8.0-rc4 release (2016-12-15 07:36:03 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 2858bc68701e282c404ed04d65d4f065e4b40e52:

  virtio: avoid using guest_notifier_mask in vhost-user mode (2016-12-16 =
01:14:54 +0200)

----------------------------------------------------------------
virtio, vhost, pc: fixes

Here are some bugfixes that didn't make 2.8.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Marc-Andr=E9 Lureau (6):
      tests/vhost-user-bridge: remove false comment
      tests/vhost-user-bridge: remove unnecessary dispatcher_remove
      tests/vhost-user-bridge: indicate peer disconnected
      tests/vhost-user-bridge: do not accept more than one connection
      contrib: add libvhost-user
      tests/vhost-user-bridge: use contrib/libvhost-user

Michael S. Tsirkin (1):
      pci: fix error message for express slots

Prasad J Pandit (1):
      i386: amd_iommu: fix MMIO register count and access

Wei Huang (1):
      virtio: avoid using guest_notifier_mask in vhost-user mode

 Makefile                              |    1 +
 contrib/libvhost-user/libvhost-user.h |  435 ++++++++++
 hw/i386/amd_iommu.h                   |    4 +-
 contrib/libvhost-user/libvhost-user.c | 1499 +++++++++++++++++++++++++++=
++++++
 hw/i386/amd_iommu.c                   |    2 +-
 hw/pci/pci.c                          |    4 +-
 hw/s390x/virtio-ccw.c                 |    4 +-
 hw/virtio/virtio-mmio.c               |    2 +-
 tests/vhost-user-bridge.c             | 1183 +++++---------------------
 Makefile.objs                         |    2 +-
 contrib/libvhost-user/Makefile.objs   |    1 +
 tests/Makefile.include                |    2 +-
 12 files changed, 2175 insertions(+), 964 deletions(-)
 create mode 100644 contrib/libvhost-user/libvhost-user.h
 create mode 100644 contrib/libvhost-user/libvhost-user.c
 create mode 100644 contrib/libvhost-user/Makefile.objs
