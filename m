Received: from eggs.gnu.org ([2001:4830:134:3::10]:46057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1Tc-00088x-JV
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1TY-00071L-LC
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1TY-000719-FQ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D60E7F410
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 12:44:43 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:42:04 +0200
Message-Id: <20170622124204.19407-32-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 31/31] eepro100: replace g_malloc()+memcpy()
 with g_memdup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Jason Wang <jasowang@redhat.com>

I found these pattern via grepping the source tree. I don't have a
coccinelle script for it!

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/net/eepro100.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 4bf71f2d85..7d3b2e52c7 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -1894,8 +1894,7 @@ static void e100_nic_realize(PCIDevice *pci_dev, Er=
ror **errp)
=20
     qemu_register_reset(nic_reset, s);
=20
-    s->vmstate =3D g_malloc(sizeof(vmstate_eepro100));
-    memcpy(s->vmstate, &vmstate_eepro100, sizeof(vmstate_eepro100));
+    s->vmstate =3D g_memdup(&vmstate_eepro100, sizeof(vmstate_eepro100))=
;
     s->vmstate->name =3D qemu_get_queue(s->nic)->model;
     vmstate_register(&pci_dev->qdev, -1, s->vmstate, s);
 }
--=20
2.13.1.395.gf7b71de06
