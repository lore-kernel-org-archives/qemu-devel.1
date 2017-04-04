Received: from eggs.gnu.org ([2001:4830:134:3::10]:46279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cvR5e-0006V8-37
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cvR5b-0005iN-D3
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:13:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cvR5b-0005hv-3Y
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:13:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v34G9IVw103079
	for <qemu-devel@nongnu.org>; Tue, 4 Apr 2017 12:13:48 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29m259y0ma-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 12:13:48 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 4 Apr 2017 17:13:46 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue,  4 Apr 2017 18:13:28 +0200
Message-Id: <1491322410-24532-1-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/2] 9pfs fixes for 2.9 2017-04-04
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

The following changes since commit 87cc4c61020addea6a001b94b662596b1896d1b3:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-04-04 11:40:55 +0100)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 6d54af0ea9eeee70b4c0eb48bd2ae1d22b207dd4:

  9pfs: clear migration blocker at session reset (2017-04-04 18:06:01 +0200)

----------------------------------------------------------------
Some 9pfs bugs fixes: potential hang at reset, migration blocker leak.

----------------------------------------------------------------
Greg Kurz (2):
      9pfs: fix multiple flush for same request
      9pfs: clear migration blocker at session reset

 hw/9pfs/9p.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)
-- 
2.7.4
