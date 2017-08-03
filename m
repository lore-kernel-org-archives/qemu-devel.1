Received: from eggs.gnu.org ([2001:4830:134:3::10]:34019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ddGnD-00031R-0D
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ddGn8-0001Rv-4a
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:08:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ddGn7-0001QK-VQ
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:07:58 -0400
Date: Thu, 3 Aug 2017 17:07:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1501769263-27001-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL] virtio: fix for rc2
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

The following changes since commit aaaec6acad7cf97372d48c1b09126a09697519=
c8:

  Update version for v2.10.0-rc1 release (2017-08-02 16:36:32 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to e6a74868d92f858ac33915b6772999d7de2fd288:

  build-sys: add --disable-vhost-user (2017-08-03 15:55:41 +0300)

----------------------------------------------------------------
virtio: fix for rc2

Looks like the constant stream of additions of vhost-user devices is a
problem for some people who are concerned about external connections
from qemu. A per-device flag seems like an overkill, but a single
configure flag seems like a sane way to support that, and it looks like
we need to do it before the release.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (1):
      build-sys: add --disable-vhost-user

 configure                         | 28 ++++++++++++++++++++++++++--
 default-configs/pci.mak           |  2 +-
 default-configs/s390x-softmmu.mak |  2 +-
 hw/virtio/virtio-pci.c            |  4 ++--
 tests/Makefile.include            |  6 +++---
 5 files changed, 33 insertions(+), 9 deletions(-)
