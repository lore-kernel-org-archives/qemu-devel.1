Received: from eggs.gnu.org ([2001:4830:134:3::10]:45280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNITH-0004Nf-HM
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNITA-0002FT-KS
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dNITA-0002E8-6i
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 096A980F7D
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 12:41:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 20 Jun 2017 14:41:03 +0200
Message-Id: <1497962468-22936-37-git-send-email-armbru@redhat.com>
In-Reply-To: <1497962468-22936-1-git-send-email-armbru@redhat.com>
References: <1497962468-22936-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 36/41] pvpanic: use get_uint() for "ioport"
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

TYPE_ISA_PVPANIC_DEVICE's property PVPANIC_IOPORT_PROP is defined with
DEFINE_PROP_UINT16().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-37-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/misc/pvpanic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 57da7f2..2b1e9a6 100644
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
2.7.5
