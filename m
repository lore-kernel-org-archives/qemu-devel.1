Received: from eggs.gnu.org ([2001:4830:134:3::10]:46748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkTT0-0005ee-4F
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkTSv-0005UV-5f
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:09:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51052
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
	id 1fkTSu-0005UF-VK
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:09:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6VC4LpT117862
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 08:09:24 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2kjq5a92bq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 08:09:23 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
	Tue, 31 Jul 2018 13:09:21 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 31 Jul 2018 13:09:06 +0100
Message-Id: <20180731120908.9202-1-frankja@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/2] s390x: Enable KVM huge page backing
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
Cc: borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com

v3:
	* Fixed Cap name
	* Added mempath page size check and error reporting

Janosch Frank (2):
  kvm: sync linux headers
  s390x: Enable KVM huge page backing support

 linux-headers/linux/kvm.h |  1 +
 target/s390x/kvm.c        | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

-- 
2.14.3
