Received: from eggs.gnu.org ([2001:4830:134:3::10]:37833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dAFmK-0003f5-4m
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dAFmF-0004C7-UO
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:11:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dAFmF-0004Bf-LA
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:11:07 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4FD4DNw114290
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 09:11:06 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aedhxran9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 09:11:05 -0400
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 15 May 2017 10:11:03 -0300
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 15 May 2017 10:10:51 -0300
Message-Id: <20170515131052.23457-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v10] pseries: migrate pending_events of spapr
 state
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

This patch was detached from the patchset:

"[PATCH v9 0/6] migration/ppc: migrating DRC, ccs_list and pending_events"

Because it is independent and has use outside of the scope of the
pseries DRC migration patchset.


Change log:

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


Jianjun Duan (1):
  migration: spapr: migrate pending_events of spapr state

 hw/ppc/spapr.c         | 33 +++++++++++++++++++++++++++++++++
 hw/ppc/spapr_events.c  | 24 +++++++++++++-----------
 include/hw/ppc/spapr.h |  3 ++-
 3 files changed, 48 insertions(+), 12 deletions(-)

-- 
2.9.3
