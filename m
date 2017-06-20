Received: from eggs.gnu.org ([2001:4830:134:3::10]:45094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNITB-0004G2-1q
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNIT9-0002DP-8P
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dNIT8-0002CV-Vm
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6A114ACCB
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 12:41:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 20 Jun 2017 14:40:50 +0200
Message-Id: <1497962468-22936-24-git-send-email-armbru@redhat.com>
In-Reply-To: <1497962468-22936-1-git-send-email-armbru@redhat.com>
References: <1497962468-22936-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 23/41] pcihp: use get_uint() for "bsel"
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

The property is defined with object_property_add_uint32_ptr()

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-24-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/acpi/pcihp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 3a531a4..c420a38 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -62,10 +62,10 @@ typedef struct AcpiPciHpFind {
 static int acpi_pcihp_get_bsel(PCIBus *bus)
 {
     Error *local_err =3D NULL;
-    int64_t bsel =3D object_property_get_int(OBJECT(bus), ACPI_PCIHP_PRO=
P_BSEL,
-                                           &local_err);
+    uint64_t bsel =3D object_property_get_uint(OBJECT(bus), ACPI_PCIHP_P=
ROP_BSEL,
+                                             &local_err);
=20
-    if (local_err || bsel < 0 || bsel >=3D ACPI_PCIHP_MAX_HOTPLUG_BUS) {
+    if (local_err || bsel >=3D ACPI_PCIHP_MAX_HOTPLUG_BUS) {
         if (local_err) {
             error_free(local_err);
         }
--=20
2.7.5
