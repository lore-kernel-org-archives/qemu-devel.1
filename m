Received: from eggs.gnu.org ([2001:4830:134:3::10]:53205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4By-000716-SI
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4Bt-00054v-Dp
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG4Bt-00054S-8G
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3968A80C0D
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 14:01:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:55 +0400
Message-Id: <20170531135709.345-32-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 31/45] acpi: use get_uint() for "pci-hole*"
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
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Those properties use visit_type_uint*()

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/acpi-build.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 8ae0373541..64a277b974 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -247,19 +247,19 @@ static void acpi_get_pci_holes(Range *hole, Range *=
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
2.13.0.91.g00982b8dd
