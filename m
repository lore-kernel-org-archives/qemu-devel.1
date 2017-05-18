Received: from eggs.gnu.org ([2001:4830:134:3::10]:41339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dBRyC-0005jy-5o
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dBRy9-0001Xp-08
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:24:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50377
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dBRy8-0001XX-Re
	for qemu-devel@nongnu.org; Thu, 18 May 2017 16:24:20 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4IKIeN7109086
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 16:24:20 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahgvwca4t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 16:24:19 -0400
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 18 May 2017 17:24:18 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 18 May 2017 17:24:00 -0300
Message-Id: <20170518202402.12571-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v11 0/2] pseries: migrate pending_events of
 spapr state
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

v11:
- patch 1 (new): cleanup of spapr_events.c:
    * removed the 'exception' boolean from the sPAPREventLogEntry
    * simplified the 'event_scan' function
- patch 2:
    * data_size is now calculated inside rtas_event_log_queue()
    * using VBUFFER instead of VARRAY to avoid casts
    * log_type changed to int32_t

v10: detached from DRC patch set

v9: no changes

v8: no changes

v7: no changes

v6: - Rebased with QEMU master after 6+ months.
class and minor improvements.
    - Added clarifications from the previous v5 discussions in the commit messages.

v5: - Rebased on David's ppc-for-2.8.

v4: - Rebased on David's ppc-for-2.7. 

v3: - Simplify overall design followng discussion with Paolo. No longer need
      metadata to migrate QTAILQ.
    - Extend VMStateInfo instead of adding similar fields to VMStateField.

v2: - Put the newly added migrating fields in subsections so that backward 
      migration is not broken.  
(link: https://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg04188.html)

v1: - Inital version.
(link: https://lists.nongnu.org/archive/html/qemu-devel/2016-04/msg02601.html)


This patch was detached from the patchset:

"[PATCH v9 0/6] migration/ppc: migrating DRC, ccs_list and pending_events"

Because it is independent and has use outside of the scope of the
pseries DRC migration patchset.

Daniel Henrique Barboza (1):
  hw/ppc/spapr_events.c: removing 'exception' from sPAPREventLogEntry

Jianjun Duan (1):
  migration: spapr: migrate pending_events of spapr state

 hw/ppc/spapr.c         | 32 ++++++++++++++++++++++++++++++
 hw/ppc/spapr_events.c  | 53 ++++++++------------------------------------------
 include/hw/ppc/spapr.h |  4 ++--
 3 files changed, 42 insertions(+), 47 deletions(-)

-- 
2.9.4
