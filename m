Received: from eggs.gnu.org ([2001:4830:134:3::10]:56961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQwjy-0001yQ-Tj
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQwju-0000Nu-Uc
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQwju-0000Jf-L2
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:14 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w57FJFtU134713
	for <qemu-devel@nongnu.org>; Thu, 7 Jun 2018 11:22:05 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jf5wkchuq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 11:22:05 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 7 Jun 2018 16:22:03 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu,  7 Jun 2018 17:21:12 +0200
Message-Id: <20180607152119.3447-1-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/7] 9p patches 2018-06-07
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

The following changes since commit 5d328d7d2f1fd4fb160bcfb6e4eb838720274438:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-update-20180605.0' into staging (2018-06-07 08:59:28 +0100)

are available in the Git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to aca6897fba149a2a650dcdf5a5e1ae828371f4aa:

  9p: xattr: Properly translate xattrcreate flags (2018-06-07 12:17:22 +0200)

----------------------------------------------------------------
Mostly bug fixes and code sanitization motivated by the upcoming
support for Darwin hosts. Thanks to Keno Fischer.

----------------------------------------------------------------
Keno Fischer (7):
      9p: proxy: Fix size passed to `connect`
      9p: local: Properly set errp in fstatfs error path
      9p: Move a couple xattr functions to 9p-util
      9p: xattr: Fix crashes due to free of uninitialized value
      9p: local: Avoid warning if FS_IOC_GETVERSION is not defined
      9p: Properly check/translate flags in unlinkat
      9p: xattr: Properly translate xattrcreate flags

 hw/9pfs/9p-handle.c |  8 +-------
 hw/9pfs/9p-local.c  | 40 ++++++++++++++++++++++++----------------
 hw/9pfs/9p-proxy.c  |  5 ++---
 hw/9pfs/9p-util.c   | 33 +++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util.h   |  4 ++++
 hw/9pfs/9p-xattr.c  | 33 ---------------------------------
 hw/9pfs/9p.c        | 34 ++++++++++++++++++++++++++++------
 hw/9pfs/9p.h        |  4 ++++
 8 files changed, 96 insertions(+), 65 deletions(-)
-- 
2.14.4
