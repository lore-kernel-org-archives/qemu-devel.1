Received: from eggs.gnu.org ([2001:4830:134:3::10]:55336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dKHyE-000410-9W
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 01:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dKHy9-0008Cw-DL
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 01:32:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47565
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dKHy9-0008CT-7o
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 01:32:53 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5C5TSsH137275
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 01:32:52 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2b19fkdam8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 01:32:51 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Mon, 12 Jun 2017 15:32:48 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Mon, 12 Jun 2017 11:02:33 +0530
Message-Id: <1497245555-32472-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v6 0/2] ppc/spapr: Fix migration of radix guests
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

Migration of hash and radix guests individually has been tested on
TCG and KVM (P8 and P9 hosts). Changeover from HPT to RPT and vice versa
via reboot during migration isn't tested yet since it is possible
to test that currently only with TCG and TCG reboot is being fixed.

Changes in v6:
--------------
- Ensure any allocated HPT is free by the target when the source
  doesn't send HPT.

v5: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01637.html

Bharata B Rao (2):
  spapr: Add a "no HPT" encoding to HTAB migration stream
  spapr: Fix migration of Radix guests

 hw/ppc/spapr.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

-- 
2.7.4
