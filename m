Received: from eggs.gnu.org ([2001:4830:134:3::10]:50087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dv11D-0005Ok-80
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dv117-00075M-NK
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:55:51 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:49316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dv117-00074x-El
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:55:45 -0400
Received: by mail-wm0-f53.google.com with SMTP id r74so1542228wme.4
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 05:55:45 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Thu, 21 Sep 2017 14:55:40 +0200
Message-Id: <cover.1505998455.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/1] linux: Buffers/caches in VirtIO Balloon
 driver stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-mm@kvack.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>, Shaohua Li <shli@fb.com>, Huang Ying <ying.huang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Linux driver part

v2:
- fixed typos

Tomáš Golembiovský (1):
  virtio_balloon: include buffers and cached memory statistics

 drivers/virtio/virtio_balloon.c     | 11 +++++++++++
 include/uapi/linux/virtio_balloon.h |  4 +++-
 mm/swap_state.c                     |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.14.1
