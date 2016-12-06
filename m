Received: from eggs.gnu.org ([2001:4830:134:3::10]:41278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cELbQ-0000FT-2H
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cELbN-0004OR-Fy
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:40:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44020
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cELbN-0004NR-82
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:40:33 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB6Je2Kx104877
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 14:40:31 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2761xrev1c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 14:40:31 -0500
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 6 Dec 2016 17:40:29 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Tue,  6 Dec 2016 17:40:03 -0200
Message-Id: <1481053210-26821-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/7] POWER9 TCG enablements - BCD functions
 - final part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com

v2:
 - bcd[s,sr,us] uses 1 byte for shifting instead of 4 bytes
 - left/right functions in host-utils are out of CONFIG_INT128
 - fixes overflowing issue in left shift and added a testcase

This serie contains 5 new instructions for POWER9 ISA3.0, left/right shifts for 
unsigned quadwords and a small improvement to check whether a bcd value is 
valid or not.

bcds.: Decimal signed shift
bcdus.: Decimal unsigned shift
bcdsr.: Decimal shift and round
bcdtrunc.: Decimal signed trucate
bcdtrunc.: Decimal unsigned truncate

Jose Ricardo Ziviani (7):
  target-ppc: Implement bcd_is_valid function
  target-ppc: Implement unsigned quadword left/right shift and unit
    tests
  target-ppc: Implement bcds. instruction
  target-ppc: Implement bcdus. instruction
  target-ppc: Implement bcdsr. instruction
  target-ppc: Implement bcdtrunc. instruction
  target-ppc: Implement bcdtrunc. instruction

 include/qemu/host-utils.h           |  43 +++++++
 target-ppc/helper.h                 |   5 +
 target-ppc/int_helper.c             | 229 +++++++++++++++++++++++++++++++++++-
 target-ppc/translate/vmx-impl.inc.c |  16 +++
 target-ppc/translate/vmx-ops.inc.c  |  13 +-
 tests/Makefile.include              |   5 +-
 tests/test-shift128.c               |  98 +++++++++++++++
 7 files changed, 399 insertions(+), 10 deletions(-)
 create mode 100644 tests/test-shift128.c

-- 
2.7.4
