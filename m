Received: from eggs.gnu.org ([2001:4830:134:3::10]:51275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRbH2-0003PV-84
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRbGw-0004rw-4K
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:11:22 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1gRbGu-0004rH-Sp
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:11:17 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
	20181127111115euoutp017b396c2d699ae546bae4f6b8130dc027~q9rQoX2Za3199131991euoutp01C
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 11:11:15 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Tue, 27 Nov 2018 14:10:48 +0300
Message-Id: <20181127111050.18453-3-i.maximets@samsung.com>
In-Reply-To: <20181127111050.18453-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
References: <20181127111050.18453-1-i.maximets@samsung.com>
	<CGME20181127111114eucas1p21c991b4dd272c8afa803f90c178030a6@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] memfd: always check for MFD_CLOEXEC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

QEMU always sets this flag unconditionally. We need to
check if it's supported.

Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
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
