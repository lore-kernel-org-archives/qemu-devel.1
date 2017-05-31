Received: from eggs.gnu.org ([2001:4830:134:3::10]:53252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4C5-00077S-JT
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4Bz-00057f-SV
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG4Bz-00057R-M9
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 954603DBF5
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 14:01:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:56 +0400
Message-Id: <20170531135709.345-33-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 32/45] pc: use get_uint() for "iobase"
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

TYPE_ISA_FDC's property "iobase" is defined with DEFINE_PROP_UINT32().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 107a34125b..3e8f8e83b2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -347,7 +347,7 @@ static int check_fdc(Object *obj, void *opaque)
         return 0;
     }
=20
-    iobase =3D object_property_get_int(obj, "iobase", &local_err);
+    iobase =3D object_property_get_uint(obj, "iobase", &local_err);
     if (local_err || iobase !=3D 0x3f0) {
         error_free(local_err);
         return 0;
--=20
2.13.0.91.g00982b8dd
