Received: from eggs.gnu.org ([209.51.188.92]:48419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1gm16M-0005jZ-BQ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1gm16I-0006Ow-65
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:48:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1gm16F-0006A2-SA
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:48:41 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0MF5AOB047823
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:06:08 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q658q8ucs-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:06:08 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Tue, 22 Jan 2019 15:06:06 -0000
From: bala24@linux.vnet.ibm.com
Date: Tue, 22 Jan 2019 20:35:42 +0530
Message-Id: <20190122150543.16889-1-bala24@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/1] migration: calculate expected_downtime
 considering redirtied ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, dgilbert@redhat.com, peterx@redhat.com, Balamuruhan S <bala24@linux.vnet.ibm.com>

From: Balamuruhan S <bala24@linux.vnet.ibm.com>

Based on the discussion with Dave and David Gibson earlier with respect
to expected_downtime calculation, 

https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg02418.html

got suggestions that the calculation is of not accurate and we need to
consider the ram that gets redirtied during the time when we would have
actually transferred ram in the current iteration.

so I have came up with a calculation by considering the ram that could
get redirtied during the current iteration at the time we would have
transferred the remaining ram in current iteration. By this way,
the total ram to be transferred will be remaining ram + redirtied ram
and dividing with bandwidth would yield us better expected_downtime
value.

Please help to review and suggest about this approach.

Balamuruhan S (1):
  migration: calculate expected_downtime considering redirtied ram

 migration/migration.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.14.5
