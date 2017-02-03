Received: from eggs.gnu.org ([2001:4830:134:3::10]:39806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZlvS-0006TJ-Cl
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZlvP-00073i-DS
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:01:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cZlvP-00073W-4z
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:01:47 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v13M0sDI073373
	for <qemu-devel@nongnu.org>; Fri, 3 Feb 2017 17:01:45 -0500
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28cy5e68qf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 17:01:44 -0500
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Fri, 3 Feb 2017 20:01:42 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Fri,  3 Feb 2017 20:01:13 -0200
Message-Id: <1486159277-25949-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/4] POWER9 TCG enablements - part 13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com

This set contains 4 new instructions

xsrqpi[x] - VSX Scalar Round to Quad-Precision Integer
xsrqpxp - VSX Scalar Round Quad-Precision to Double-Extended Precision
xssqrtqp - VSX Scalar Square Root Quad-Precision
xssubqp - VSX Scalar Subtract Quad-Precision

Note:
 - xssqrtqpo and xssubqpo will be implemented when round-to-odd is ready.

Jose Ricardo Ziviani (4):
  ppc: implement xsrqpi[x] instruction
  ppc: implement xsrqpxp instruction
  ppc: implement xssqrtqp instruction
  ppc: implement xssubqp instruction

 target/ppc/fpu_helper.c             | 188 ++++++++++++++++++++++++++++++++++++
 target/ppc/helper.h                 |   4 +
 target/ppc/internal.h               |   1 +
 target/ppc/translate/vsx-impl.inc.c |   5 +
 target/ppc/translate/vsx-ops.inc.c  |  15 +++
 5 files changed, 213 insertions(+)

-- 
2.7.4
