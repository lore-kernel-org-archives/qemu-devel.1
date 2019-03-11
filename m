Received: from eggs.gnu.org ([209.51.188.92]:51281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1h3LSf-00004s-C1
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1h3LSd-0000UZ-Sf
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:59:24 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46885)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1h3LSd-0000Tp-K7
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:59:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
	20190311135920euoutp01da8fa0ffdf62aa7431f41a385f0a6dff~K7DtEAwTp1023410234euoutp01S
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 13:59:20 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Mon, 11 Mar 2019 16:58:48 +0300
Message-Id: <20190311135850.6537-3-i.maximets@samsung.com>
In-Reply-To: <20190311135850.6537-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
References: <20190311135850.6537-1-i.maximets@samsung.com>
	<CGME20190311135919eucas1p11c7fad66884a0303b2637cd2d2b05cad@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/4] memfd: always check for MFD_CLOEXEC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

QEMU always sets this flag unconditionally. We need to
check if it's supported.

Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 util/memfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/memfd.c b/util/memfd.c
index 8debd0d037..d74ce4d793 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -188,7 +188,7 @@ bool qemu_memfd_alloc_check(void)
 bool qemu_memfd_check(unsigned int flags)
 {
 #ifdef CONFIG_LINUX
-    int mfd =3D memfd_create("test", flags);
+    int mfd =3D memfd_create("test", flags | MFD_CLOEXEC);
=20
     if (mfd >=3D 0) {
         close(mfd);
--=20
2.17.1
