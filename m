Received: from eggs.gnu.org ([2001:4830:134:3::10]:39817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkr2K-0003cA-8m
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkr2H-0001Rb-GB
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:19:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
	id 1fkr2H-0001Ot-7O
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:19:29 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w71DIqke110489
	for <qemu-devel@nongnu.org>; Wed, 1 Aug 2018 09:19:17 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kkbm3dg8w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 09:19:17 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
	Wed, 1 Aug 2018 14:19:15 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed,  1 Aug 2018 14:19:03 +0100
Message-Id: <20180801131905.148778-1-frankja@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v4 0/2] s390x: Enable KVM huge page backing
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, qemu-s390x@nongnu.org

v4:
	* Now using MiB
	* Now supporting 4k memory backings

v3:
	* Fixed Cap name
	* Added mempath page size check and error reporting

Janosch Frank (2):
  kvm: sync linux headers
  s390x: Enable KVM huge page backing support

 linux-headers/linux/kvm.h |  1 +
 target/s390x/kvm.c        | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

-- 
2.14.3
