Received: from eggs.gnu.org ([2001:4830:134:3::10]:43801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBnf5-0006WG-DF
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:06:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBnf1-0001uF-EL
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:06:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eBnf1-0001tz-4D
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:06:19 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA6K5OS5120925
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 15:06:11 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e2wbhugku-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 15:06:10 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 6 Nov 2017 20:06:05 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  6 Nov 2017 21:05:52 +0100
Message-Id: <20171106200554.5894-1-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/2] 9pfs fixes for 2.11 20171106
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

The following changes since commit 299d1ea9bb56bd9f45f905125489bdd7d543a1aa:

  Merge remote-tracking branch 'remotes/yongbok/tags/mips-20171106' into staging (2017-11-06 16:13:10 +0000)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 267fcadf325e54c6e1cb27321413dbdbe2200510:

  9pfs: fix v9fs_mark_fids_unreclaim() return value (2017-11-06 18:05:35 +0100)

----------------------------------------------------------------
This fixes a bad errno returned to the guest and a trivial coding style nit.

----------------------------------------------------------------
Greg Kurz (2):
      9pfs: drop one user of struct V9fsFidState
      9pfs: fix v9fs_mark_fids_unreclaim() return value

 hw/9pfs/9p.c | 2 +-
 hw/9pfs/9p.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)
-- 
2.13.6
