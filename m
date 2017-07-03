Received: from eggs.gnu.org ([2001:4830:134:3::10]:49215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dS1Bx-0004cJ-5z
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dS1Bt-0001pG-U4
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:15:05 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon,  3 Jul 2017 15:14:53 +0200
Message-Id: <20170703131455.25424-1-lvivier@redhat.com>
Subject: [Qemu-devel] [RFC v3 0/2] target/ppc/cpu-models: set POWER9_v1.0 as
 POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Suraj Singh <sursingh@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>

This patch series allows to use "-cpu POWER9" with a POWER9
DD1 host and KVM HV. With TCG, "-cpu POWER9" selects
POWER9_v2.0 (POWER9 DD2).

v3:
  add the patch to move POWER9 DD1 workaround to
  the generic part (not only for "-cpu host").

v2:
  add POWER9_v2.0
  sent as RFC as "-cpu POWER9" breaks the kernel

Laurent Vivier (2):
  target/ppc/cpu-models: set POWER9_v1.0 as POWER9 DD1
  target/ppc: move POWER9 DD1 workaround to ppc_cpu_initfn

 hw/ppc/spapr_cpu_core.c     |  5 ++++-
 target/ppc/cpu-models.c     |  6 ++++--
 target/ppc/cpu-models.h     |  1 +
 target/ppc/kvm.c            | 11 -----------
 target/ppc/translate_init.c | 10 ++++++++++
 5 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.9.4
