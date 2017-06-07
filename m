Received: from eggs.gnu.org ([2001:4830:134:3::10]:34161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIe0y-0001pI-Lb
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIe0x-0000ll-88
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIe0x-0000kn-2I
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:40:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1788D1766B4
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 16:40:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 20:36:25 +0400
Message-Id: <20170607163635.17635-34-marcandre.lureau@redhat.com>
In-Reply-To: <20170607163635.17635-1-marcandre.lureau@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 33/43] xen: use get_uint() for
 "max-ram-below-4g" property
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

TYPE_PC_MACHINE's property PC_MACHINE_MAX_RAM_BELOW_4G's getter and
setter pc_machine_get_max_ram_below_4g() and
pc_machine_set_max_ram_below_4g() use visit_type_size()

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/xen/xen-hvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 1acd4de405..cffa7e2017 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -182,9 +182,9 @@ static void xen_ram_init(PCMachineState *pcms,
 {
     MemoryRegion *sysmem =3D get_system_memory();
     ram_addr_t block_len;
-    uint64_t user_lowmem =3D object_property_get_int(qdev_get_machine(),
-                                                   PC_MACHINE_MAX_RAM_BE=
LOW_4G,
-                                                   &error_abort);
+    uint64_t user_lowmem =3D object_property_get_uint(qdev_get_machine()=
,
+                                                    PC_MACHINE_MAX_RAM_B=
ELOW_4G,
+                                                    &error_abort);
=20
     /* Handle the machine opt max-ram-below-4g.  It is basically doing
      * min(xen limit, user limit).
--=20
2.13.0.91.g00982b8dd
