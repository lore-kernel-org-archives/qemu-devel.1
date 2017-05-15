Received: from eggs.gnu.org ([2001:4830:134:3::10]:55249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dA8uv-0007xd-2r
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dA8uq-0001AG-4d
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:37 -0400
Received: from 1.mo4.mail-out.ovh.net ([178.33.248.196]:55538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dA8up-00019I-Uk
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:51:32 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 1468263A76
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 07:51:22 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 15 May 2017 07:51:10 +0200
Message-Id: <1494827476-1487-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/6] aspeed: I2C controller fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

The new Linux driver for the Aspeed I2C controller revealed some
serious limitations in the QEMU model. This series fixes these issues
and also adds a couple of well-know I2C devices to the Aspeed
machines.

The QEMU model now supports the recent Linux driver and the older one.

Thanks,

C.

C=C3=A9dric Le Goater (6):
  aspeed/i2c: improve command handling
  aspeed/i2c: handle LAST command under the RX command
  aspeed/i2c: introduce a state machine
  aspeed: add some I2C devices to the Aspeed machines
  hw/misc: add a TMP42{1,2,3} device model
  aspeed: add a temp sensor device on I2C bus 3

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/aspeed.c                 |  36 ++++
 hw/i2c/aspeed_i2c.c             |  65 ++++++-
 hw/misc/Makefile.objs           |   1 +
 hw/misc/tmp421.c                | 401 ++++++++++++++++++++++++++++++++++=
++++++
 5 files changed, 494 insertions(+), 10 deletions(-)
 create mode 100644 hw/misc/tmp421.c

--=20
2.7.4
