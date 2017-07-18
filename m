Received: from eggs.gnu.org ([2001:4830:134:3::10]:39637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dXHdp-0002wI-RI
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dXHdm-00047P-Pj
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:49:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56158
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dXHdm-00046S-JP
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:49:34 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6I1nOb4019180
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:49:33 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bs4j9sgnq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:49:33 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 17 Jul 2017 21:49:32 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Tue, 18 Jul 2017 03:49:24 +0200
Message-Id: <20170718014926.44781-1-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/2] vfio-ccw bugfixs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com

Dear Conny,

Here we got two bugfix patches for vfio-ccw:
- fix commit 7da624e2 which missed to initialize a new introduced
  pointer for the vfio-ccw case
- fix a memory allocation that used a wrong size for an irq info
  variable

Dong Jia Shi (1):
  vfio/ccw: fix initialization of the Object DeviceState pointer in the
    common base-device

Jing Zhang (1):
  vfio/ccw: allocate irq info with the right size

 hw/vfio/ccw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.11.2
