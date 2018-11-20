Received: from eggs.gnu.org ([2001:4830:134:3::10]:41070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gP4lB-00056U-7i
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gP4l8-0006Zn-2S
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:04:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gP4l7-0006ZI-Om
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:04:01 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAKBwd6p134002
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 07:04:00 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nvgbuvehe-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 07:04:00 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 20 Nov 2018 12:03:58 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 20 Nov 2018 13:03:25 +0100
Message-Id: <20181120120326.30879-1-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/1] 9p fixes for v3.1.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

The following changes since commit 3c035a41dca808f096a128fe2b62d849fe638a25:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2018-11-20' into staging (2018-11-20 10:56:57 +0000)

are available in the Git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 5b3c77aa581ebb215125c84b0742119483571e55:

  9p: take write lock on fid path updates (CVE-2018-19364) (2018-11-20 13:00:35 +0100)

----------------------------------------------------------------
Fixes yet another use-after-free issue that could be triggered by a
misbehaving guest. This is a follow-up to commit:

commit 5b76ef50f62079a2389ba28cacaf6cce68b1a0ed
Author: Greg Kurz <groug@kaod.org>
Date:   Wed Nov 7 01:00:04 2018 +0100

    9p: write lock path in v9fs_co_open2()

----------------------------------------------------------------
Greg Kurz (1):
      9p: take write lock on fid path updates (CVE-2018-19364)

 hw/9pfs/9p.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
-- 
2.17.2
