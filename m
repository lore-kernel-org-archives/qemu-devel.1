Received: from eggs.gnu.org ([2001:4830:134:3::10]:41821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cuIcn-0002Zp-L2
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 08:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cuIci-0004DQ-Qp
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 08:59:25 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:41148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cuIci-00049X-Kg
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 08:59:20 -0400
Received: from player799.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 025B3E44E5
	for <qemu-devel@nongnu.org>; Sat,  1 Apr 2017 14:59:12 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  1 Apr 2017 14:57:53 +0200
Message-Id: <1491051477-10455-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] FTGMAC100 nic model for the Aspeed SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hi,

The Aspeed SoCs AST2400 and AST2500 have two FTGMAC100 ethernet
controllers. This serie proposes a model for this device and a way to
customize the bit definitions which are slightly different from the
Faraday definitions.

The last patch adds a fake NC-SI (Network Controller Sideband
Interface) backend to pretend a NIC is being managed. This is only
usable with the slirp stack.

The model has been tested on the 'palmetto' and the 'romulus' machine
using different implementations of the Linux driver and with U-Boot.
It has been stressed with iperf.

Thanks,

C.=20

C=C3=A9dric Le Goater (4):
  net: add FTGMAC100 support
  net/ftgmac100: add a 'aspeed' property
  aspeed: add a FTGMAC100 nic
  slirp: add a fake NC-SI backend

 default-configs/arm-softmmu.mak |   1 +
 hw/arm/aspeed_soc.c             |  21 +
 hw/net/Makefile.objs            |   1 +
 hw/net/ftgmac100.c              | 990 ++++++++++++++++++++++++++++++++++=
++++++
 include/hw/arm/aspeed_soc.h     |   2 +
 include/hw/net/ftgmac100.h      |  62 +++
 include/hw/net/mii.h            |   6 +
 include/net/eth.h               |   1 +
 slirp/Makefile.objs             |   2 +-
 slirp/ncsi-pkt.h                | 418 +++++++++++++++++
 slirp/ncsi.c                    |  78 ++++
 slirp/slirp.c                   |   4 +
 slirp/slirp.h                   |   3 +
 13 files changed, 1588 insertions(+), 1 deletion(-)
 create mode 100644 hw/net/ftgmac100.c
 create mode 100644 include/hw/net/ftgmac100.h
 create mode 100644 slirp/ncsi-pkt.h
 create mode 100644 slirp/ncsi.c

--=20
2.7.4
