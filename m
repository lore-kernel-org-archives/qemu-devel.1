Received: from eggs.gnu.org ([2001:4830:134:3::10]:44120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1embet-0003jy-9F
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 03:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1embeq-0000lY-4M
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 03:46:19 -0500
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:57048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1embep-0000gh-TJ
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 03:46:16 -0500
Received: from player778.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 3F3C7AFF57
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 09:46:06 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 16 Feb 2018 09:45:01 +0100
Message-Id: <20180216084504.24958-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] target/ppc: add hash MMU support for
 the POWER9 PowerNV machine
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

Thanks,

C.=20

Changes since v1:

 - introduced ppc64_v3_get_patbe0()
 - renamed ppc64_radix() in ppc64_v3_radix()
 - renamed partition table definitions to match ISA
 - moved definitions under mmu-book3s-v3.h
=20
C=C3=A9dric Le Goater (3):
  target/ppc: add basic support for PTCR on POWER9
  target/ppc: add hash MMU support on POWER9 for PowerNV only
  target/ppc: generalize check on radix when in HV mode

 hw/ppc/spapr_hcall.c        |  5 +++--
 target/ppc/cpu.h            |  2 ++
 target/ppc/helper.h         |  1 +
 target/ppc/misc_helper.c    | 12 ++++++++++++
 target/ppc/mmu-book3s-v3.c  | 16 ++++++++++++++-
 target/ppc/mmu-book3s-v3.h  | 22 +++++++++++++--------
 target/ppc/mmu-hash64.c     | 48 ++++++++++++++++++++++++++++++++++++---=
------
 target/ppc/mmu-hash64.h     | 34 ++++++++++++++++++++++++++++++--
 target/ppc/mmu_helper.c     | 32 ++++++++++++++++++++++++++++--
 target/ppc/translate.c      |  3 +++
 target/ppc/translate_init.c | 20 ++++++++++++++++++-
 11 files changed, 170 insertions(+), 25 deletions(-)

--=20
2.13.6
