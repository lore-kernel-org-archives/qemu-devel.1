Received: from eggs.gnu.org ([2001:4830:134:3::10]:53598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdHK9-0000Ip-3M
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdHK5-00089W-RU
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:09:49 -0500
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:49541)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cdHK5-00089B-Kw
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:09:45 -0500
Received: from player772.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 8810C48E90
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 15:09:43 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 13 Feb 2017 15:09:15 +0100
Message-Id: <1486994957-20400-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] ppc/xics: simplify ICS and ICP creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

This series moves the creation of the ICS and ICP objects from the
XICS object to the sPAPR machine. This simplifies the code
significantly and prepares ground for future changes on the XICS object.

The goal is to reduce XICS to a set of Interfaces of the machine
providing accessors to the ICS and ICPs objects.=20

Thanks,

C.

C=C3=A9dric Le Goater (2):
  ppc/xics: remove set_nr_irqs() handler from XICSStateClass
  ppc/xics: remove set_nr_servers() handler from XICSStateClass

 hw/intc/xics.c        | 78 ++++-----------------------------------------=
------
 hw/intc/xics_kvm.c    | 55 +-----------------------------------
 hw/intc/xics_spapr.c  | 60 ---------------------------------------
 hw/ppc/spapr.c        | 60 ++++++++++++++++++++++++++++++---------
 include/hw/ppc/xics.h |  2 --
 5 files changed, 53 insertions(+), 202 deletions(-)

--=20
2.7.4
