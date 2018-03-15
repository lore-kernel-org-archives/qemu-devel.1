Received: from eggs.gnu.org ([2001:4830:134:3::10]:50064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ewT1Q-0002xM-EK
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ewT1M-0001rJ-Bb
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:34:20 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:33318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ewT1M-0001q5-6U
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:34:16 -0400
Received: from player734.ha.ovh.net (unknown [10.109.122.111])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id A5F1D121DC3
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 14:34:14 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 15 Mar 2018 13:33:58 +0000
Message-Id: <20180315133402.13470-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/4] target/ppc: add hash MMU support for
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

Changes since v2:

 - extended PPCVirtualHypervisor interface to export the external HPT
 - added an assert on MMU model in ppc_store_ptcr()
 - reworked ppc_hash64_hpt_reg() to cover only powernv machines. pseries
   machines being handled with cpu->vhyp at the ppc_hash64_hpt_base()
   level.
 - reworked ppc64_v3_radix() to distinguish pseries machine from
   powernv machines


Changes since v1:

 - introduced ppc64_v3_get_patbe0()
 - renamed ppc64_radix() in ppc64_v3_radix()
 - renamed partition table definitions to match ISA
 - moved definitions under mmu-book3s-v3.h
=20
C=C3=A9dric Le Goater (4):
  target/ppc: export external HPT via virtual hypervisor
  target/ppc: add basic support for PTCR on POWER9
  target/ppc: add hash MMU support on POWER9 for PowerNV only
  target/ppc: generalize check on radix when in HV mode

 hw/ppc/spapr.c              |  8 +++++++
 hw/ppc/spapr_hcall.c        |  5 +++--
 target/ppc/cpu.h            |  3 +++
 target/ppc/helper.h         |  1 +
 target/ppc/misc_helper.c    | 12 +++++++++++
 target/ppc/mmu-book3s-v3.c  | 23 ++++++++++++++++++--
 target/ppc/mmu-book3s-v3.h  | 15 ++++++++++++-
 target/ppc/mmu-hash64.c     | 52 +++++++++++++++++++++++++++++++++++++--=
------
 target/ppc/mmu-hash64.h     | 39 ++++++++++++++++++++++++++++++++--
 target/ppc/mmu_helper.c     | 33 ++++++++++++++++++++++++++--
 target/ppc/translate.c      |  3 +++
 target/ppc/translate_init.c | 18 ++++++++++++++++
 12 files changed, 194 insertions(+), 18 deletions(-)

--=20
2.13.6
