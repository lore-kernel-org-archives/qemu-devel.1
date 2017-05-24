Received: from eggs.gnu.org ([2001:4830:134:3::10]:51421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dDOJw-0001bW-4Q
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dDOJt-0007BY-2k
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:54:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46042
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dDOJs-0007BK-TJ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:54:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4O4rnue052571
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 00:54:45 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2amx45t2k3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 00:54:45 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 24 May 2017 14:54:42 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed, 24 May 2017 10:23:31 +0530
Message-Id: <1495601614-18586-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/3] ppc/spapr: Fix migration of radix guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

This patchset fixes the migration of sPAPR radix guests.

Changes in v3:
--------------
- Dropped the patch that made h_register_process_table flags global as
  it is not required with the changed logic.
- The post load logic is now same for both TCG as well as KVM radix guests.
  Also ensured that radix and future v3 hash migration post load is
  treated similarly.
- Ensure TCG Radix guest migration isn't broken.

v2: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg04491.html

Bharata B Rao (3):
  migration: Introduce unregister_savevm_live()
  spapr: Unregister HPT savevm handlers for radix guests
  spapr: Fix migration of Radix guests

 hw/ppc/spapr.c              | 111 +++++++++++++++++++++++++-------------------
 include/hw/ppc/spapr.h      |   2 +
 include/migration/vmstate.h |   1 +
 migration/savevm.c          |  17 ++++++-
 4 files changed, 80 insertions(+), 51 deletions(-)

-- 
2.7.4
