Received: from eggs.gnu.org ([209.51.188.92]:33924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hEy5P-000407-4k
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hEy5O-00052A-7E
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:27:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hEy5N-00051F-WD
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:27:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0775E5946F
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 15:27:24 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 12 Apr 2019 17:27:12 +0200
Message-Id: <20190412152713.16018-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190412152713.16018-1-marcandre.lureau@redhat.com>
References: <20190412152713.16018-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] vl: constify VGAInterfaceInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 vl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index c696ad2a13..0a96232e95 100644
--- a/vl.c
+++ b/vl.c
@@ -2026,7 +2026,7 @@ typedef struct VGAInterfaceInfo {
     const char *class_names[2];
 } VGAInterfaceInfo;
=20
-static VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX] =3D {
+static const VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX] =3D {
     [VGA_NONE] =3D {
         .opt_name =3D "none",
     },
@@ -2072,7 +2072,7 @@ static VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX=
] =3D {
=20
 static bool vga_interface_available(VGAInterfaceType t)
 {
-    VGAInterfaceInfo *ti =3D &vga_interfaces[t];
+    const VGAInterfaceInfo *ti =3D &vga_interfaces[t];
=20
     assert(t < VGA_TYPE_MAX);
     return !ti->class_names[0] ||
@@ -2087,7 +2087,7 @@ static void select_vgahw(const char *p)
=20
     assert(vga_interface_type =3D=3D VGA_NONE);
     for (t =3D 0; t < VGA_TYPE_MAX; t++) {
-        VGAInterfaceInfo *ti =3D &vga_interfaces[t];
+        const VGAInterfaceInfo *ti =3D &vga_interfaces[t];
         if (ti->opt_name && strstart(p, ti->opt_name, &opts)) {
             if (!vga_interface_available(t)) {
                 error_report("%s not available", ti->name);
--=20
2.21.0.313.ge35b8cb8e2
