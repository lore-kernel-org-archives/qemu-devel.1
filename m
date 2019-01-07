Received: from eggs.gnu.org ([209.51.188.92]:50208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ggU4c-0007m3-Hv
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ggU4a-0001D4-7Q
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:32:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ggU4Z-000198-Nb
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:32:03 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  7 Jan 2019 16:22:41 +0400
Message-Id: <20190107122304.22997-6-marcandre.lureau@redhat.com>
In-Reply-To: <20190107122304.22997-1-marcandre.lureau@redhat.com>
References: <20190107122304.22997-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 05/28] hw: remove SET_MACHINE_COMPAT
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
