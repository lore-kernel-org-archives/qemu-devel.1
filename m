Received: from eggs.gnu.org ([2001:4830:134:3::10]:53454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4Cd-0007t6-Gh
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4CX-0005E7-Q7
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:02:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG4CX-0005E3-KS
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:02:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 966DA80F9D
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 14:02:16 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:57:00 +0400
Message-Id: <20170531135709.345-37-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 36/45] arm: use get_uint() for "mp-affinity"
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

TYPE_ARM_CPU's property "mp-affinity" is defined with
DEFINE_PROP_UINT64().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/intc/arm_gicv3_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index c6493d6c07..e2064cd8c5 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -267,7 +267,7 @@ static void arm_gicv3_common_realize(DeviceState *dev=
, Error **errp)
          *  VLPIS =3D=3D 0 (virtual LPIs not supported)
          *  PLPIS =3D=3D 0 (physical LPIs not supported)
          */
-        cpu_affid =3D object_property_get_int(OBJECT(cpu), "mp-affinity"=
, NULL);
+        cpu_affid =3D object_property_get_uint(OBJECT(cpu), "mp-affinity=
", NULL);
         last =3D (i =3D=3D s->num_cpu - 1);
=20
         /* The CPU mp-affinity property is in MPIDR register format; squ=
ash
--=20
2.13.0.91.g00982b8dd
