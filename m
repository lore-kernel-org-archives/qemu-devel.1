Received: from eggs.gnu.org ([208.118.235.92]:43827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTJj-0003Qh-MD
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTJi-000170-UV
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gfTJi-00011A-Mi
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:30 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  4 Jan 2019 21:30:19 +0400
Message-Id: <20190104173042.32714-6-marcandre.lureau@redhat.com>
In-Reply-To: <20190104173042.32714-1-marcandre.lureau@redhat.com>
References: <20190104173042.32714-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/28] hw: remove SET_MACHINE_COMPAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

No longer needed.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index f14c38bb63..0566742412 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -288,16 +288,4 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
=20
-#define SET_MACHINE_COMPAT(m, compat) \
-    do {                              \
-        int i;                        \
-        if (!m->compat_props) { \
-            m->compat_props =3D g_array_new(false, false, sizeof(void *)=
); \
-        } \
-        for (i =3D 0; i < G_N_ELEMENTS(compat); i++) {          \
-            GlobalProperty *prop =3D &compat[i];          \
-            g_array_append_val(m->compat_props, prop); \
-        }                                              \
-    } while (0)
-
 #endif
--=20
2.20.1.2.gb21ebb671b
