Received: from eggs.gnu.org ([2001:4830:134:3::10]:33150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIdyd-0007kL-Lw
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIdya-0007bT-H6
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:38:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIdya-0007bI-BW
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:38:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CCBE7E9C9
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 16:38:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 20:36:05 +0400
Message-Id: <20170607163635.17635-14-marcandre.lureau@redhat.com>
In-Reply-To: <20170607163635.17635-1-marcandre.lureau@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 13/43] q35: fix get_mmcfg_size to use uint64
 visitor
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

e->size is hwaddr, i.e. uint64_t. We silently truncate.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hw/pci-host/q35.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index cd5c49616e..e8a04d31d1 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -129,9 +129,8 @@ static void q35_host_get_mmcfg_size(Object *obj, Visi=
tor *v, const char *name,
                                     void *opaque, Error **errp)
 {
     PCIExpressHost *e =3D PCIE_HOST_BRIDGE(obj);
-    uint32_t value =3D e->size;
=20
-    visit_type_uint32(v, name, &value, errp);
+    visit_type_uint64(v, name, &e->size, errp);
 }
=20
 static Property mch_props[] =3D {
--=20
2.13.0.91.g00982b8dd
