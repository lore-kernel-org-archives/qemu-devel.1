Received: from eggs.gnu.org ([2001:4830:134:3::10]:57260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbm4S-0002IH-Gt
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbm4P-0001sf-Ez
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54352
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cbm4P-0001s5-9x
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:21 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v19AXdC0001083
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 05:35:20 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28gp6a1t1b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 05:35:20 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 9 Feb 2017 20:35:17 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  9 Feb 2017 16:03:59 +0530
Message-Id: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/6] POWER9 TCG enablements - part15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

This series contains 6 new instructions for POWER9 ISA3.0

Nikunj A Dadhania (6):
  target-ppc: generate exception for copy/paste
  target-ppc: add slbieg instruction
  target-ppc: add slbsync implementation
  target-ppc: add wait instruction
  target-ppc: support for 32-bit carry and overflow
  target-ppc: add mcrxrx instruction

 target/ppc/cpu.h        | 26 ++++++++++++++++++
 target/ppc/helper.h     |  1 +
 target/ppc/mmu-hash64.c | 16 +++++++++--
 target/ppc/translate.c  | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 2 deletions(-)

-- 
2.7.4
