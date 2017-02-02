Received: from eggs.gnu.org ([2001:4830:134:3::10]:39471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIjx-00041K-6b
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIjw-0003w4-FC
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cZIjw-0003vH-9h
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:00 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60A343A76B0
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 14:52:00 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  2 Feb 2017 18:51:22 +0400
Message-Id: <20170202145141.17138-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170202145141.17138-1-marcandre.lureau@redhat.com>
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/22] xen: use a better chardev type check
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
2.11.0.295.gd7dffce1c.dirty
