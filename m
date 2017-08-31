Received: from eggs.gnu.org ([2001:4830:134:3::10]:42102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnMq5-0003Db-W6
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnMq5-0006kp-4z
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:36:46 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 31 Aug 2017 12:34:32 +0200
Message-Id: <20170831103432.6007-30-marcandre.lureau@redhat.com>
In-Reply-To: <20170831103432.6007-1-marcandre.lureau@redhat.com>
References: <20170831103432.6007-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/29] eepro100: replace g_malloc()+memcpy()
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
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Jason Wang <jasowang@redhat.com>

I found these pattern via grepping the source tree. I don't have a
coccinelle script for it!

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 hw/net/eepro100.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 5a4774aab4..a7b9f77519 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -1904,8 +1904,7 @@ static void e100_nic_realize(PCIDevice *pci_dev, Er=
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
2.14.1.146.gd35faa819
