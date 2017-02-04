Received: from eggs.gnu.org ([2001:4830:134:3::10]:42180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZpv6-0003n9-Kn
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZpv3-0000AX-GL
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cZpv3-0000A4-76
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:41 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v142FbEE095884
	for <qemu-devel@nongnu.org>; Fri, 3 Feb 2017 21:17:39 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28cyk3tycs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 21:17:38 -0500
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Sat, 4 Feb 2017 00:17:35 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 1A4F01DC006D
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 21:17:33 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v142HVxK4694214
	for <qemu-devel@nongnu.org>; Sat, 4 Feb 2017 00:17:31 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v142HVNf011941
	for <qemu-devel@nongnu.org>; Sat, 4 Feb 2017 00:17:32 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Sat,  4 Feb 2017 00:17:15 -0200
Message-Id: <1486174642-14883-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu 0/7] Risu PPC improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nikunj@linux.vnet.ibm.com

This patchset contains some fixes and improvements for ppc64le.

Jose Ricardo Ziviani (7):
  risu_ppc64le: improve xsrqpi[x] and xsrqpxp instructions
  risu_ppc64le: fix 32-bit mov immediate
  risu_ppc64le: implement sign extend for small neg constants
  risu_ppc64le: implement FP random data for test improvement
  risu_ppc64le: stop loading data to register 1 and 13
  risu_ppc64le: remove fancy shell character cont from messages
  risu_ppc64le: fix minor code style in assembly test code

 ppc64.risu             |  9 ++++++---
 risu_reginfo_ppc64le.c |  6 +++---
 risugen_ppc64.pm       | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 test_ppc64le.s         | 20 +++++++++-----------
 4 files changed, 61 insertions(+), 22 deletions(-)

-- 
2.7.4
