Received: from eggs.gnu.org ([2001:4830:134:3::10]:34345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAVyS-0006Zb-HZ
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAVyP-0008UG-F3
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:28:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAVyP-0008SB-3o
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:28:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4G6QuD3097373
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 02:28:43 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2afs4s7dh1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 02:28:43 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 16 May 2017 07:28:40 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue, 16 May 2017 08:28:22 +0200
Message-Id: <1494916103-32207-1-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL] 9p security fix for 2.10 (CVE-2017-7493)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

The following changes since commit 3a8760664d5c1a1a93c9012bdb8ac07ab8fd4b0d:

  Merge tag 'tracing-pull-request' into staging (2017-05-12 10:39:35 -0400)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/security-fix-for-2.10

for you to fetch changes up to 7a95434e0ca8a037fd8aa1a2e2461f92585eb77b:

  9pfs: local: forbid client access to metadata (CVE-2017-7493) (2017-05-15 15:20:57 +0200)

----------------------------------------------------------------
Fix for CVE-2017-7493.

----------------------------------------------------------------
Greg Kurz (1):
      9pfs: local: forbid client access to metadata (CVE-2017-7493)

 hw/9pfs/9p-local.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)
-- 
2.7.4
