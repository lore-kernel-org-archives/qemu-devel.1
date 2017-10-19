Received: from eggs.gnu.org ([2001:4830:134:3::10]:43556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e57gu-0002q0-0X
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 06:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e57gr-00081Z-Dn
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 06:04:40 -0400
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:56150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e57gr-00080g-6m
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 06:04:37 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id B7D5514173A
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 12:04:35 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Oct 2017 12:04:04 +0200
Message-Id: <20171019100410.26239-3-clg@kaod.org>
In-Reply-To: <20171019100410.26239-1-clg@kaod.org>
References: <20171019100410.26239-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 2/8] aspeed: remove
 ignore_memory_transaction_failures on all boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Now that we have a dummy ROM device catching the invalid writes, we
can remove this flag and work on fixing the current firwmares still
accessing unimplemented addresses.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index e44733153819..dbb02f568462 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -294,7 +294,6 @@ static void palmetto_bmc_class_init(ObjectClass *oc, =
void *data)
     mc->no_floppy =3D 1;
     mc->no_cdrom =3D 1;
     mc->no_parallel =3D 1;
-    mc->ignore_memory_transaction_failures =3D true;
 }
=20
 static const TypeInfo palmetto_bmc_type =3D {
@@ -327,7 +326,6 @@ static void ast2500_evb_class_init(ObjectClass *oc, v=
oid *data)
     mc->no_floppy =3D 1;
     mc->no_cdrom =3D 1;
     mc->no_parallel =3D 1;
-    mc->ignore_memory_transaction_failures =3D true;
 }
=20
 static const TypeInfo ast2500_evb_type =3D {
@@ -352,7 +350,6 @@ static void romulus_bmc_class_init(ObjectClass *oc, v=
oid *data)
     mc->no_floppy =3D 1;
     mc->no_cdrom =3D 1;
     mc->no_parallel =3D 1;
-    mc->ignore_memory_transaction_failures =3D true;
 }
=20
 static const TypeInfo romulus_bmc_type =3D {
--=20
2.13.6
