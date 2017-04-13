Received: from eggs.gnu.org ([2001:4830:134:3::10]:40737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cybGb-0001rt-Rs
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cybGX-0000nE-VN
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:42:17 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:43237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cybGX-0000mv-OV
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:42:13 -0400
Received: from player715.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 24A1631802
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 11:42:11 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 13 Apr 2017 11:41:49 +0200
Message-Id: <1492076514-28821-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/5] FTGMAC100 nic model for the Aspeed SoCs
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

The model has been tested on the 'palmetto', 'romulus' and
'ast2500-evb' machines using different implementations of the Linux
driver and with U-Boot.  It has been stressed with iperf.

Thanks,

C.=20

C=C3=A9dric Le Goater (5):
  hw/net: add MII definitions
  net: add FTGMAC100 support
  net/ftgmac100: add a 'aspeed' property
  aspeed: add a FTGMAC100 nic
  slirp: add a fake NC-SI backend

 default-configs/arm-softmmu.mak |    1 +
 hw/arm/aspeed_soc.c             |   21 +
 hw/net/Makefile.objs            |    1 +
 hw/net/ftgmac100.c              | 1016 +++++++++++++++++++++++++++++++++=
++++++
 include/hw/arm/aspeed_soc.h     |    2 +
 include/hw/net/ftgmac100.h      |   64 +++
 include/hw/net/mii.h            |   71 ++-
 include/net/eth.h               |    1 +
 slirp/Makefile.objs             |    2 +-
 slirp/ncsi-pkt.h                |  418 ++++++++++++++++
 slirp/ncsi.c                    |   78 +++
 slirp/slirp.c                   |    4 +
 slirp/slirp.h                   |    3 +
 13 files changed, 1663 insertions(+), 19 deletions(-)
 create mode 100644 hw/net/ftgmac100.c
 create mode 100644 include/hw/net/ftgmac100.h
 create mode 100644 slirp/ncsi-pkt.h
 create mode 100644 slirp/ncsi.c

--=20
2.7.4
