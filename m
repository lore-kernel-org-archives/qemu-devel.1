Received: from eggs.gnu.org ([2001:4830:134:3::10]:50599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ckwq7-0005GX-UV
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ckwq4-0005bx-OQ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ckwq4-0005bV-FM
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:54:28 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v26HrkcV123017
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 12:54:25 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 291814paqj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 12:54:25 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 6 Mar 2017 17:54:22 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  6 Mar 2017 18:54:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <1488822850-23070-1-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/6] 9pfs fixes for 2.9 2017-03-06
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

The following changes since commit 56b51708e9e22809d2a78f38d0ac84bb3f3fca92:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.9-20170306' into staging (2017-03-06 13:06:30 +0000)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/fixes-for-2.9

for you to fetch changes up to b003fc0d8aa5e7060dbf7e5862b8013c73857c7f:

  9pfs: fix vulnerability in openat_dir() and local_unlinkat_common() (2017-03-06 17:34:01 +0100)

----------------------------------------------------------------
Fixes issues that got merged with the latest pull request:
- missing O_NOFOLLOW flag for CVE-2016-960
- build break with older glibc that don't have O_PATH and AT_EMPTY_PATH
- various bugs reported by Coverity

----------------------------------------------------------------
Greg Kurz (6):
      9pfs: fix bogus fd check in local_remove()
      9pfs: fix fd leak in local_opendir()
      9pfs: fail local_statfs() earlier
      9pfs: don't use AT_EMPTY_PATH in local_set_cred_passthrough()
      9pfs: fix O_PATH build break with older glibc versions
      9pfs: fix vulnerability in openat_dir() and local_unlinkat_common()

 hw/9pfs/9p-local.c | 10 +++++++---
 hw/9pfs/9p-util.h  |  8 +++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)
-- 
2.7.4
