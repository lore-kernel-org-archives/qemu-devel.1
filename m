Received: from eggs.gnu.org ([2001:4830:134:3::10]:53406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCNj-0001ym-Rq
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCNh-00065O-LB
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:49:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCNh-00064F-B5
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:49:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C21030DDBD5
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 21:49:24 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 01:48:27 +0400
Message-Id: <20181212214850.29953-6-marcandre.lureau@redhat.com>
In-Reply-To: <20181212214850.29953-1-marcandre.lureau@redhat.com>
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 05/28] hw: remove SET_MACHINE_COMPAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com

No longer needed.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/boards.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index f02d5a1bbd..f743d9d4a4 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -287,16 +287,4 @@ struct MachineState {
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
2.20.0
