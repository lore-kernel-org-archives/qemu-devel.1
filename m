Received: from eggs.gnu.org ([2001:4830:134:3::10]:44507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXqof-0007Yy-JD
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXqoc-0000Or-No
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:27:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44508 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fXqoc-0000Od-Cr
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:27:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1A2E81A4EA5
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 16:27:37 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 26 Jun 2018 18:27:33 +0200
Message-Id: <20180626162736.9749-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Vga 20180626 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

The following changes since commit e409d9a158c77c650651e8118f6c86c8dc76eb=
a6:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-reque=
st' into staging (2018-06-26 11:10:49 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20180626-pull-request

for you to fetch changes up to fd1cfb875be551064a27d909edb406316f011f2c:

  virtio-gpu-3d: Drop workaround for VIRTIO_GPU_CAPSET_VIRGL2 define (201=
8-06-26 16:04:17 +0200)

----------------------------------------------------------------
vga: bugfix collection.

----------------------------------------------------------------

Gerd Hoffmann (2):
  vga: set owner for mmio regions
  ramfb: fix overflow

Peter Maydell (1):
  virtio-gpu-3d: Drop workaround for VIRTIO_GPU_CAPSET_VIRGL2 define

 hw/display/vga_int.h           |  1 +
 include/hw/virtio/virtio-gpu.h |  5 -----
 hw/display/ramfb.c             |  4 ++--
 hw/display/vga-pci.c           | 11 ++++++-----
 hw/display/virtio-vga.c        |  2 +-
 5 files changed, 10 insertions(+), 13 deletions(-)

--=20
2.9.3
