Received: from eggs.gnu.org ([2001:4830:134:3::10]:37675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cY20b-0005Cm-2f
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 21:47:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cY20Y-0003l2-0r
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 21:47:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36723
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cY20X-0003kn-S9
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 21:47:53 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0U2iCwf139584
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 21:47:52 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0a-001b2d01.pphosted.com with ESMTP id 289he1gxda-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 21:47:51 -0500
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 30 Jan 2017 00:47:49 -0200
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id 838BF352005F
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 21:47:14 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v0U2llbg27459604
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 00:47:47 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v0U2lkbE001252
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 00:47:47 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Mon, 30 Jan 2017 00:47:35 -0200
Message-Id: <1485744457-10324-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu 0/2] PPC64 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This patchset contains a fix necessary to run Risu under linux-user, that is due to the fact that linux-user doesn't fully implement ucontext struct. It also contains an small improvement to validate FPSRC flag for floating-point operations.

Jose Ricardo Ziviani (2):
  risu_ppc64: Fix Risu to run under qemu linux user
  risu_ppc64: Compare FPSCR flags

 risu_ppc64le.c         |  2 +-
 risu_reginfo_ppc64le.c | 16 +++++++++++-----
 test_ppc64le.s         | 20 +++++++++-----------
 3 files changed, 21 insertions(+), 17 deletions(-)

-- 
2.7.4
