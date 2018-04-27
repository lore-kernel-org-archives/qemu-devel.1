Received: from eggs.gnu.org ([2001:4830:134:3::10]:43121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fC0DS-00068Z-FZ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fC0DP-00051g-Bn
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:02:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fC0DP-00051Y-2w
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:02:55 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3R9xtlF128613
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 06:02:52 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hm1hb8q36-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 06:02:52 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Fri, 27 Apr 2018 04:02:51 -0600
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Fri, 27 Apr 2018 18:02:43 +0800
Message-Id: <20180427100244.14258-1-zyimin@linux.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 0/1] s390x/pci: add common fmb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, zyimin@linux.ibm.com

Currently the code misses FMB functionality. This patch fixup this. Only common
FMB is supported now.

bb/zyimin/fmb

Yi Min Zhao (1):
  s390x/pci: add common fmb

 hw/s390x/s390-pci-bus.c  |  3 ++-
 hw/s390x/s390-pci-bus.h  | 16 +++++++++++++
 hw/s390x/s390-pci-inst.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++-
 hw/s390x/s390-pci-inst.h |  1 +
 4 files changed, 78 insertions(+), 2 deletions(-)

-- 
2.15.1 (Apple Git-101)
