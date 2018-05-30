Received: from eggs.gnu.org ([2001:4830:134:3::10]:57140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuJt-0007AN-Pp
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuJq-000640-Lo
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:10:49 -0400
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:44667)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNuJq-000637-5A
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:10:46 -0400
Received: from player168.ha.ovh.net (unknown [10.109.120.88])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 017FCACADA
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 08:10:43 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 30 May 2018 08:10:32 +0200
Message-Id: <20180530061035.22592-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] slirp: NC-SI enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here is a couple of enhancements and fixes for the NC-SI backend used
on the Aspeed SoC when soldered on OpenPOWER boards.=20

Thanks,

C.

C=C3=A9dric Le Goater (3):
  slirp/ncsi: fix "Get Version ID" payload length
  slirp/ncsi: add a "Get Parameters" response
  slirp/ncsi: add checksum support

 slirp/ncsi.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)

--=20
2.13.6
