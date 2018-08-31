Received: from eggs.gnu.org ([2001:4830:134:3::10]:46143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvgpo-00038I-Vf
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvgpf-00023v-Gu
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:39:21 -0400
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:37485)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fvgpc-00020a-Gw
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:39:12 -0400
Received: from player168.ha.ovh.net (unknown [10.109.146.137])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id C73CE268C2
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 12:39:10 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 31 Aug 2018 12:38:12 +0200
Message-Id: <20180831103816.13479-6-clg@kaod.org>
In-Reply-To: <20180831103816.13479-1-clg@kaod.org>
References: <20180831103816.13479-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/11] aspeed/smc: fix some alignment issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ssi/aspeed_smc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index b29bfd3124a9..1270842dcf0c 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -388,8 +388,8 @@ static uint64_t aspeed_smc_flash_default_read(void *o=
paque, hwaddr addr,
 static void aspeed_smc_flash_default_write(void *opaque, hwaddr addr,
                                            uint64_t data, unsigned size)
 {
-   qemu_log_mask(LOG_GUEST_ERROR, "%s: To 0x%" HWADDR_PRIx " of size %u:=
 0x%"
-                 PRIx64 "\n", __func__, addr, size, data);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: To 0x%" HWADDR_PRIx " of size %u=
: 0x%"
+                  PRIx64 "\n", __func__, addr, size, data);
 }
=20
 static const MemoryRegionOps aspeed_smc_flash_default_ops =3D {
@@ -529,7 +529,7 @@ static void aspeed_smc_flash_setup(AspeedSMCFlash *fl=
, uint32_t addr)
      */
     if (aspeed_smc_flash_mode(fl) =3D=3D CTRL_FREADMODE) {
         for (i =3D 0; i < aspeed_smc_flash_dummies(fl); i++) {
-                ssi_transfer(fl->controller->spi, 0xFF);
+            ssi_transfer(fl->controller->spi, 0xFF);
         }
     }
 }
@@ -567,7 +567,7 @@ static uint64_t aspeed_smc_flash_read(void *opaque, h=
waddr addr, unsigned size)
 }
=20
 static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t d=
ata,
-                           unsigned size)
+                                   unsigned size)
 {
     AspeedSMCFlash *fl =3D opaque;
     AspeedSMCState *s =3D fl->controller;
--=20
2.17.1
