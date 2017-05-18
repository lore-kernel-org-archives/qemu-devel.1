Received: from eggs.gnu.org ([2001:4830:134:3::10]:44078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dBGVA-0003PP-FE
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dBGV9-00026t-D2
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:09:40 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 18 May 2017 10:09:28 +0200
Message-Id: <1495094971-177754-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] numa: code consolidation and test fixup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

git repo for testing:
   https://github.com/imammedo/qemu.git cphp_numa_cfg_follow_up_v3_cleanups_v1

CC: qemu-arm@nongnu.org
CC: qemu-ppc@nongnu.org
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Andrew Jones <drjones@redhat.com>

Igor Mammedov (3):
  numa: consolidate cpu_preplug fixups/checks for pc/arm/spapr
  numa: move default mapping init to machine
  numa: silence incomplete mapping warning under qtest

 include/sysemu/numa.h |  1 +
 hw/arm/virt.c         | 16 ++--------------
 hw/core/machine.c     | 35 +++++++++++++++++++++++------------
 hw/i386/pc.c          | 17 +----------------
 hw/ppc/spapr.c        | 17 +----------------
 numa.c                | 48 ++++++++++++++++++++++--------------------------
 6 files changed, 50 insertions(+), 84 deletions(-)

-- 
2.7.4
