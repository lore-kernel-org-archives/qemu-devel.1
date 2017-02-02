Received: from eggs.gnu.org ([2001:4830:134:3::10]:42314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cZIuL-0006Oc-0m
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cZIuH-0001TQ-4t
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:02:45 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  2 Feb 2017 16:02:32 +0100
Message-Id: <1486047755-93584-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] spapr: fix cpu core hotunplug call flow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

Make cpu core hotunplug use the same (expected)
unplug_request/unplug call flow like spapr memory unplug
and mem/cpu unplug on x86.

While doing it separate internal cpu core handling and
machine wiring code and move machine related callbacks
close to related machine code in spapr.c.

Series applies on top of tags/ppc-for-2.9-20170202 pull req.

repo for testing:
  git@github.com:imammedo/qemu.git spapr_cpu_unplug_cleanup

CC: David Gibson <david@gibson.dropbear.id.au> (supporter:sPAPR)
CC: Alexander Graf <agraf@suse.de> (supporter:sPAPR)
CC: qemu-ppc@nongnu.org 
CC: Bharata B Rao <bharata@linux.vnet.ibm.com>

Igor Mammedov (3):
  spapr: cpu core: separate child threads destruction from machine state
    operations
  spapr: move spapr_core_[foo]plug() callbacks close to machine code in
    spapr.c
  spapr: make cpu core unplug follow expected hotunplug call flow

 include/hw/ppc/spapr_cpu_core.h |   6 --
 hw/ppc/spapr.c                  | 150 +++++++++++++++++++++++++++++++++++++++-
 hw/ppc/spapr_cpu_core.c         | 137 +-----------------------------------
 3 files changed, 151 insertions(+), 142 deletions(-)

-- 
2.7.4
