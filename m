Received: from eggs.gnu.org ([2001:4830:134:3::10]:56672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ebLsw-000261-Us
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 02:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ebLss-0007gC-32
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 02:42:18 -0500
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:60723)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ebLsr-0007fc-SN
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 02:42:13 -0500
Received: from player168.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id DB3B3916C4
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 08:42:11 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 16 Jan 2018 08:41:54 +0100
Message-Id: <20180116074157.16886-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] target/ppc: add support for hypervisor
 doorbells
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hi,

The hypervisor doorbells are used by skiboot and Linux on POWER9
processors to wake up secondaries. This adds processor control support
to the Book3S architecture.

The full tree can be found here :

  https://github.com/legoater/qemu powernv-2.12

Thanks,

C.

C=C3=A9dric Le Goater (3):
  target/ppc: fix doorbell and hypervisor doorbell definitions
  target/ppc: msgsnd and msgclr instructions need hypervisor privilege
  target/ppc: add support for hypervisor doorbells on book3s CPUs

 target/ppc/cpu.h            | 16 ++++++++++------
 target/ppc/excp_helper.c    | 39 ++++++++++++++++++++++++++++++++-------
 target/ppc/helper.h         |  2 +-
 target/ppc/translate.c      | 17 ++++++++++++++---
 target/ppc/translate_init.c |  2 +-
 5 files changed, 58 insertions(+), 18 deletions(-)

--=20
2.13.6
