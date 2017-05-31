Received: from eggs.gnu.org ([2001:4830:134:3::10]:52791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4Aq-00061v-LJ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4Ap-0004iz-Kd
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:00:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG4Ap-0004ig-EO
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:00:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62B9680C07
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 14:00:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:46 +0400
Message-Id: <20170531135709.345-23-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 22/45] isa: use get_uint() for "io-base"
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

The property is defined with DEFINE_PROP_UINT32().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/isa/isa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index c2fdd70cdc..95593408ef 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -29,7 +29,7 @@ static inline uint16_t applesmc_port(void)
     Object *obj =3D object_resolve_path_type("", TYPE_APPLE_SMC, NULL);
=20
     if (obj) {
-        return object_property_get_int(obj, APPLESMC_PROP_IO_BASE, NULL)=
;
+        return object_property_get_uint(obj, APPLESMC_PROP_IO_BASE, NULL=
);
     }
     return 0;
 }
--=20
2.13.0.91.g00982b8dd
