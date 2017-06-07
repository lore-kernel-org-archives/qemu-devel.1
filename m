Received: from eggs.gnu.org ([2001:4830:134:3::10]:34297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIe1O-0002Cr-Lm
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIe1N-0000yC-UY
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIe1N-0000xs-Of
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDDAB19C336
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 16:41:24 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 20:36:28 +0400
Message-Id: <20170607163635.17635-37-marcandre.lureau@redhat.com>
In-Reply-To: <20170607163635.17635-1-marcandre.lureau@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 36/43] pvpanic: use get_uint() for "ioport"
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

TYPE_ISA_PVPANIC_DEVICE's property PVPANIC_IOPORT_PROP is defined with
DEFINE_PROP_UINT16().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/misc/pvpanic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 57da7f2199..2b1e9a6450 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -111,7 +111,7 @@ uint16_t pvpanic_port(void)
     if (!o) {
         return 0;
     }
-    return object_property_get_int(o, PVPANIC_IOPORT_PROP, NULL);
+    return object_property_get_uint(o, PVPANIC_IOPORT_PROP, NULL);
 }
=20
 static Property pvpanic_isa_properties[] =3D {
--=20
2.13.0.91.g00982b8dd
