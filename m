Received: from eggs.gnu.org ([2001:4830:134:3::10]:43973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gXMuh-0005FL-J2
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:04:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gXMuZ-0001Bu-KN
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:04:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gXMuZ-00015V-6s
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 04:04:03 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBD8xP59065058
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 04:03:59 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pbku7j81f-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 04:03:59 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 13 Dec 2018 09:03:56 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 13 Dec 2018 10:03:40 +0100
Message-Id: <20181213090343.1137475-1-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/3] 9p patches 2018-12-13
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

The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af422086:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-12-11 19:18:58 +0000)

are available in the Git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 93aee84f575d46699f49af3c96194012527e0b22:

  9p: remove support for the "handle" backend (2018-12-12 14:18:10 +0100)

----------------------------------------------------------------
Most notable change in this PR is the full removal of the "handle" fsdev
backend.

----------------------------------------------------------------
Greg Kurz (3):
      9p: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
      xen/9pfs: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
      9p: remove support for the "handle" backend

 fsdev/qemu-fsdev.c       |   3 -
 hw/9pfs/9p-handle.c      | 710 -----------------------------------------------
 hw/9pfs/9p.c             |   4 +-
 hw/9pfs/Makefile.objs    |   1 -
 hw/9pfs/xen-9p-backend.c |   6 +-
 qemu-deprecated.texi     |   8 -
 qemu-options.hx          |   8 +-
 7 files changed, 9 insertions(+), 731 deletions(-)
 delete mode 100644 hw/9pfs/9p-handle.c
-- 
2.17.2
