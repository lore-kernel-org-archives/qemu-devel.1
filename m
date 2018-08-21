Received: from eggs.gnu.org ([2001:4830:134:3::10]:43456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs4bC-00052J-35
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs4b8-0001lO-Vp
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:13:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33794 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs4b8-0001l1-Q1
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:13:18 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Aug 2018 13:13:11 +0200
Message-Id: <20180821111313.27792-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] virtio-vga: fix reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>



Gerd Hoffmann (2):
  virtio-vga: fix reset
  Revert "virtio-gpu: fix crashes upon warm reboot with vga mode"

 include/hw/virtio/virtio-gpu.h |  2 +-
 hw/display/virtio-gpu.c        |  7 +------
 hw/display/virtio-vga.c        | 17 +++++------------
 3 files changed, 7 insertions(+), 19 deletions(-)

-- 
2.9.3
