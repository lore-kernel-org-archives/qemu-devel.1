Received: from eggs.gnu.org ([2001:4830:134:3::10]:45891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbhMh-0003YS-1B
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbhMc-0004uo-3u
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:33:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cbhMb-0004uh-Pn
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:33:50 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v195XdXv125516
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 00:33:48 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28g3w8tbue-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 00:33:47 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 9 Feb 2017 11:03:45 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  9 Feb 2017 11:03:29 +0530
Message-Id: <1486618411-7018-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 0/2] POWER9 TCG enablements - part14
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

This series contains 4 new instructions for POWER9 ISA3.0
    Load/Store Atomic instructions

Changelog:
v0:
   Raise invalid execption for function codes that are not implemented, 
   and data storage execption for invalid function codes.

Balamuruhan S (2):
  target-ppc: implement load atomic instruction
  target-ppc: implement store atomic instruction

 target/ppc/internal.h  |   2 +
 target/ppc/translate.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

-- 
2.7.4
