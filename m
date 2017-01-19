Received: from eggs.gnu.org ([2001:4830:134:3::10]:56473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cUJSO-0000P8-UI
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 15:37:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cUJSK-0000BO-29
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 15:37:17 -0500
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:59328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cUJSJ-0000Ar-Ry
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 15:37:11 -0500
Received: from player732.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 82F5B156CB
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 21:37:10 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Jan 2017 21:36:58 +0100
Message-Id: <1484858218-28693-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] aspeed/smc: remove unused routine
 aspeed_smc_is_usermode()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ssi/aspeed_smc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index a0a816407fc1..ae1ad2dba6ff 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -406,11 +406,6 @@ static inline int aspeed_smc_flash_mode(const Aspeed=
SMCFlash *fl)
     return s->regs[s->r_ctrl0 + fl->id] & CTRL_CMD_MODE_MASK;
 }
=20
-static inline bool aspeed_smc_is_usermode(const AspeedSMCFlash *fl)
-{
-    return aspeed_smc_flash_mode(fl) =3D=3D CTRL_USERMODE;
-}
-
 static inline bool aspeed_smc_is_writable(const AspeedSMCFlash *fl)
 {
     const AspeedSMCState *s =3D fl->controller;
--=20
2.7.4
