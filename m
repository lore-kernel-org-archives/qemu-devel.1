Received: from eggs.gnu.org ([2001:4830:134:3::10]:45081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNITA-0004Fl-PC
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNIT8-0002D0-Ti
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dNIT8-0002C4-Lp
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A11538EB41
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 12:41:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 20 Jun 2017 14:40:51 +0200
Message-Id: <1497962468-22936-25-git-send-email-armbru@redhat.com>
In-Reply-To: <1497962468-22936-1-git-send-email-armbru@redhat.com>
References: <1497962468-22936-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 24/41] aspeed: use {set,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This property is an alias for device TYPE_ASPEED_SDMC's property
"ram-size", which is defined with DEFINE_PROP_UINT64().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-25-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/aspeed.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 155eeb2..db3f6d2 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -180,8 +180,8 @@ static void aspeed_board_init(MachineState *machine,
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
@@ -193,8 +193,8 @@ static void aspeed_board_init(MachineState *machine,
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
2.7.5
