Received: from eggs.gnu.org ([209.51.188.92]:53864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gle55-0002CP-R7
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:13:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gle53-00026P-3L
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:13:54 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 21 Jan 2019 19:13:35 +0100
Message-Id: <20190121181335.3326-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] virtio-net: Fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Wei Xu <wexu@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Fixes: 2974e916df8
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/virtio/virtio-net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
index c7ec1a755f..756eee8af0 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -94,7 +94,7 @@ typedef struct VirtioNetRscUnit {
     uint16_t payload;       /* pure payload without virtio/eth/ip/tcp */
 } VirtioNetRscUnit;
=20
-/* Coalesced segmant */
+/* Coalesced segment */
 typedef struct VirtioNetRscSeg {
     QTAILQ_ENTRY(VirtioNetRscSeg) next;
     void *buf;
--=20
2.20.1
