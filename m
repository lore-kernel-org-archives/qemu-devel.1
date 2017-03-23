Received: from eggs.gnu.org ([2001:4830:134:3::10]:60739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cqzWy-00011D-Rp
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cqzWt-0001m3-R2
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:59:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52360
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cqzWt-0001ld-Jr
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:59:39 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2N9xOm5053613
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 05:59:37 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29bxj0uj4j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 05:59:37 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 23 Mar 2017 09:59:35 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu, 23 Mar 2017 10:59:28 +0100
Message-Id: <20170323095929.20140-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL for-2.9 0/1] another s390x bugfix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

The following changes since commit 55a19ad8b2d0797e3a8fe90ab99a9bb713824059:

  Update version for v2.9.0-rc1 release (2017-03-21 17:13:29 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170323

for you to fetch changes up to a352aa62a75fcb1db35a0c71a10af3b2c1f8b89f:

  target/s390x: Fix broken user mode (2017-03-23 10:49:13 +0100)

----------------------------------------------------------------
Fix linux-user vs. cpu models.

----------------------------------------------------------------

Stefan Weil (1):
  target/s390x: Fix broken user mode

 target/s390x/cpu_models.c | 2 --
 1 file changed, 2 deletions(-)

-- 
2.11.0
