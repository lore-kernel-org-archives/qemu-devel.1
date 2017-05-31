Received: from eggs.gnu.org ([2001:4830:134:3::10]:53360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4CI-0007IQ-1U
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG4CC-0005Al-3Z
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:02:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG4CB-0005AN-VS
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB7B681138
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 14:01:54 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:58 +0400
Message-Id: <20170531135709.345-35-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 34/45] pc: use get_uint() for "hpet-intcap"
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

TYPE_HPET's property HPET_INTCAP is defined with DEFINE_PROP_UINT32().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c31115a8f0..e970d0c4e2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1560,7 +1560,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq=
 *gsi,
              * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23=
,
              * IRQ8 and IRQ2.
              */
-            uint8_t compat =3D object_property_get_int(OBJECT(hpet),
+            uint8_t compat =3D object_property_get_uint(OBJECT(hpet),
                     HPET_INTCAP, NULL);
             if (!compat) {
                 qdev_prop_set_uint32(hpet, HPET_INTCAP, hpet_irqs);
--=20
2.13.0.91.g00982b8dd
