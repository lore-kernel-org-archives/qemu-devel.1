Received: from eggs.gnu.org ([2001:4830:134:3::10]:60407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dv3C5-0004tb-8P
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dv3Bz-0006Hh-GG
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:15:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dv3Bz-0006GF-6R
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:15:07 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8LFExIZ128106
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 11:14:59 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d4fnu8s1g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 11:14:52 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 21 Sep 2017 16:14:49 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 21 Sep 2017 17:14:45 +0200
Message-Id: <20170921151446.40015-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 0/1] 2.10-stable only: disable ais facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

now with qemu-devel on cc..

Cornelia, David and myself had a lengthy discussion about
ais migration and its issues. As the solution turns out to
be more complex, we will disable the ais facility in 2.10
and fix the issue properly in 2.11.

Christian Borntraeger (1):
  s390x/ais: for 2.10 stable: disable ais facility

 target/s390x/kvm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.9.4
