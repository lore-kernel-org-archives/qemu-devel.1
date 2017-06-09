Received: from eggs.gnu.org ([2001:4830:134:3::10]:38589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGO-0000lk-2C
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGI-0003cp-QJ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJKGI-0003b0-Ia
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68ECF81236
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 13:47:37 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  9 Jun 2017 15:47:22 +0200
Message-Id: <1497016045-6009-39-git-send-email-armbru@redhat.com>
In-Reply-To: <1497016045-6009-1-git-send-email-armbru@redhat.com>
References: <1497016045-6009-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 38/41] numa: use get_uint() for "size" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

"size" is a property of TYPE_MEMORY_BACKEND.
host_memory_backend_get_size() and host_memory_backend_set_size() use
visit_type_size().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-39-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 numa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/numa.c b/numa.c
index 65701cb..b0e75f6 100644
--- a/numa.c
+++ b/numa.c
@@ -216,7 +216,7 @@ static void parse_numa_node(MachineState *ms, NumaNod=
eOptions *node,
         }
=20
         object_ref(o);
-        numa_info[nodenr].node_mem =3D object_property_get_int(o, "size"=
, NULL);
+        numa_info[nodenr].node_mem =3D object_property_get_uint(o, "size=
", NULL);
         numa_info[nodenr].node_memdev =3D MEMORY_BACKEND(o);
     }
     numa_info[nodenr].present =3D true;
@@ -641,8 +641,8 @@ static int query_memdev(Object *obj, void *opaque)
         m->value->id =3D object_property_get_str(obj, "id", NULL);
         m->value->has_id =3D !!m->value->id;
=20
-        m->value->size =3D object_property_get_int(obj, "size",
-                                                 &error_abort);
+        m->value->size =3D object_property_get_uint(obj, "size",
+                                                  &error_abort);
         m->value->merge =3D object_property_get_bool(obj, "merge",
                                                    &error_abort);
         m->value->dump =3D object_property_get_bool(obj, "dump",
--=20
2.7.5
