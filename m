Received: from eggs.gnu.org ([2001:4830:134:3::10]:38507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGM-0000kD-JS
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGI-0003cH-8s
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJKGH-0003aK-Up
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA8C761D12
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 13:47:36 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  9 Jun 2017 15:47:19 +0200
Message-Id: <1497016045-6009-36-git-send-email-armbru@redhat.com>
In-Reply-To: <1497016045-6009-1-git-send-email-armbru@redhat.com>
References: <1497016045-6009-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 35/41] auxbus: use get_uint() for "addr" property
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

This is TYPE_MEMORY_REGION's property.  Its getter
memory_region_get_addr() uses visit_type_uint64().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-36-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/misc/auxbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index e4a7ba4..8a90ddd 100644
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
2.7.5
