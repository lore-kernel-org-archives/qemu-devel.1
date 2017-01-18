Received: from eggs.gnu.org ([2001:4830:134:3::10]:51617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTtWj-0003a3-Un
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTtWg-00080i-2J
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:56:02 -0500
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:43695)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cTtWf-0007zY-Re
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:55:57 -0500
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 352043CB7E
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 17:55:56 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 18 Jan 2017 17:55:29 +0100
Message-Id: <1484758531-15093-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] Aspeed watchdog controller model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

The Aspeed SoC includes a set of watchdog timers using 32-bit
decrement counters. This patchset provides a model for this controller
and adds the first watchdog to the Aspeed SoC model. A second watchdog
exists and is used on real HW to boot from a second flash module
containing a golden image of the firmware. This is not supported yet
in qemu.

The main benefit today of this model is to enables reboot/reset of a
guest from U-Boot and Linux.

Thanks,

C.

C=C3=A9dric Le Goater (1):
  aspeed: add a watchdog controller

Joel Stanley (1):
  wdt: Add Aspeed watchdog device model

 hw/arm/aspeed_soc.c              |  13 +++
 hw/watchdog/Makefile.objs        |   1 +
 hw/watchdog/wdt_aspeed.c         | 214 +++++++++++++++++++++++++++++++++=
++++++
 include/hw/arm/aspeed_soc.h      |   2 +
 include/hw/watchdog/wdt_aspeed.h |  37 +++++++
 5 files changed, 267 insertions(+)
 create mode 100644 hw/watchdog/wdt_aspeed.c
 create mode 100644 include/hw/watchdog/wdt_aspeed.h

--=20
2.7.4
