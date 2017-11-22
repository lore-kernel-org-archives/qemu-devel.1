Received: from eggs.gnu.org ([2001:4830:134:3::10]:41226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eHVz8-0000iM-2a
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eHVz3-0005GU-Gh
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:26:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eHVz3-0005FX-6j
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:26:37 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAMEP9HT009778
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 09:26:35 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ed9bbpkx0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 09:26:33 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 22 Nov 2017 14:26:31 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 22 Nov 2017 15:26:25 +0100
Message-Id: <20171122142627.73170-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 0/2] s390x fixes (post 2.11)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Christian Borntraeger (2):
  s390x/migration: use zero flag parameter
  pc-bios/s390-ccw: zero out bss section

 pc-bios/s390-ccw/start.S | 30 +++++++++++++++++++++++++++---
 target/s390x/kvm.c       | 16 ++++++++--------
 2 files changed, 35 insertions(+), 11 deletions(-)

-- 
2.9.4
