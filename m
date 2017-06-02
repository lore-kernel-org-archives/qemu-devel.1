Received: from eggs.gnu.org ([2001:4830:134:3::10]:34363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGpWz-0007qt-Hr
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGpWw-00068n-VV
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:34:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dGpWw-00067S-PC
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:34:30 -0400
Date: Fri, 2 Jun 2017 19:34:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496421247-857-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] virtio, vhost: fixes, features
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

The following changes since commit d47a851caeda96d5979bf48d4bae6a87784ad9=
1d:

  Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170=
601' into staging (2017-06-02 14:07:53 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 6dcdd06e3b0d0c5651219013ec975348e2050041:

  spec/vhost-user spec: Add IOMMU support (2017-06-02 18:57:17 +0300)

----------------------------------------------------------------
virtio, vhost: fixes, features

IOTLB support in vhost-user.
A bunch of fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Ladi Prosek (1):
      virtio-serial-bus: Unset hotplug handler when unrealize

Marc-Andr=C3=A9 Lureau (2):
      vhost-user: add vhost_user to hold the chr
      vhost-user: add slave-req-fd support

Maxime Coquelin (3):
      vhost: propagate errors in vhost_device_iotlb_miss()
      vhost: rework IOTLB messaging
      spec/vhost-user spec: Add IOMMU support

Paolo Bonzini (1):
      virtio: add virtqueue_alloc_element tracepoint

Stefan Hajnoczi (1):
      virtio-serial: fix segfault on disconnect

 docs/specs/vhost-user.txt         | 116 ++++++++++++++++++++++-
 include/hw/virtio/vhost-backend.h |  23 +++--
 include/hw/virtio/vhost.h         |   2 +-
 hw/char/virtio-serial-bus.c       |   6 ++
 hw/net/vhost_net.c                |   1 +
 hw/virtio/vhost-backend.c         | 130 ++++++++++++++-----------
 hw/virtio/vhost-user.c            | 194 ++++++++++++++++++++++++++++++++=
++++--
 hw/virtio/vhost.c                 |  19 ++--
 hw/virtio/virtio.c                |   1 +
 hw/virtio/trace-events            |   1 +
 10 files changed, 412 insertions(+), 81 deletions(-)
