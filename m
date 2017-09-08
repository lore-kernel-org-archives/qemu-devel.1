Received: from eggs.gnu.org ([2001:4830:134:3::10]:54533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dqKMO-0004CA-5x
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dqKMI-0001IT-IT
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:34:20 -0400
Received: from 7.mo4.mail-out.ovh.net ([178.33.253.54]:35395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dqKMI-0001HU-CP
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:34:14 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id B280095724
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 16:34:12 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri,  8 Sep 2017 16:33:41 +0200
Message-Id: <20170908143344.12960-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] spapr: XIVE and CAS fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here are a couple of fixes, one for the XIVE exploitation mode option
bit which is clearly specified now and for one for the CAS generated
resets.

Last is a proposal to handle the rebuild of the device tree using a
reset when the XIVE exploitation mode is negotiated with CAS.=20

The full tree is here:

  https://github.com/legoater/qemu/commits/xive

XIVE support for Linux is now merged in 4.14.

Thanks,

C.

C=C3=A9dric Le Goater (3):
  ppc/xive: fix OV5_XIVE_EXPLOIT bits
  spapr: fix CAS-generated reset
  spapr: generate a CAS reset for XIVE exploitation mode

 hw/ppc/spapr.c              |  8 ++++++--
 hw/ppc/spapr_hcall.c        | 13 +++++++++++++
 include/hw/ppc/spapr_ovec.h |  3 ++-
 3 files changed, 21 insertions(+), 3 deletions(-)

--=20
2.13.5
