Received: from eggs.gnu.org ([2001:4830:134:3::10]:41132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eC85f-0004Vk-KL
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:55:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eC85b-0003iy-L9
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:55:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eC85b-0003iD-At
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:55:07 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA7HsGVg088072
	for <qemu-devel@nongnu.org>; Tue, 7 Nov 2017 12:55:06 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e3dn36kn1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 12:55:05 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 7 Nov 2017 17:55:02 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue,  7 Nov 2017 18:54:54 +0100
Message-Id: <20171107175455.73793-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 0/1] s390/pci more enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

This patch puts PCI device in the configured state by default, which is the
only sane default for KVM guests.

Christian Borntraeger (1):
  s390x/pci: let pci devices start in configured mode

 hw/s390x/s390-pci-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.9.4
