Received: from eggs.gnu.org ([2001:4830:134:3::10]:52937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4BI-0006PE-PG
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4BE-0004rb-JN
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG4BE-0004rV-CX
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:00:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BE877F6A0
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 14:00:55 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:49 +0400
Message-Id: <20170531135709.345-26-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 25/45] pcihp: use get_uint() for "bsel"
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

The property is defined with object_property_add_uint32_ptr()

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/acpi/pcihp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 3a531a4416..c420a388ea 100644
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
2.13.0.91.g00982b8dd
