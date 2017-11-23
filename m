Received: from eggs.gnu.org ([2001:4830:134:3::10]:38280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrbO-00012e-SX
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrbL-00015p-O6
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:31:38 -0500
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:50149)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrbL-000146-Ho
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:31:35 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 5376A175AB6
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:31:34 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:37 +0100
Message-Id: <20171123132955.1261-8-clg@kaod.org>
In-Reply-To: <20171123132955.1261-1-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/25] migration: add
 VMSTATE_STRUCT_VARRAY_UINT32_ALLOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/migration/vmstate.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 88b55df5ae0c..c0bf06e7bf89 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -560,6 +560,16 @@ extern const VMStateInfo vmstate_info_qtailq;
     .offset     =3D vmstate_offset_pointer(_state, _field, _type),     \
 }
=20
+#define VMSTATE_STRUCT_VARRAY_UINT32_ALLOC(_field, _state, _field_num, _=
version, _vmsd, _type) {\
+    .name       =3D (stringify(_field)),                               \
+    .version_id =3D (_version),                                        \
+    .vmsd       =3D &(_vmsd),                                          \
+    .num_offset =3D vmstate_offset_value(_state, _field_num, uint32_t), =
\
+    .size       =3D sizeof(_type),                                     \
+    .flags      =3D VMS_STRUCT|VMS_VARRAY_UINT32|VMS_ALLOC|VMS_POINTER, =
\
+    .offset     =3D vmstate_offset_pointer(_state, _field, _type),     \
+}
+
 #define VMSTATE_STATIC_BUFFER(_field, _state, _version, _test, _start, _=
size) { \
     .name         =3D (stringify(_field)),                             \
     .version_id   =3D (_version),                                      \
--=20
2.13.6
