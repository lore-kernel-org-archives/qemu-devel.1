Received: from eggs.gnu.org ([2001:4830:134:3::10]:33692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1d7fk3-0006AA-I3
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1d7fk0-0006oZ-Ci
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:18:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1d7fk0-0006o8-2K
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:18:08 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v48ADgUW064248
	for <qemu-devel@nongnu.org>; Mon, 8 May 2017 06:18:06 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aah9pr779-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 06:18:02 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Mon, 8 May 2017 19:09:07 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Mon,  8 May 2017 14:36:15 +0530
Message-Id: <1494234377-1773-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 0/2] ppc/spapr: Fix migration of radix
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

Migrating radix guests fails with the following error on the target
side:

qemu-system-ppc64: htab_load() bad index 2113929216 (5378+0 entries) in htab stream (htab_shift=0)
qemu-system-ppc64: error while loading state for instance 0x0 of device 'spapr/htab'
qemu-system-ppc64: load of migration failed: Invalid argument 

Fix this by not registering htab savevm handler for radix case.

Patches apply against ppc-for-2.10 branch of dwg's tree.

Bharata B Rao (2):
  spapr: Make h_register_process_table hcall flags global
  spapr: Fix migration of Radix guests

 hw/ppc/spapr.c         | 18 +++++++++++++++---
 hw/ppc/spapr_hcall.c   | 36 +++++++++++++++++++-----------------
 include/hw/ppc/spapr.h | 13 +++++++++++++
 3 files changed, 47 insertions(+), 20 deletions(-)

-- 
2.7.4
