Received: from eggs.gnu.org ([2001:4830:134:3::10]:60284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1dDyAS-0003qb-Ve
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1dDyAO-0001gq-0L
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:11:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1dDyAN-0001gg-Mk
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:11:23 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4PJ8cBu034376
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 15:11:22 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ans8ybu0d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 15:11:21 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Thu, 25 May 2017 16:11:18 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v4PJB8jZ2294092
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 16:11:16 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v4PJAiQt013555
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 16:10:44 -0300
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Thu, 25 May 2017 16:10:19 -0300
Message-Id: <1495739423-32326-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu v3 0/4] PPC64 Improvements
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

v3:
 - sent v2 in March and applied the review but, for some reason, this
   patchset has never been sent.
 - dropped ARCH parameter from makefile
 - renamed *ppc64le.* to *ppc64.*

v2:
 - applied code review

This patchset include initial support to PPC64 (Big-Endian), that is pretty 
much the same: only some fixes in configure and risugen.
Also, it adds a better random initialization of VSX registers.

Jose Ricardo Ziviani (4):
  risugen_ppc64: Load random 128-bit data to vector registers
  configure: Add initial support to PPC64 (big endian)
  risugen,risugen_ppc64.pm: Add support ppc64 (big-endian)
  build: Add support to PowerPC BE and remove ARCH

 build-all-archs        |   2 +-
 configure              |  14 +---
 risu_ppc64.c           |  40 ++++++++++
 risu_ppc64le.c         |  40 ----------
 risu_reginfo_ppc64.c   | 193 +++++++++++++++++++++++++++++++++++++++++++++++++
 risu_reginfo_ppc64.h   |  28 +++++++
 risu_reginfo_ppc64le.c | 193 -------------------------------------------------
 risu_reginfo_ppc64le.h |  28 -------
 risugen                |   6 +-
 risugen_ppc64.pm       |  46 +++++++++---
 test_ppc64.s           |  49 +++++++++++++
 test_ppc64le.s         |  49 -------------
 12 files changed, 353 insertions(+), 335 deletions(-)
 create mode 100644 risu_ppc64.c
 delete mode 100644 risu_ppc64le.c
 create mode 100644 risu_reginfo_ppc64.c
 create mode 100644 risu_reginfo_ppc64.h
 delete mode 100644 risu_reginfo_ppc64le.c
 delete mode 100644 risu_reginfo_ppc64le.h
 create mode 100644 test_ppc64.s
 delete mode 100644 test_ppc64le.s

-- 
2.7.4
