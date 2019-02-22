Received: from eggs.gnu.org ([209.51.188.92]:51018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx68m-0002cR-Bm
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:25:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx68l-0007K7-1D
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:25:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx68k-0007CE-LC
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:25:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8B2F13A41
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:24:46 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Feb 2019 09:24:31 +0100
Message-Id: <20190222082436.23029-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Vga 20190222 patches
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

The following changes since commit 2e68b8620637a4ee8c79b5724144b726af1e26=
1b:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20190219=
' into staging (2019-02-18 16:20:13 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20190222-pull-request

for you to fetch changes up to 1ed2cb32dc9e8f74c82bdc567edad717b0f34fa5:

  display/virtio: add edid support. (2019-02-22 07:25:04 +0100)

----------------------------------------------------------------
vga: bugfixes and edid support for virtio-vga

----------------------------------------------------------------

Gerd Hoffmann (1):
  display/virtio: add edid support.

Marc-Andr=C3=A9 Lureau (4):
  virtio-gpu: remove unused qdev
  virtio-gpu: remove unused config_size
  virtio-gpu: block both 2d and 3d rendering
  virtio-gpu: remove useless 'waiting' field

 include/hw/virtio/virtio-gpu.h | 10 +++---
 hw/display/virtio-gpu-3d.c     | 24 ++------------
 hw/display/virtio-gpu.c        | 74 ++++++++++++++++++++++++++++++++++++=
+-----
 hw/display/trace-events        |  1 +
 4 files changed, 74 insertions(+), 35 deletions(-)

--=20
2.9.3
