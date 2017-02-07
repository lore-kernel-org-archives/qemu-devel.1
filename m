Received: from eggs.gnu.org ([2001:4830:134:3::10]:54963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cb0ll-0000Dt-HS
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cb0le-0004s2-Ky
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:04:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cb0le-0004pg-CA
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:04:50 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1783ss0081815
	for <qemu-devel@nongnu.org>; Tue, 7 Feb 2017 03:04:45 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28eu4v9sv1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 03:04:45 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Tue, 7 Feb 2017 13:34:42 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Tue,  7 Feb 2017 13:34:34 +0530
Message-Id: <1486454676-29112-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v1 0/2] softfloat: float128 to uint64 and
 uint32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, nikunj@linux.vnet.ibm.com, peter.maydell@linaro.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

This series introduces two conversion routines: 
float128_to_uint64_round_to_zero() and float128_to_uint32_round_to_zero().

float128_to_uint64_round_to_zero() uses the newly added
float128_to_uint64() whose implementation is based on float64_to_uint64().

float128_to_uint32_round_to_zero() uses float128_to_uint64_round_to_zero().

Changes in v1:
--------------
- Reimplemented float128_to_uint64() based on float64_to_uint64().
- Added float128_to_uint32_round_to_zero().

v0: https://www.mail-archive.com/qemu-devel@nongnu.org/msg426756.html

Bharata B Rao (2):
  softfloat: Add float128_to_uint64_round_to_zero()
  softfloat: Add float128_to_uint32_round_to_zero()

 fpu/softfloat.c         | 87 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/fpu/softfloat.h |  3 ++
 2 files changed, 90 insertions(+)

-- 
2.7.4
