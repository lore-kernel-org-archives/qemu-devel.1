Received: from eggs.gnu.org ([2001:4830:134:3::10]:38509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGM-0000kG-JU
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGH-0003b2-Tu
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJKGH-0003Zb-Fr
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 428E78047D
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 13:47:36 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  9 Jun 2017 15:47:11 +0200
Message-Id: <1497016045-6009-28-git-send-email-armbru@redhat.com>
In-Reply-To: <1497016045-6009-1-git-send-email-armbru@redhat.com>
References: <1497016045-6009-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/41] acpi: use get_uint() for "acpi-pcihp-io*"
 properties
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

Those are defined with object_property_add_uint16_ptr()

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-28-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/acpi-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b2dc3d8..d1ffce7 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -136,9 +136,9 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
         obj =3D piix;
         pm->cpu_hp_io_base =3D PIIX4_CPU_HOTPLUG_IO_BASE;
         pm->pcihp_io_base =3D
-            object_property_get_int(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
+            object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL)=
;
         pm->pcihp_io_len =3D
-            object_property_get_int(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
+            object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
     }
     if (lpc) {
         obj =3D lpc;
--=20
2.7.5
