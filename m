Received: from eggs.gnu.org ([2001:4830:134:3::10]:58843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGlIc-0001ax-Ik
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGlIZ-0000VT-Fc
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:35:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eGlIZ-0000VE-5f
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:35:39 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAKCWEo9065154
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 07:35:33 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ebx2kv5q7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 07:35:32 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 20 Nov 2017 12:35:30 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 20 Nov 2017 13:35:23 +0100
Message-Id: <20171120123525.147663-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH/RFC 0/2] valgrind fallout for s390x/kvm
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

I need these patches below to run valgrind on s390x/kvm without
a lot of false positives.


Christian Borntraeger (2):
  s390x/migration: use zero flag parameter
  s390x/kvm: use valgrind annotations for kvm device attributes

 hw/s390x/s390-skeys-kvm.c    | 12 ++++++++-
 hw/s390x/s390-stattrib-kvm.c |  7 ++++++
 target/s390x/kvm.c           | 59 ++++++++++++++++++++++++++++++++++++++------
 3 files changed, 69 insertions(+), 9 deletions(-)

-- 
2.9.4
