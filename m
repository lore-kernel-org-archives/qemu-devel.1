Received: from eggs.gnu.org ([2001:4830:134:3::10]:47836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUBa0-0004sz-EU
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:21:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUBZx-00078F-46
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:21:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gUBZw-00077s-UW
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:21:37 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  4 Dec 2018 18:20:13 +0400
Message-Id: <20181204142023.15982-10-marcandre.lureau@redhat.com>
In-Reply-To: <20181204142023.15982-1-marcandre.lureau@redhat.com>
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v5 09/19] hw: remove SET_MACHINE_COMPAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

No longer needed.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/boards.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 28c2b0af41..f743d9d4a4 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -287,20 +287,4 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
=20
-#define SET_MACHINE_COMPAT(m, COMPAT) \
-    do {                              \
-        int i;                        \
-        static GlobalProperty props[] =3D {       \
-            COMPAT                              \
-            { /* end of list */ }               \
-        };                                      \
-        if (!m->compat_props) { \
-            m->compat_props =3D g_array_new(false, false, sizeof(void *)=
); \
-        } \
-        for (i =3D 0; props[i].driver !=3D NULL; i++) {    \
-            GlobalProperty *prop =3D &props[i];          \
-            g_array_append_val(m->compat_props, prop); \
-        }                                              \
-    } while (0)
-
 #endif
--=20
2.20.0.rc1
