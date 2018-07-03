Received: from eggs.gnu.org ([2001:4830:134:3::10]:36902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faHs8-0001k9-AN
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faHs6-000512-KE
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:45:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1faHs6-0004zX-EG
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:45:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A21463084051
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 09:45:17 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jul 2018 11:45:04 +0200
Message-Id: <20180703094508.25987-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Vga 20180703 patches
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

The following changes since commit ab08440a4ee09032d1a9cb22fdcab23bc7e1c6=
56:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180702' into =
staging (2018-07-02 17:57:46 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20180703-pull-request

for you to fetch changes up to 1fcfdc435a3e25ab9037f6f7b8ab4bdf89ba1269:

  vga: disable global_vmstate for 3.0+ machine types (2018-07-03 11:19:49=
 +0200)

----------------------------------------------------------------
vga: disable global_vmstate, virtio-gpu scanout tracking fixes.

----------------------------------------------------------------

Gerd Hoffmann (4):
  virtio-gpu: tweak scanout disable.
  virtio-gpu: update old resource too.
  virtio-gpu: disable scanout when backing resource is destroyed
  vga: disable global_vmstate for 3.0+ machine types

 hw/display/vga_int.h    |  3 ++-
 include/hw/compat.h     | 16 +++++++++++++
 hw/display/cirrus_vga.c |  9 ++++---
 hw/display/qxl.c        |  3 ++-
 hw/display/vga-isa-mm.c |  3 ++-
 hw/display/vga-isa.c    |  3 ++-
 hw/display/vga-pci.c    |  5 ++--
 hw/display/vga.c        |  4 ++--
 hw/display/virtio-gpu.c | 64 ++++++++++++++++++++++++++++++++++---------=
------
 hw/display/virtio-vga.c |  2 +-
 hw/display/vmware_vga.c |  4 +++-
 11 files changed, 84 insertions(+), 32 deletions(-)

--=20
2.9.3
