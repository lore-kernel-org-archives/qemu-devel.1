Received: from eggs.gnu.org ([2001:4830:134:3::10]:59440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dIVoz-0002dk-A4
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dIVov-0001KO-Dw
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:56:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dIVov-0001Jq-3I
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:56:01 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v577sRJZ059810
	for <qemu-devel@nongnu.org>; Wed, 7 Jun 2017 03:55:59 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2axan06x06-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 03:55:59 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 7 Jun 2017 17:55:56 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed,  7 Jun 2017 13:24:51 +0530
Message-Id: <1496822093-5700-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 0/2] ppc/spapr: Fix migration of radix guests
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

Changes in v5
-------------
- Ensured that assert(kvm_enabled()) isn't touched in any HTAB savevm
  handlers except in htab_save_setup() where it is made conditional on
  htab_shift.

v4: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg07058.html

Bharata B Rao (2):
  spapr: Add a "no HPT" encoding to HTAB migration stream
  spapr: Fix migration of Radix guests

 hw/ppc/spapr.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

-- 
2.7.4
