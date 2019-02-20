Received: from eggs.gnu.org ([209.51.188.92]:41086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGPj-00052u-Bv
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGP5-0004T4-7Y
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:10:33 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 Feb 2019 02:02:26 +0100
Message-Id: <20190220010232.18731-20-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-1-philmd@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 19/25] s390/ebcdic: Use size_t to iterate
 over arrays
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/s390x/ebcdic.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/s390x/ebcdic.h b/include/hw/s390x/ebcdic.h
index 69a04cab62..d89174e113 100644
--- a/include/hw/s390x/ebcdic.h
+++ b/include/hw/s390x/ebcdic.h
@@ -83,18 +83,18 @@ static const uint8_t ascii2ebcdic[] =3D {
     0x90, 0x3F, 0x3F, 0x3F, 0x3F, 0xEA, 0x3F, 0xFF
 };
=20
-static inline void ebcdic_put(uint8_t *p, const char *ascii, int len)
+static inline void ebcdic_put(uint8_t *p, const char *ascii, size_t len)
 {
-    int i;
+    size_t i;
=20
     for (i =3D 0; i < len; i++) {
         p[i] =3D ascii2ebcdic[(uint8_t)ascii[i]];
     }
 }
=20
-static inline void ascii_put(uint8_t *p, const char *ebcdic, int len)
+static inline void ascii_put(uint8_t *p, const char *ebcdic, size_t len)
 {
-    int i;
+    size_t i;
=20
     for (i =3D 0; i < len; i++) {
         p[i] =3D ebcdic2ascii[(uint8_t)ebcdic[i]];
--=20
2.20.1
