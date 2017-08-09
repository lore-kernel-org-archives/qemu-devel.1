Received: from eggs.gnu.org ([2001:4830:134:3::10]:52105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dfJhp-0001es-Of
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 01:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dfJhm-0006bD-JJ
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 01:38:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1dfJhm-0006aW-81
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 01:38:54 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v795bHIg058283
	for <qemu-devel@nongnu.org>; Wed, 9 Aug 2017 01:38:51 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c7pjsa43p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 01:38:51 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Wed, 9 Aug 2017 15:38:49 +1000
Date: Wed, 9 Aug 2017 15:38:45 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <cover.1502257087.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/1] Cleanup cpu_dt_id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au


Just the one minor change in this version.

Patch set changelog follows:

====== Version 2 -> version 3: ======

Patch 1/1: ppc: spapr: Make VCPU ID handling private to SPAPR
* Implemented spapr_find_cpu() using spapr_vcpu_id() rather than direct access
  to vcpu_id.

====== Version 1 -> version 2: ======

Patch 1/1: ppc: spapr: Make VCPU ID handling private to SPAPR
* Re-arranged so that spapr_vcpu_id() calls kvm_arch_vcpu_id() rather than the
  other way around.


Sam Bobroff (1):
  ppc: spapr: Make VCPU ID handling private to SPAPR

 hw/ppc/ppc.c           | 21 ---------------------
 hw/ppc/spapr.c         | 40 +++++++++++++++++++++++++++++++++-------
 hw/ppc/spapr_hcall.c   |  4 ++--
 hw/ppc/spapr_rtas.c    |  4 ++--
 include/hw/ppc/spapr.h |  3 +++
 target/ppc/cpu.h       | 18 ------------------
 target/ppc/kvm.c       |  2 +-
 7 files changed, 41 insertions(+), 51 deletions(-)

-- 
2.12.1.382.gc0f9c7058
