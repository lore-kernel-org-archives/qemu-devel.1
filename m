Received: from eggs.gnu.org ([2001:4830:134:3::10]:49060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dufOv-0006Nm-Tw
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dufOs-0004Di-SM
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:50:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41268
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dufOs-0004DM-Fg
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:50:50 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8KDn1nw117744
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 09:50:49 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d3r0pq3qp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 09:50:49 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 20 Sep 2017 14:50:47 +0100
From: Greg Kurz <groug@kaod.org>
Date: Wed, 20 Sep 2017 15:50:35 +0200
Message-Id: <20170920135038.21058-1-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/3] 9pfs fixes for 2.11 20170920
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

The following changes since commit c51700273ad9802a21c19f8d2b4bcb67c38e74ac:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170919-v2' into staging (2017-09-19 18:08:48 +0100)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 772a73692ecb52bace0cff6f95df62f59b8cabe0:

  9pfs: check the size of transport buffer before marshaling (2017-09-20 08:48:52 +0200)

----------------------------------------------------------------
These patches fix regressions in 2.10

----------------------------------------------------------------
Jan Dakinevich (3):
      9pfs: fix readdir() for 9p2000.u
      9pfs: fix name_to_path assertion in v9fs_complete_rename()
      9pfs: check the size of transport buffer before marshaling

 hw/9pfs/9p.c | 60 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)
-- 
2.13.5
