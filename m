Received: from eggs.gnu.org ([2001:4830:134:3::10]:54011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4Ec-0000yr-3p
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4EZ-00068u-SY
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:04:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG4EZ-000689-Mp
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:04:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B473A8046E
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 14:04:22 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:57:06 +0400
Message-Id: <20170531135709.345-43-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 42/45] console: use get_uint() for "head"
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

TYPE_QEMU_CONSOLE property "head" is defined with
object_property_add_uint*_ptr().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index ac66b3c910..ad3f7c6a2c 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1872,8 +1872,8 @@ QemuConsole *qemu_console_lookup_by_device(DeviceSt=
ate *dev, uint32_t head)
         if (DEVICE(obj) !=3D dev) {
             continue;
         }
-        h =3D object_property_get_int(OBJECT(consoles[i]),
-                                    "head", &error_abort);
+        h =3D object_property_get_uint(OBJECT(consoles[i]),
+                                     "head", &error_abort);
         if (h !=3D head) {
             continue;
         }
--=20
2.13.0.91.g00982b8dd
