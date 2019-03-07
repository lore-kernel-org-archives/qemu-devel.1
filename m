Received: from eggs.gnu.org ([209.51.188.92]:40591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1nzT-0004aO-Vq
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:02:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1nzS-0002Pp-50
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:02:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1nzQ-0002OR-86
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:02:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00C3230842AC
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 08:02:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  7 Mar 2019 09:02:41 +0100
Message-Id: <20190307080244.9011-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] virtio-gpu: fix reset.
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



Gerd Hoffmann (3):
  virtio: add class_size to VirtioPCIDeviceTypeInfo
  virtio-vga: fix reset.
  virtio-gpu: make virtio_gpu_reset static

 hw/virtio/virtio-pci.h         |  1 +
 include/hw/virtio/virtio-gpu.h |  1 -
 hw/display/virtio-gpu.c        |  2 +-
 hw/display/virtio-vga.c        | 17 +++++++++++++++--
 hw/virtio/virtio-pci.c         |  1 +
 5 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.18.1
