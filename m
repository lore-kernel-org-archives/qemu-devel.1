Received: from eggs.gnu.org ([2001:4830:134:3::10]:45957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvgpG-0002gU-NH
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvgpD-0001eX-Fp
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:38:50 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:50468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fvgpD-0001eC-9Q
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:38:47 -0400
Received: from player168.ha.ovh.net (unknown [10.109.146.5])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 05D6C1A3BA6
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 12:38:45 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 31 Aug 2018 12:38:09 +0200
Message-Id: <20180831103816.13479-3-clg@kaod.org>
In-Reply-To: <20180831103816.13479-1-clg@kaod.org>
References: <20180831103816.13479-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/11] hw/arm/aspeed: change the FMC flash
 model of the AST2500 evb
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

The AST2500 evb is shipped with a W25Q256 which has a non volatile bit
to make the chip operate in 4 Byte address mode at power up. This
should be an interesting feature to model as it will exercise a bit
more the SMC controllers and MMIO execution at boot time.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index bb9590f1aed1..f2d64e45511a 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -105,7 +105,7 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
     [AST2500_EVB]  =3D {
         .soc_name  =3D "ast2500-a1",
         .hw_strap1 =3D AST2500_EVB_HW_STRAP1,
-        .fmc_model =3D "n25q256a",
+        .fmc_model =3D "w25q256",
         .spi_model =3D "mx25l25635e",
         .num_cs    =3D 1,
         .i2c_init  =3D ast2500_evb_i2c_init,
--=20
2.17.1
