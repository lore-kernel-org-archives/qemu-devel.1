Received: from eggs.gnu.org ([2001:4830:134:3::10]:49090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erRLB-0006A0-Up
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erRL7-0000hQ-Vd
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:45:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57130 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1erRL7-0000gh-OY
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:45:53 -0500
Date: Thu, 1 Mar 2018 18:45:52 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1519922735-29054-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/13] virtio, vhost, pci, pc: features,
 fixes and cleanups
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

The following changes since commit 8cb340c613ee3e626b070e0429c589f8a60ac6=
57:

  Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' i=
nto staging (2018-03-01 12:32:31 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 0a9b9be9eb40055d2d1bb5b8fc4d4faefecb22c3:

  cryptodev-vhost-user: set the key length (2018-03-01 18:26:17 +0200)

----------------------------------------------------------------
virtio,vhost,pci,pc: features, fixes and cleanups

- documentation updates
- vhost fixes
- new crypto vhost device

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Gonglei (4):
      cryptodev: add vhost-user as a new cryptodev backend
      cryptodev: add vhost support
      cryptodev-vhost-user: add crypto session handler
      cryptodev-vhost-user: set the key length

Greg Kurz (1):
      virtio-pci: trivial fixes in error message

Jan Kiszka (1):
      intel-iommu: Accept 64-bit writes to FEADDR

Jay Zhou (1):
      vhost: fix memslot limit check

Jia He (2):
      vhost: avoid to start/stop virtqueue which is not ready
      vhost: fix incorrect check in vhost_verify_ring_mappings

Kashyap Chamarthy (1):
      docs: pcie: Spell out machine type needs for PCIe features

Marc-Andr=C3=A9 Lureau (1):
      docs/vmcoreinfo: detail unsupported host format behaviour

Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (1):
      docs: document virtio-balloon stats

linzhecheng (1):
      vhost-user: fix memory leak

 docs/interop/vhost-user.txt           |  26 +++
 docs/pcie.txt                         |   9 +-
 docs/specs/vmcoreinfo.txt             |   4 +
 docs/virtio-balloon-stats.txt         |   2 +
 configure                             |  15 ++
 include/hw/virtio/vhost-backend.h     |   8 +
 include/hw/virtio/virtio-crypto.h     |   1 +
 include/sysemu/cryptodev-vhost-user.h |  47 +++++
 include/sysemu/cryptodev-vhost.h      | 154 ++++++++++++++
 include/sysemu/cryptodev.h            |   8 +
 backends/cryptodev-builtin.c          |   1 +
 backends/cryptodev-vhost-user.c       | 377 ++++++++++++++++++++++++++++=
++++++
 backends/cryptodev-vhost.c            | 347 ++++++++++++++++++++++++++++=
+++
 hw/i386/intel_iommu.c                 |  11 +-
 hw/virtio/vhost-user.c                | 104 ++++++++++
 hw/virtio/vhost.c                     |  41 +++-
 hw/virtio/virtio-crypto.c             |  70 +++++++
 hw/virtio/virtio-pci.c                |   2 +-
 net/vhost-user.c                      |   1 +
 vl.c                                  |   6 +
 backends/Makefile.objs                |   6 +
 qemu-options.hx                       |  21 ++
 22 files changed, 1246 insertions(+), 15 deletions(-)
 create mode 100644 include/sysemu/cryptodev-vhost-user.h
 create mode 100644 include/sysemu/cryptodev-vhost.h
 create mode 100644 backends/cryptodev-vhost-user.c
 create mode 100644 backends/cryptodev-vhost.c
