Received: from eggs.gnu.org ([209.51.188.92]:40545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ghZwj-0003Vd-Jz
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:00:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ghZwe-0007vi-1M
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:00:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34760
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1ghZwc-0007qs-0u
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:00:22 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0ACxZVf175788
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 08:00:15 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2px3uequt5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 08:00:15 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 10 Jan 2019 13:00:13 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 10 Jan 2019 14:00:06 +0100
Message-Id: <1547125207-16907-1-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2] s390x/pci: Set the iommu region size as
 guest wants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: walling@linux.ibm.com
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

Changed the subject (kept only in cover letter)

Changed the commit message to specify that the PAL/PBA values are
given by the guest through the mpcifc call.

Pierre Morel (1):
  s390x/pci: Set the iommu region size mpcifc request

 hw/s390x/s390-pci-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4
