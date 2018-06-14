Received: from eggs.gnu.org ([2001:4830:134:3::10]:47266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTa8D-0007AF-O9
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTa88-0001eG-LJ
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:50:13 -0400
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:44200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fTa88-0001cs-CX
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:50:08 -0400
Received: from player734.ha.ovh.net (unknown [10.109.108.75])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 66A631BC9B4
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 23:50:06 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 14 Jun 2018 23:49:54 +0200
Message-ID: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/5] spapr_cpu_core: fixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>

This series is a follow-up to David's "Better handling of machine specific
per-cpu information" v3 patchset. It addresses issues mentioned at:

https://lists.nongnu.org/archive/html/qemu-ppc/2018-06/msg00514.html

This series fixes potential crashes and leaks in case of error during
CPU hotplug. It hence assumes that the machine_data pointer is set a
bit earlier as suggested at the above URL, for CPU hotplug to work.

Patch 1 is just code cleanup.

Patch 2 fixes a 2.12 regression.

Patch 3 fixes a long standing issue. It could possibly be fixed in
current master but this would require to rebase David's series on
top of it. Not sure it's worth the pain.

Patch 4 and 5 are some more cleanup.

--
Greg

---

Greg Kurz (5):
      spapr_cpu_core: convert last snprintf() to g_strdup_printf()
      spapr_cpu_core: fix potential leak in spapr_cpu_core_realize()
      spapr_cpu_core: add missing rollback on realization path
      spapr_cpu_core: introduce spapr_create_vcpu()
      spapr_cpu_core: simplify spapr_cpu_core_realize()


 hw/ppc/spapr_cpu_core.c |   93 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 33 deletions(-)
