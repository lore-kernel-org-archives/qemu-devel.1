Received: from eggs.gnu.org ([2001:4830:134:3::10]:53136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cb5nx-0005XS-3u
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:27:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cb5nw-0007oe-Ek
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:27:33 -0500
From: Fam Zheng <famz@redhat.com>
Date: Tue,  7 Feb 2017 21:27:21 +0800
Message-Id: <20170207132723.13934-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] virtio-blk: clean up around g_free() and
 inline a few functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org



Fam Zheng (2):
  virtio-blk: Remove useless condition around g_free()
  virtio-blk: Inline request init, complete and free functions

 hw/block/virtio-blk.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.9.3
