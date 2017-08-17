Received: from eggs.gnu.org ([2001:4830:134:3::10]:38134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1diNR7-00083h-K3
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1diNR4-00076W-Ef
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:14:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1diNR4-00076M-8E
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:14:18 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 17 Aug 2017 18:14:13 +0200
Message-Id: <1502986453-223221-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.10???] fix build failure in
 nbd_read_reply_entry()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org

travis builds fail at HEAD at rc3 master with

  block/nbd-client.c: In function =E2=80=98nbd_read_reply_entry=E2=80=99:
  block/nbd-client.c:110:8: error: =E2=80=98ret=E2=80=99 may be used unin=
itialized in this function [-Werror=3Duninitialized]

fix it by initializing 'ret' to 0

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 block/nbd-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 422ecb4..02c8e20 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -70,7 +70,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opa=
que)
 {
     NBDClientSession *s =3D opaque;
     uint64_t i;
-    int ret;
+    int ret =3D 0;
     Error *local_err =3D NULL;
=20
     while (!s->quit) {
--=20
2.7.4
