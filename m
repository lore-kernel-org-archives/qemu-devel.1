Received: from eggs.gnu.org ([209.51.188.92]:48103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEUdP-0007PP-P4
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEUdO-0007wN-R8
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:00:35 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:41846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEUdO-0007qj-HQ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:00:34 -0400
Received: from player779.ha.ovh.net (unknown [10.109.160.39])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 804725A086
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 10:00:31 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 11 Apr 2019 09:59:58 +0200
Message-Id: <20190411080004.8690-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/6] ppc: misc fixes for Radix and Hash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hi,

Here is a series of patches from Ben providing MMU fixes for sPAPR and
PowerNV. They seem of interest and deserve a closer look by people
with good knowledge of the PPC MMU.

Thanks,

C.

Benjamin Herrenschmidt (6):
  target/ppc: Don't check UPRT in radix mode when in HV real mode
  ppc/spapr: Use proper HPTE accessors for H_READ
  ppc/hash64: Rework R and C bit updates
  ppc/hash32: Rework R and C bit updates
  memory_ldst: Add atomic ops for PTE updates
  ppc: Fix radix RC updates

 include/exec/memory_ldst.inc.h |  6 +++
 include/hw/ppc/spapr.h         |  2 +
 target/ppc/cpu.h               |  5 +-
 target/ppc/mmu-hash64.h        |  2 -
 hw/ppc/spapr.c                 | 41 ++++++++++++++--
 hw/ppc/spapr_hcall.c           | 24 +++++-----
 memory_ldst.inc.c              | 80 +++++++++++++++++++++++++++++++
 target/ppc/mmu-hash32.c        | 45 ++++++++++++------
 target/ppc/mmu-hash64.c        | 76 ++++++++++++++++++------------
 target/ppc/mmu-radix64.c       | 86 ++++++++++++++++++++++++++++------
 10 files changed, 288 insertions(+), 79 deletions(-)

--=20
2.20.1
