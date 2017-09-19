Received: from eggs.gnu.org ([2001:4830:134:3::10]:44375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duGXH-0006xh-Sc
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duGXD-0007mE-TP
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:17:51 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:52705)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duGXD-0007lh-N8
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:17:47 -0400
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 8A44263A60
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 13:17:45 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 19 Sep 2017 13:17:21 +0200
Message-Id: <20170919111721.7931-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] watchdog/aspeed: fix variable type to store
 reload value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, "Anton D . Kachalov" <mouse@yandex-team.ru>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Initially from Anton D. Kachalov" <mouse@yandex-team.ru> but the SoB was
missing.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
[clg: change commit log and subject]
---
 hw/watchdog/wdt_aspeed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 22bce364d7b5..b8e0e9a75999 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -100,13 +100,13 @@ static uint64_t aspeed_wdt_read(void *opaque, hwadd=
r offset, unsigned size)
=20
 static void aspeed_wdt_reload(AspeedWDTState *s, bool pclk)
 {
-    uint32_t reload;
+    uint64_t reload;
=20
     if (pclk) {
         reload =3D muldiv64(s->regs[WDT_RELOAD_VALUE], NANOSECONDS_PER_S=
ECOND,
                           s->pclk_freq);
     } else {
-        reload =3D s->regs[WDT_RELOAD_VALUE] * 1000;
+        reload =3D s->regs[WDT_RELOAD_VALUE] * 1000UL;
     }
=20
     if (aspeed_wdt_is_enabled(s)) {
--=20
2.13.5
