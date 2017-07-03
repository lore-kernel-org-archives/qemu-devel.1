Received: from eggs.gnu.org ([2001:4830:134:3::10]:50165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dRw4J-0004pk-Br
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dRw4D-0003v4-Vr
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:46:50 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon,  3 Jul 2017 09:45:47 +0200
Message-Id: <20170703074548.5780-1-lvivier@redhat.com>
Subject: [Qemu-devel] [RFC v2 0/1] target/ppc/cpu-models: set POWER9_v1.0 as
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
Cc: Thomas Huth <thuth@redhat.com>, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Singh <sursingh@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>

This patch allows to use "-cpu POWER9" with a POWER9
DD1 host and KVM HV. With TCG, "-cpu POWER9" selects
POWER9_v2.0 (POWER9 DD2).

I post this patch as a RFC because kernel boots
well with "-cpu host", but hangs with "-cpu POWER9"
whereas I can see it selects correctly the POWER9_v1.0
CPU in both cases.

Laurent Vivier (1):
  target/ppc/cpu-models: set POWER9_v1.0 as POWER9 DD1

 hw/ppc/spapr_cpu_core.c | 5 ++++-
 target/ppc/cpu-models.c | 6 ++++--
 target/ppc/cpu-models.h | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.9.4
