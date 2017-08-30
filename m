Received: from eggs.gnu.org ([2001:4830:134:3::10]:57158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dn7cm-00050h-8m
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dn7ch-0006O7-7p
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:22:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41520
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dn7ch-0006Nu-1r
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:21:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7UIJe7q050488
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 14:21:54 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cnxcr0t8b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 14:21:54 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 30 Aug 2017 14:21:53 -0400
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 15:21:38 -0300
Message-Id: <20170830182141.19996-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.11 v3 0/3] hw/ppc: CAS reset on early
 device hotplug
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

v3:
- split into 3 patches, first 2 are fixes that are independent of the
reboot code that can be applied separately:
    - patch 1: spapr_drc_needed fix
    - patch 2: clear pending_events on reboot, following David's
suggestions on the v2 review.
    - patch 3: CAS reboot

v2:
- rebased with ppc-for-2.11
- function 'spapr_cas_completed' dropped
- function 'spapr_drc_needed' made public and it's now used inside
  'spapr_hotplugged_dev_before_cas'
- 'spapr_drc_needed' was changed to support the migration of logical
  DRCs with devs attached in UNUSED state
- new function: 'spapr_clear_pending_events'. This function is used
  inside ppc_spapr_reset to reset the pending_events QTAILQ


Daniel Henrique Barboza (3):
  hw/ppc/spapr_drc.c: change spapr_drc_needed to use drc->dev
  hw/ppc: clear pending_events on machine reset
  hw/ppc: CAS reset on early device hotplug

 hw/ppc/spapr.c             | 27 ++++++++++++++++++++++++++-
 hw/ppc/spapr_drc.c         |  5 ++---
 hw/ppc/spapr_events.c      | 11 +++++++++++
 include/hw/ppc/spapr.h     |  1 +
 include/hw/ppc/spapr_drc.h |  1 +
 5 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.9.4
