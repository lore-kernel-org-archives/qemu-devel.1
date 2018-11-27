Received: from eggs.gnu.org ([2001:4830:134:3::10]:49453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRdlS-0002RS-PL
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRdlO-0008Mm-TI
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:50:58 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51143)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1gRdlO-0008Lu-Nj
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:50:54 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20181127135053euoutp02b4ef6db79ac5dcf4e01c8eca3a27e713~q-2ox5gbh2240422404euoutp02U
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 13:50:53 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Tue, 27 Nov 2018 16:50:28 +0300
Message-Id: <20181127135030.1671-3-i.maximets@samsung.com>
In-Reply-To: <20181127135030.1671-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
References: <20181127135030.1671-1-i.maximets@samsung.com>
	<CGME20181127135052eucas1p2cec316cce9b9218e4ab476315fd4596b@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/4] memfd: always check for MFD_CLOEXEC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

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
