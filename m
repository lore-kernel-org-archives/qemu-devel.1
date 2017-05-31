Received: from eggs.gnu.org ([2001:4830:134:3::10]:53493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4Cn-00081S-GF
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4Cj-0005KR-CA
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:02:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG4Cj-0005K9-6Z
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:02:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3300F80465
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 14:02:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:57:01 +0400
Message-Id: <20170531135709.345-38-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 37/45] auxbus: use get_uint() for "addr"
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

This is TYPE_MEMORY_REGION's property.  Its getter
memory_region_get_addr() uses visit_type_uint64().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/misc/auxbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index e4a7ba41de..8a90ddda84 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -244,7 +244,7 @@ static void aux_slave_dev_print(Monitor *mon, DeviceS=
tate *dev, int indent)
=20
     monitor_printf(mon, "%*smemory " TARGET_FMT_plx "/" TARGET_FMT_plx "=
\n",
                    indent, "",
-                   object_property_get_int(OBJECT(s->mmio), "addr", NULL=
),
+                   object_property_get_uint(OBJECT(s->mmio), "addr", NUL=
L),
                    memory_region_size(s->mmio));
 }
=20
--=20
2.13.0.91.g00982b8dd
