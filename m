Received: from eggs.gnu.org ([2001:4830:134:3::10]:49865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g0hhV-0003Me-81
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g0hhS-0003lR-0l
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:35:33 -0400
Received: from 10.mo1.mail-out.ovh.net ([178.32.96.102]:38915)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g0hhR-0003aU-JP
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:35:29 -0400
Received: from player759.ha.ovh.net (unknown [10.109.143.145])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id B6D8912D39C
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 08:35:20 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 14 Sep 2018 08:35:03 +0200
Message-Id: <20180914063506.20815-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] aspeed/i2c: fix receive done interrupt
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

The interrupt model of the Aspeed I2C controller does handle correctly
the RX_DONE bit. As indicated in the AST2500 datasheet, the RX_DONE
bit needs to be cleared to allow mode data to be received. This series
fixes the behavior and delays the data reception until the bit has
been cleared.

Revealed by :

  [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq event=
s
  https://lkml.org/lkml/2018/8/23/1366

which fixes irq handling in Linux at high bus frequencies.

Thanks,

C.

C=C3=A9dric Le Goater (1):
  aspeed/i2c: interrupts should be cleared by software only

Guenter Roeck (2):
  aspeed/i2c: Handle receive command in separate function
  aspeed/i2c: Fix receive done interrupt handling

 hw/i2c/aspeed_i2c.c | 68 +++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 21 deletions(-)

--=20
2.17.1
