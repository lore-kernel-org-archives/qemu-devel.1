Received: from eggs.gnu.org ([2001:4830:134:3::10]:59957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cWNvu-0005vN-8e
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cWNvq-00070t-Vp
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:48:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40187
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cWNvq-00070Y-Qb
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:48:14 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0PDhhKO068631
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 08:48:13 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 286q5qf29n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 08:48:13 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 25 Jan 2017 13:48:12 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed, 25 Jan 2017 14:47:57 +0100
Message-Id: <1485352082-16830-1-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/5] 9p patches 20170125
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

The following changes since commit a9e404600a9bd1e6a26431fc89e5069092e67f14:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170124' into staging (2017-01-24 17:26:26 +0000)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to fa0eb5c512d17a223d9f9bac45da48d78d12f584:

  9pfs: fix offset error in v9fs_xattr_read() (2017-01-25 09:34:35 +0100)

----------------------------------------------------------------
This pull request fixes a 2.9 regression and a long standing bug that can
cause 9p clients to hang. Other patches are minor enhancements.

----------------------------------------------------------------
Greg Kurz (5):
      9pfs: add missing coroutine_fn annotations
      tests: virtio-9p: improve error reporting
      9pfs: fix off-by-one error in PDU free list
      9pfs: local: trivial cosmetic fix in pwritev op
      9pfs: fix offset error in v9fs_xattr_read()

 hw/9pfs/9p-local.c     |  3 +--
 hw/9pfs/9p.c           | 12 ++++++------
 tests/virtio-9p-test.c | 24 +++++++++++++++++++-----
 3 files changed, 26 insertions(+), 13 deletions(-)
-- 
2.7.4
