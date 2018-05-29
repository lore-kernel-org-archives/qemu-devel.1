Received: from eggs.gnu.org ([2001:4830:134:3::10]:36498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNY7x-0001Ia-Of
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNY7u-0001Rz-L6
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:29:01 -0400
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:35499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNY7u-0001L7-FB
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:28:58 -0400
Received: from player718.ha.ovh.net (unknown [10.109.120.89])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 72C4E17A2A6
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 08:28:47 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 29 May 2018 08:28:32 +0200
Message-Id: <20180529062838.20556-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/6] ftgmac100 and NC-SI enhancements for the
 Aspeed SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here is a couple of enhancements and fixes for the ftgmac100 NIC used
on the Aspeed SoC. It includes VLAN and multicast support.

Following is an assorted set of changes for the NC-SI backend also
used on the Aspeed SoC when soldered on OpenPOWER boards. These fix a
few problems found when running OpenBMC on aspeed QEMU machines.

Thanks,

C=C3=A9dric.

C=C3=A9dric Le Goater (6):
  ftgmac100: compute maximum frame size depending on the protocol
  ftgmac100: add IEEE 802.1Q VLAN support
  net/ftgmac100: fix multicast hash routine
  slirp/ncsi: fix "Get Version ID" payload length
  slirp/ncsi: add a "Get Parameter" response
  slirp/ncsi: add checksum support

 include/hw/net/ftgmac100.h |  7 +++++-
 hw/net/ftgmac100.c         | 59 +++++++++++++++++++++++++++++++++++-----=
------
 slirp/ncsi.c               | 54 +++++++++++++++++++++++++++++++++++++---=
--
 3 files changed, 99 insertions(+), 21 deletions(-)

--=20
2.13.6
