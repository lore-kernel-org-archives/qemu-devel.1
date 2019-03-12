Received: from eggs.gnu.org ([209.51.188.92]:35699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3Vse-0008QX-9A
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3Vlt-0007U3-Hu
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:59:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h3Vlr-0007Sq-GI
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:59:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Mar 2019 21:59:29 -0300
Message-Id: <20190312005930.9043-7-ehabkost@redhat.com>
In-Reply-To: <20190312005930.9043-1-ehabkost@redhat.com>
References: <20190312005930.9043-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/7] memfd: set up correct errno if not supported
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

qemu_memfd_create() prints the value of 'errno' which is not
set in this case.

Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190311135850.6537-4-i.maximets@samsung.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 util/memfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/memfd.c b/util/memfd.c
index d74ce4d793..393d23da96 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -40,6 +40,7 @@ static int memfd_create(const char *name, unsigned int =
flags)
 #ifdef __NR_memfd_create
     return syscall(__NR_memfd_create, name, flags);
 #else
+    errno =3D ENOSYS;
     return -1;
 #endif
 }
--=20
2.18.0.rc1.1.g3f1ff2140
