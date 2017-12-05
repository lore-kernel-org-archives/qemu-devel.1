Received: from eggs.gnu.org ([2001:4830:134:3::10]:52828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eMC7h-0003bd-QY
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eMC7e-0004EH-26
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:14:53 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:43920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1eMC7d-0004Dm-S7
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:14:49 -0500
Received: by mail-wm0-f65.google.com with SMTP id n138so882812wmg.2
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 04:14:49 -0800 (PST)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue,  5 Dec 2017 13:14:45 +0100
Message-Id: <cover.1512476043.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/1] Disk caches in VirtIO Balloon driver
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

https://lists.nongnu.org/archive/html/qemu-devel/2017-11/msg02106.html

Tomáš Golembiovský (1):
  virtio-balloon: include statistics of disk/file caches

 hw/virtio/virtio-balloon.c                      | 1 +
 include/standard-headers/linux/virtio_balloon.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.15.1
