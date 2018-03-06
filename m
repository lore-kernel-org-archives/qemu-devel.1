Received: from eggs.gnu.org ([2001:4830:134:3::10]:33177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sandipan@linux.vnet.ibm.com>) id 1etBOL-00024W-W1
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:08:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sandipan@linux.vnet.ibm.com>) id 1etBOH-0007As-ML
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:08:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43202
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sandipan@linux.vnet.ibm.com>)
	id 1etBOH-00079z-Av
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:08:21 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w26C40ws035236
	for <qemu-devel@nongnu.org>; Tue, 6 Mar 2018 07:08:20 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ghqxn8879-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 07:08:20 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sandipan@linux.vnet.ibm.com>;
	Tue, 6 Mar 2018 12:08:17 -0000
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Tue,  6 Mar 2018 17:38:10 +0530
Message-Id: <20180306120813.17537-1-sandipan@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH risu v2 0/3] Miscellaneous fixes for powerpc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, joserz@linux.vnet.ibm.com
Cc: nikunj@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, qemu-devel@nongnu.org

The first patch adds the patterns for the missing byte and
doubleword load instructions. The second patch fixes mismatches
encountered when using the load quadword instruction. The last
patch fixes a minor typo in the floating-point register prefix
shown when dumping the register values.

Changelog:
v2 -> Added a cover letter as requested by Peter.

Sandipan Das (3):
  ppc64.risu: Add missing byte and dword loads
  ppc64.risu: Fix pattern for load qword
  risu_reginfo_ppc64.c: Fix register name prefix

 ppc64.risu           | 29 +++++++++++++++++++++++++++--
 risu_reginfo_ppc64.c |  4 ++--
 2 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.14.3
