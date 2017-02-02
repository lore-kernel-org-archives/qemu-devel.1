Received: from eggs.gnu.org ([2001:4830:134:3::10]:39821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIks-0005I5-9o
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIko-0004Sb-DG
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cZIko-0004SP-7T
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:54 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F4F78046F
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 14:52:54 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  2 Feb 2017 18:51:34 +0400
Message-Id: <20170202145141.17138-16-marcandre.lureau@redhat.com>
In-Reply-To: <20170202145141.17138-1-marcandre.lureau@redhat.com>
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 15/22] char-socket: add 'connected' property
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
 chardev/char-socket.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 075d6f671d..175cc18269 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1005,6 +1005,14 @@ char_socket_get_addr(Object *obj, Visitor *v, cons=
t char *name,
     visit_type_SocketAddress(v, name, &s->addr, errp);
 }
=20
+static bool
+char_socket_get_connected(Object *obj, Error **errp)
+{
+    SocketChardev *s =3D SOCKET_CHARDEV(obj);
+
+    return s->connected;
+}
+
 static void char_socket_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
@@ -1024,6 +1032,9 @@ static void char_socket_class_init(ObjectClass *oc,=
 void *data)
     object_class_property_add(oc, "addr", "SocketAddress",
                               char_socket_get_addr, NULL,
                               NULL, NULL, &error_abort);
+
+    object_class_property_add_bool(oc, "connected", char_socket_get_conn=
ected,
+                                   NULL, &error_abort);
 }
=20
 static const TypeInfo char_socket_type_info =3D {
--=20
2.11.0.295.gd7dffce1c.dirty
