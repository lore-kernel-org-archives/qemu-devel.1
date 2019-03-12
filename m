Received: from eggs.gnu.org ([209.51.188.92]:35654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3Vse-0008QM-Ao
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3Vlr-0007TC-JS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:59:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h3Vlp-0007QD-JC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:59:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Mar 2019 21:59:28 -0300
Message-Id: <20190312005930.9043-6-ehabkost@redhat.com>
In-Reply-To: <20190312005930.9043-1-ehabkost@redhat.com>
References: <20190312005930.9043-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/7] memfd: always check for MFD_CLOEXEC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Ilya Maximets <i.maximets@samsung.com>

From: Ilya Maximets <i.maximets@samsung.com>

QEMU always sets this flag unconditionally. We need to
check if it's supported.

Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190311135850.6537-3-i.maximets@samsung.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
2.18.0.rc1.1.g3f1ff2140
