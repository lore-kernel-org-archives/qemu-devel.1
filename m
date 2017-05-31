Received: from eggs.gnu.org ([2001:4830:134:3::10]:52949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4BQ-0006Vh-59
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4BL-0004sK-I6
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG4BL-0004sC-3P
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E40C637EEE
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 14:01:01 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:50 +0400
Message-Id: <20170531135709.345-27-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 26/45] aspeed: use {set,
 get}_uint() for "ram-size" property
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

This property is an alias for device TYPE_ASPEED_SDMC's property
"ram-size", which is defined with DEFINE_PROP_UINT64().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/aspeed.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 283c038814..0c6cd17d0d 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -174,8 +174,8 @@ static void aspeed_board_init(MachineState *machine,
=20
     sc =3D ASPEED_SOC_GET_CLASS(&bmc->soc);
=20
-    object_property_set_int(OBJECT(&bmc->soc), ram_size, "ram-size",
-                           &error_abort);
+    object_property_set_uint(OBJECT(&bmc->soc), ram_size, "ram-size",
+                             &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), cfg->hw_strap1, "hw-strap=
1",
                             &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), cfg->num_cs, "num-cs",
@@ -187,8 +187,8 @@ static void aspeed_board_init(MachineState *machine,
      * Allocate RAM after the memory controller has checked the size
      * was valid. If not, a default value is used.
      */
-    ram_size =3D object_property_get_int(OBJECT(&bmc->soc), "ram-size",
-                                       &error_abort);
+    ram_size =3D object_property_get_uint(OBJECT(&bmc->soc), "ram-size",
+                                        &error_abort);
=20
     memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_siz=
e);
     memory_region_add_subregion(get_system_memory(), sc->info->sdram_bas=
e,
--=20
2.13.0.91.g00982b8dd
