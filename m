Received: from eggs.gnu.org ([2001:4830:134:3::10]:49567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ciRB5-0003dh-Up
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ciRB2-0003Vj-1G
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:41:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50227
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1ciRB1-0003VZ-PK
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:41:43 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RJdDoa141845
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:41:42 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28vrp7vmpt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:41:41 -0500
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 27 Feb 2017 16:41:40 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 7FFCF1DC006D
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:41:39 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1RJfcLM32571610
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:41:38 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1RJfbHC006352
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:41:37 -0300
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Mon, 27 Feb 2017 16:41:27 -0300
Message-Id: <1488224492-20316-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu 0/5] PPC64 Improvements
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

This patchset include initial support to PPC64 (Big-Endian), that is pretty much the same: only some fixes in configure and risugen.
Also, it adds a better random initialization of VSX registers.
And does some cleanup.

Jose Ricardo Ziviani (5):
  risugen_ppc64: Load random 128-bit data to VSX registers
  risu_reginfo_ppc64le: Remove unused code from PPC64 register
    comparison
  configure: Add initial support to PPC64 (big endian)
  risugen,risugen_ppc64.pm: Add support ppc64 (big-endian)
  risugen_ppc64: Remove unused code

 configure              |  9 ++++-----
 risu_reginfo_ppc64le.c |  8 --------
 risugen                |  6 +++++-
 risugen_ppc64.pm       | 48 +++++++++++++++++++++++++++++++++---------------
 4 files changed, 42 insertions(+), 29 deletions(-)

-- 
2.7.4
