Received: from eggs.gnu.org ([2001:4830:134:3::10]:33960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIAFb-00058o-SS
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIAFY-0004dj-Oo
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:54:07 -0400
Received: from 4.mo7.mail-out.ovh.net ([178.32.122.254]:38759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dIAFY-0004cq-I1
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:54:04 -0400
Received: from player762.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 08E685928A
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 10:54:02 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue,  6 Jun 2017 10:53:48 +0200
Message-Id: <1496739230-32109-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] aspeed: add a TMP421 device to the
 palmetto machine
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

This series fixes issues in the TMP421 model previously sent and adds
such a device to the palmetto machine.

Thanks,

C.

C=C3=A9dric Le Goater (2):
  hw/misc: add a TMP42{1,2,3} device model
  aspeed: add a temp sensor device on I2C bus 3

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/aspeed.c                 |   9 +
 hw/misc/Makefile.objs           |   1 +
 hw/misc/tmp421.c                | 402 ++++++++++++++++++++++++++++++++++=
++++++
 4 files changed, 413 insertions(+)
 create mode 100644 hw/misc/tmp421.c

--=20
2.7.4
