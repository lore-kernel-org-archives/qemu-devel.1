Received: from eggs.gnu.org ([2001:4830:134:3::10]:45130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNITB-0004Gq-Mw
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNIT9-0002E4-Fa
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dNIT9-0002CK-23
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1D426A09
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 12:41:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 20 Jun 2017 14:40:56 +0200
Message-Id: <1497962468-22936-30-git-send-email-armbru@redhat.com>
In-Reply-To: <1497962468-22936-1-git-send-email-armbru@redhat.com>
References: <1497962468-22936-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 29/41] acpi: use get_uint() for "pci-hole*"
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

Those properties use visit_type_uint*()

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-30-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/acpi-build.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7c4c612..0b8bc62 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -237,19 +237,19 @@ static void acpi_get_pci_holes(Range *hole, Range *=
hole64)
     g_assert(pci_host);
=20
     range_set_bounds1(hole,
-                      object_property_get_int(pci_host,
-                                              PCI_HOST_PROP_PCI_HOLE_STA=
RT,
-                                              NULL),
-                      object_property_get_int(pci_host,
-                                              PCI_HOST_PROP_PCI_HOLE_END=
,
-                                              NULL));
+                      object_property_get_uint(pci_host,
+                                               PCI_HOST_PROP_PCI_HOLE_ST=
ART,
+                                               NULL),
+                      object_property_get_uint(pci_host,
+                                               PCI_HOST_PROP_PCI_HOLE_EN=
D,
+                                               NULL));
     range_set_bounds1(hole64,
-                      object_property_get_int(pci_host,
-                                              PCI_HOST_PROP_PCI_HOLE64_S=
TART,
-                                              NULL),
-                      object_property_get_int(pci_host,
-                                              PCI_HOST_PROP_PCI_HOLE64_E=
ND,
-                                              NULL));
+                      object_property_get_uint(pci_host,
+                                               PCI_HOST_PROP_PCI_HOLE64_=
START,
+                                               NULL),
+                      object_property_get_uint(pci_host,
+                                               PCI_HOST_PROP_PCI_HOLE64_=
END,
+                                               NULL));
 }
=20
 #define ACPI_PORT_SMI_CMD           0x00b2 /* TODO: this is APM_CNT_IOPO=
RT */
--=20
2.7.5
