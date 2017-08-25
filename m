Received: from eggs.gnu.org ([2001:4830:134:3::10]:54903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dlLtC-0003HL-0y
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 17:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dlLt8-0004jv-Ok
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 17:11:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dlLt8-0004jS-FD
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 17:11:34 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7PLB7Vp067277
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 17:11:33 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cjpwyewcd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 17:11:32 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 25 Aug 2017 15:11:32 -0600
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 25 Aug 2017 18:11:18 -0300
Message-Id: <20170825211119.474-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.11 v2] hw/ppc: CAS reset on early device
 hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com

v2:
- rebased with ppc-for-2.11
- function 'spapr_cas_completed' dropped
- function 'spapr_drc_needed' made public and it's now used inside
  'spapr_hotplugged_dev_before_cas'
- 'spapr_drc_needed' was changed to support the migration of logical
  DRCs with devs attached in UNUSED state
- new function: 'spapr_clear_pending_events'. This function is used
  inside ppc_spapr_reset to reset the pending_events QTAILQ

Daniel Henrique Barboza (1):
  hw/ppc: CAS reset on early device hotplug

 hw/ppc/spapr.c             | 34 ++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_drc.c         |  5 ++---
 include/hw/ppc/spapr_drc.h |  1 +
 3 files changed, 37 insertions(+), 3 deletions(-)

-- 
2.9.4
