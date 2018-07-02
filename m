Received: from eggs.gnu.org ([2001:4830:134:3::10]:44356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa1dF-0006Og-Ay
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa1dD-0007v8-Po
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:24:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fa1dD-0007ud-KO
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:24:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4BA92027A
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:24:50 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  2 Jul 2018 18:24:40 +0200
Message-Id: <20180702162443.16796-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] virtio-gpu: scanout tracking fixes.
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
  virtio-gpu: tweak scanout disable.
  virtio-gpu: update old resource too.
  virtio-gpu: disable scanout when backing resource is destroyed

 hw/display/virtio-gpu.c | 64 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 19 deletions(-)

-- 
2.9.3
