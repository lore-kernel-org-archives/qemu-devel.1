Received: from eggs.gnu.org ([2001:4830:134:3::10]:45378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cm2yU-0002Ua-3a
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cm2yQ-0002hH-7n
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:39:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cm2yP-0002h2-Ts
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:39:38 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v29IccGg089638
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 13:39:34 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 292y9cm4vf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 13:39:34 -0500
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Thu, 9 Mar 2017 15:39:32 -0300
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v29IdMDF32178234
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 15:39:30 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v29IcwX6022478
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 15:38:59 -0300
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Thu,  9 Mar 2017 15:38:35 -0300
Message-Id: <1489084718-15294-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu v2 0/3] PPC64 Improvements
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

v2:
 - applied code review

This patchset include initial support to PPC64 (Big-Endian), that is pretty 
much the same: only some fixes in configure and risugen.
Also, it adds a better random initialization of VSX registers.

Jose Ricardo Ziviani (3):
  risugen_ppc64: Load random 128-bit data to VSX registers
  configure: Add initial support to PPC64 (big endian)
  risugen,risugen_ppc64.pm: Add support ppc64 (big-endian)

 configure        |  9 ++++-----
 risugen          |  6 +++++-
 risugen_ppc64.pm | 44 +++++++++++++++++++++++++++++++++-----------
 3 files changed, 42 insertions(+), 17 deletions(-)

-- 
2.7.4
