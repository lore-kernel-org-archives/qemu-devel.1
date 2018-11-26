Received: from eggs.gnu.org ([2001:4830:134:3::10]:49914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRDdz-0003D7-PY
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 04:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRDdu-0007qY-RM
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 04:57:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49686
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gRDdu-0007P4-Md
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 04:57:26 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAQ9rhdR052036
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 04:57:19 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p0bwyf1yv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 04:57:19 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 26 Nov 2018 09:57:17 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon, 26 Nov 2018 10:57:09 +0100
Message-Id: <20181126095710.380206-1-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/1] 9p fixes for v3.1.0-rc3
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

The following changes since commit 5298f4d67a911dd9cefa4c4185eed242074d64c2:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-11-23 08:54:52 +0000)

are available in the Git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 1d20398694a3b67a388d955b7a945ba4aa90a8a8:

  9p: fix QEMU crash when renaming files (2018-11-23 13:28:03 +0100)

----------------------------------------------------------------
Fixes a QEMU crash triggerable by guest userspace (CVE-2018-19489).

----------------------------------------------------------------
Greg Kurz (1):
      9p: fix QEMU crash when renaming files

 hw/9pfs/9p.c | 3 +++
 1 file changed, 3 insertions(+)
-- 
2.17.2
