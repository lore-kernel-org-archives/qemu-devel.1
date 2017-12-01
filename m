Received: from eggs.gnu.org ([2001:4830:134:3::10]:54668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eKono-0000gH-S0
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:08:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eKono-00071w-0P
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:08:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eKonn-00070m-O6
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:08:39 -0500
Date: Fri, 1 Dec 2017 19:08:37 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1512148088-28733-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] pc, pci, virtio: fixes for rc3
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

The following changes since commit c11d61271b9e6e7a1f0479ef1ca8fb55fa457a=
62:

  Update version for v2.11.0-rc3 release (2017-11-29 17:59:34 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 75ba2ddb188fa07c3442446766782036e3085cba:

  pc: fix crash on attempted cpu unplug (2017-12-01 19:05:58 +0200)

----------------------------------------------------------------
pc, pci, virtio: fixes for rc3

A bunch of fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Chao Gao (1):
      i386/msi: Correct mask of destination ID in MSI address

Greg Kurz (1):
      vhost: fix error check in vhost_verify_ring_mappings()

Igor Mammedov (1):
      pc: fix crash on attempted cpu unplug

Marc-Andr=C3=A9 Lureau (1):
      dump-guest-memory.py: fix No symbol "vmcoreinfo_find"

Maxime Coquelin (2):
      virtio: Add queue interface to restore avail index from vring used =
index
      vhost: restore avail index from vring used index on disconnection

Prasad J Pandit (1):
      virtio: check VirtQueue Vring object is set

 include/hw/i386/apic-msidef.h |  2 +-
 include/hw/virtio/virtio.h    |  1 +
 hw/i386/pc.c                  |  5 +++++
 hw/virtio/vhost.c             | 10 +++++++---
 hw/virtio/virtio.c            | 24 +++++++++++++++++++++---
 scripts/dump-guest-memory.py  | 12 +++++++-----
 6 files changed, 42 insertions(+), 12 deletions(-)
