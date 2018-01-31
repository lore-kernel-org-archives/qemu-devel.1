Received: from eggs.gnu.org ([2001:4830:134:3::10]:38375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1egnkX-0004i7-5q
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1egnkV-0001G6-ML
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:28:09 -0500
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:34472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1egnkV-0001Ev-Gn
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:28:07 -0500
Received: from player699.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 4E02B49182
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 09:28:02 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 31 Jan 2018 09:27:46 +0100
Message-Id: <20180131082749.1803-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] target/ppc: add hash MMU support for the
 POWER9 PowerNV machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

This adds support for the Hash Page Table MMU mode on POWER9 PowerNV
machines. The Radix Tree mode support for the host is still to be done
but we are getting close.=20

The full tree can be found here :

  https://github.com/legoater/qemu powernv-2.12

Thanks,

C.=20

C=C3=A9dric Le Goater (3):
  target/ppc: add basic support for PTCR on POWER9
  target/ppc: add hash MMU support on POWER9 for PowerNV only
  target/ppc: generalize check on radix when in HV mode

 hw/ppc/spapr_hcall.c        |  5 +++--
 target/ppc/cpu.h            |  2 ++
 target/ppc/helper.h         |  1 +
 target/ppc/misc_helper.c    | 12 ++++++++++++
 target/ppc/mmu-book3s-v3.c  | 17 +++++++++++++++-
 target/ppc/mmu-book3s-v3.h  |  8 +-------
 target/ppc/mmu-hash64.c     | 48 ++++++++++++++++++++++++++++++++++++---=
------
 target/ppc/mmu-hash64.h     | 41 ++++++++++++++++++++++++++++++++++++--
 target/ppc/mmu_helper.c     | 32 ++++++++++++++++++++++++++++--
 target/ppc/translate.c      |  3 +++
 target/ppc/translate_init.c | 20 ++++++++++++++++++-
 11 files changed, 165 insertions(+), 24 deletions(-)

--=20
2.13.6
