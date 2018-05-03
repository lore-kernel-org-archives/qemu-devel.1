Received: from eggs.gnu.org ([2001:4830:134:3::10]:40954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7cr-00074p-Qm
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE7cn-0002NO-4n
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:21:57 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  3 May 2018 16:21:37 +1000
Message-Id: <20180503062145.17899-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/8] spapr: Cleanups to startup and LPCR
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, clg@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

This is an assortment of patches cleaning up how we handle startup /
entry of CPUs for the pseries machine type.  In particular it makes a
number of cleanups to the way we manage the LPCR register.

I've posted versions of most of these patches before, however there
have been enough reworks and re-organizations that the series as a
whole isn't really a new version of an existing one.

David Gibson (8):
  target/ppc: Add ppc_store_lpcr() helper
  spapr: Clean up rtas_start_cpu() & rtas_stop_self()
  spapr: Remove unhelpful helpers from rtas_start_cpu()
  spapr: Make a helper to set up cpu entry point state
  spapr: Clean up LPCR updates from hypercalls
  target/ppc: Delay initialization of LPCR_UPRT for secondary cpus
  spapr: Move PAPR mode cpu setup fully to spapr code
  spapr: Clean up handling of LPCR power-saving exit bits

 hw/ppc/spapr.c                  |   4 +-
 hw/ppc/spapr_cpu_core.c         |  47 +++++++++++---
 hw/ppc/spapr_hcall.c            |  50 ++++++---------
 hw/ppc/spapr_rtas.c             | 108 ++++++++++++++++----------------
 include/hw/ppc/spapr_cpu_core.h |   3 +
 target/ppc/cpu.h                |   2 +-
 target/ppc/kvm.c                |   4 ++
 target/ppc/mmu-hash64.c         |  15 +++--
 target/ppc/mmu-hash64.h         |   3 +-
 target/ppc/translate_init.c     |  62 +-----------------
 10 files changed, 134 insertions(+), 164 deletions(-)

--=20
2.17.0
