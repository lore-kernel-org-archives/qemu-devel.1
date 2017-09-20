Received: from eggs.gnu.org ([2001:4830:134:3::10]:49212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1duhVC-00048q-2N
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1duhV7-0007Jg-O7
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:05:29 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:49426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1duhV7-0007Ho-I4
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:05:25 -0400
Received: by mail-wm0-f54.google.com with SMTP id e71so8604128wmg.4
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 09:05:25 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Wed, 20 Sep 2017 18:05:21 +0200
Message-Id: <cover.1505923516.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/1] Buffers/caches in VirtIO Balloon driver
 stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

This is a QEMU counterpart to the patch for VirtIO balloon driver posted here:

https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg05720.html

Tomáš Golembiovský (1):
  virtio-balloon: include buffers and chached memory statistics

 hw/virtio/virtio-balloon.c                      | 2 ++
 include/standard-headers/linux/virtio_balloon.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.14.1
