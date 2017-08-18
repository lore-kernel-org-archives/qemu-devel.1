Received: from eggs.gnu.org ([2001:4830:134:3::10]:60910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDc-0004OX-4N
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDZ-0000rf-KG
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dieDZ-0000rC-EG
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 879CA37EEF
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:09:28 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 079925D743
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:09:27 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 18 Aug 2017 12:08:59 +0200
Message-Id: <1503050939-227939-28-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.11 27/27] fix build failure in
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
