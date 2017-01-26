Received: from eggs.gnu.org ([2001:4830:134:3::10]:45638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cWnzn-0005n9-An
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cWnzi-0003kP-Qe
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:38:03 -0500
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:50750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cWnzi-0003du-KE
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:37:58 -0500
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id B7EAD95293
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 18:37:48 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 26 Jan 2017 18:37:29 +0100
Message-Id: <1485452251-1593-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] Aspeed watchdog controller model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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

C=C3=A9dric Le Goater (2):
  wdt: Add Aspeed watchdog device model
  aspeed: add a watchdog controller

 hw/arm/aspeed_soc.c              |  13 +++
 hw/watchdog/Makefile.objs        |   1 +
 hw/watchdog/wdt_aspeed.c         | 225 +++++++++++++++++++++++++++++++++=
++++++
 include/hw/arm/aspeed_soc.h      |   2 +
 include/hw/watchdog/wdt_aspeed.h |  32 ++++++
 5 files changed, 273 insertions(+)
 create mode 100644 hw/watchdog/wdt_aspeed.c
 create mode 100644 include/hw/watchdog/wdt_aspeed.h

--=20
2.7.4
