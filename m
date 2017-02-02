Received: from eggs.gnu.org ([2001:4830:134:3::10]:39700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIkW-000527-Da
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIkV-0004Jz-Lc
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cZIkV-0004Jt-FP
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:35 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CB7F7E9DE
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 14:52:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  2 Feb 2017 18:51:30 +0400
Message-Id: <20170202145141.17138-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170202145141.17138-1-marcandre.lureau@redhat.com>
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/22] qcow2: remove useless NULL check
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

g_strdup() already handles the case where the argument is NULL.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/qcow2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 96fb8a8f16..9114218030 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2016,8 +2016,8 @@ static int qcow2_change_backing_file(BlockDriverSta=
te *bs,
     g_free(s->image_backing_file);
     g_free(s->image_backing_format);
=20
-    s->image_backing_file =3D backing_file ? g_strdup(bs->backing_file) =
: NULL;
-    s->image_backing_format =3D backing_fmt ? g_strdup(bs->backing_forma=
t) : NULL;
+    s->image_backing_file =3D g_strdup(bs->backing_file);
+    s->image_backing_format =3D g_strdup(bs->backing_format);
=20
     return qcow2_update_header(bs);
 }
--=20
2.11.0.295.gd7dffce1c.dirty
