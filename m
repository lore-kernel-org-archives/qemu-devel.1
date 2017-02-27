Received: from eggs.gnu.org ([2001:4830:134:3::10]:53241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ciLZQ-0001Xm-4v
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ciLZN-0001Xd-1I
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:42:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ciLZM-0001XO-Rm
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:42:28 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B92BC04B93B
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 13:42:29 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Feb 2017 17:41:44 +0400
Message-Id: <20170227134202.2991-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170227134202.2991-1-marcandre.lureau@redhat.com>
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/21] xen: use a better chardev type check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 xen-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xen-common.c b/xen-common.c
index fd2c92847e..d46685ef4e 100644
--- a/xen-common.c
+++ b/xen-common.c
@@ -34,7 +34,7 @@ static int store_dev_info(int domid, Chardev *cs, const=
 char *string)
     int ret =3D -1;
=20
     /* Only continue if we're talking to a pty. */
-    if (strncmp(cs->filename, "pty:", 4)) {
+    if (!CHARDEV_IS_PTY(cs)) {
         return 0;
     }
     pts =3D cs->filename + 4;
--=20
2.12.0.rc2.3.gc93709801
