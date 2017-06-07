Received: from eggs.gnu.org ([2001:4830:134:3::10]:34352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIe1Z-0002MT-0o
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIe1V-00011b-Sr
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIe1V-00011J-NR
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:41:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD26761982
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 16:41:32 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 20:36:29 +0400
Message-Id: <20170607163635.17635-38-marcandre.lureau@redhat.com>
In-Reply-To: <20170607163635.17635-1-marcandre.lureau@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 37/43] pnv-core: use get_uint() for
 "core-pir" property
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

This is an alias of TYPE_PNV_CORE's property "pir", which is defined
with DEFINE_PROP_UINT32()

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/ppc/pnv_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 1b7ec70f03..142bad1e57 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -51,7 +51,7 @@ static void powernv_cpu_init(PowerPCCPU *cpu, Error **e=
rrp)
     int thread_index =3D 0; /* TODO: TCG supports only one thread */
     ppc_spr_t *pir =3D &env->spr_cb[SPR_PIR];
=20
-    core_pir =3D object_property_get_int(OBJECT(cpu), "core-pir", &error=
_abort);
+    core_pir =3D object_property_get_uint(OBJECT(cpu), "core-pir", &erro=
r_abort);
=20
     /*
      * The PIR of a thread is the core PIR + the thread index. We will
--=20
2.13.0.91.g00982b8dd
