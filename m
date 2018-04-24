Received: from eggs.gnu.org ([2001:4830:134:3::10]:34893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAwA1-0003bW-UN
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAw9w-0003Xq-Tf
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:31:01 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:50896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fAw9w-0003V7-NK
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 07:30:56 -0400
Received: from player774.ha.ovh.net (unknown [10.109.108.24])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id B38DF132B9
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 13:30:54 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 24 Apr 2018 13:30:40 +0200
Message-Id: <20180424113045.25687-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/5] target/ppc: add hash MMU support for
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

Changes since v3:

 - removed spapr_hpt_base() ops
 - split hash MMU definitions patch

C=C3=A9dric Le Goater (5):
  target/ppc: return a nil HPT base address on sPAPR machines
  target/ppc: add basic support for PTCR on POWER9
  target/ppc: add hash MMU definitions for ISA v3.0
  target/ppc: add hash MMU support for PowerNV POWER9 machines
  target/ppc: generalize check on radix when in HV mode

 hw/ppc/spapr_hcall.c        |  5 +++--
 target/ppc/cpu.h            |  2 ++
 target/ppc/helper.h         |  1 +
 target/ppc/misc_helper.c    | 12 +++++++++++
 target/ppc/mmu-book3s-v3.c  | 23 +++++++++++++++++++--
 target/ppc/mmu-book3s-v3.h  | 15 +++++++++++++-
 target/ppc/mmu-hash64.c     | 50 +++++++++++++++++++++++++++++++++++++--=
------
 target/ppc/mmu-hash64.h     | 39 +++++++++++++++++++++++++++++++++--
 target/ppc/mmu_helper.c     | 33 ++++++++++++++++++++++++++++--
 target/ppc/translate.c      |  3 +++
 target/ppc/translate_init.c | 18 ++++++++++++++++
 11 files changed, 184 insertions(+), 17 deletions(-)

--=20
2.13.6
