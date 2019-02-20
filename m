Received: from eggs.gnu.org ([209.51.188.92]:41086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGPb-00052u-DY
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGPK-0004bw-Sf
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:10:48 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 Feb 2019 02:02:24 +0100
Message-Id: <20190220010232.18731-18-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-1-philmd@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 17/25] net/filter-mirror: Use size_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Since iov_size() returns a size_t, no need to use a signed type.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 net/filter-mirror.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 3a61cf21e8..97b52d0544 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -48,7 +48,7 @@ static int filter_send(MirrorState *s,
 {
     NetFilterState *nf =3D NETFILTER(s);
     int ret =3D 0;
-    ssize_t size =3D 0;
+    size_t size =3D 0;
     uint32_t len =3D 0;
     char *buf;
=20
--=20
2.20.1
