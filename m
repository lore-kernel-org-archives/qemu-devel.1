Received: from eggs.gnu.org ([2001:4830:134:3::10]:53038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4Bb-0006hl-Cj
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4BZ-0004xC-EF
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG4BZ-0004wl-8W
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39D1E80C1C
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 14:01:16 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:52 +0400
Message-Id: <20170531135709.345-29-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 28/45] platform-bus: use get_uint() for
 "addr" property
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
 hw/core/platform-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index 329ac670c0..33d32fbf22 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -71,7 +71,7 @@ hwaddr platform_bus_get_mmio_addr(PlatformBusDevice *pb=
us, SysBusDevice *sbdev,
         return -1;
     }
=20
-    return object_property_get_int(OBJECT(sbdev_mr), "addr", NULL);
+    return object_property_get_uint(OBJECT(sbdev_mr), "addr", NULL);
 }
=20
 static void platform_bus_count_irqs(SysBusDevice *sbdev, void *opaque)
--=20
2.13.0.91.g00982b8dd
