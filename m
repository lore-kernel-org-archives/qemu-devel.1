Received: from eggs.gnu.org ([2001:4830:134:3::10]:33942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgsCs-0003QR-Pm
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgsCn-0000F1-8o
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:09:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cgsCn-0000Eu-0k
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:09:05 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NC92Bw075255
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:09:03 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28sku91k6b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:09:03 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 23 Feb 2017 12:08:31 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu, 23 Feb 2017 13:08:26 +0100
Message-Id: <20170223120827.8942-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 0/1] s390x: one additional bugfix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Cornelia Huck <cornelia.huck@de.ibm.com>

One additional bugfix in the css code. I plan to send a pullreq
tomorrow.

Dong Jia Shi (1):
  s390x/css: handle format-0 TIC CCW correctly

 hw/s390x/css.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.11.0
