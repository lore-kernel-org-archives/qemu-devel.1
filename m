Received: from eggs.gnu.org ([2001:4830:134:3::10]:33811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIe0K-000175-0W
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIe0G-0000Du-Ss
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:40:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIe0G-0000DT-NR
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:40:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BACE71766AE
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 16:40:15 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 20:36:19 +0400
Message-Id: <20170607163635.17635-28-marcandre.lureau@redhat.com>
In-Reply-To: <20170607163635.17635-1-marcandre.lureau@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 27/43] acpi: use get_uint() for
 "acpi-pcihp-io*" properties
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

Those are defined with object_property_add_uint16_ptr()

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/acpi-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b2dc3d8580..d1ffce7ce3 100644
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
2.13.0.91.g00982b8dd
