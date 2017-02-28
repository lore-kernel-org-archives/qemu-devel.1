Received: from eggs.gnu.org ([2001:4830:134:3::10]:53613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cieMd-0004NU-91
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cieMY-0005vl-8T
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:46:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48728
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cieMY-0005vd-2u
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:46:30 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1S9hk7o118687
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 04:46:28 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28w28km5g3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 04:46:28 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 28 Feb 2017 09:46:26 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Feb 2017 10:46:13 +0100
Message-Id: <1488275176-16613-1-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/3] 9p patches 2018-02-27 for 2.9 soft freeze
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

The following changes since commit 9b9fbe8a4e9eec9072ee2697a6af59144442785f:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170227-1' into staging (2017-02-27 19:19:46 +0000)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to a2a7862ca9ab1689f094c319ec92ecbd6fd1b46d:

  throttle: factor out duplicate code (2017-02-28 10:31:46 +0100)

----------------------------------------------------------------
This pull request brings:
- a fix to a minor bug reported by Coverity
- throttling support in the local backend (command line only)

This replaces the previous pull request I had sent on 02/27:
- authorship for throttle support was fixed
- fixes for CVE-2016-9602 will be sent in a separate pull request as
  suggested by Michael Tokarev

Thanks.
----------------------------------------------------------------
Paolo Bonzini (1):
      9pfs: fix v9fs_lock error case

Pradeep Jagadeesh (2):
      fsdev: add IO throttle support to fsdev devices
      throttle: factor out duplicate code

 blockdev.c                      |  83 ++--------------------------
 fsdev/Makefile.objs             |   2 +-
 fsdev/file-op-9p.h              |   3 +
 fsdev/qemu-fsdev-opts.c         |   3 +
 fsdev/qemu-fsdev-throttle.c     | 118 ++++++++++++++++++++++++++++++++++++++++
 fsdev/qemu-fsdev-throttle.h     |  39 +++++++++++++
 hw/9pfs/9p-local.c              |   8 +++
 hw/9pfs/9p.c                    |  19 ++++---
 hw/9pfs/cofile.c                |   2 +
 include/qemu/throttle-options.h |  92 +++++++++++++++++++++++++++++++
 qemu-options.hx                 |   7 ++-
 11 files changed, 289 insertions(+), 87 deletions(-)
 create mode 100644 fsdev/qemu-fsdev-throttle.c
 create mode 100644 fsdev/qemu-fsdev-throttle.h
 create mode 100644 include/qemu/throttle-options.h
-- 
2.7.4
