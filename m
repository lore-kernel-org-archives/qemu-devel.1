Received: from eggs.gnu.org ([2001:4830:134:3::10]:44371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eZTB3-0004lg-4J
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eZTAy-0002tD-AX
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eZTAy-0002sV-26
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:08 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0B34D1p096754
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:05:06 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fdvfrfc0x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:05:06 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 10 Jan 2018 20:05:05 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu, 11 Jan 2018 04:04:54 +0100
Message-Id: <20180111030459.33757-1-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 0/5] vfio/ccw: basic channel path event
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

Hi Folks,

This is the QEMU couterpart for the "basic channel path event handling" series.
For more information, please refer to the kernel counterpart.

Dong Jia Shi (5):
  vfio: linux-headers update for vfio-ccw
  vfio/ccw: get schib region info
  vfio/ccw: get irq info and set up handler for chp irq
  vfio/ccw: update subchanel information block lazily
  vfio/ccw: build schib with real schib information

 hw/s390x/css.c                 |  97 ++++----------------
 hw/s390x/s390-ccw.c            |  32 +++++--
 hw/vfio/ccw.c                  | 199 ++++++++++++++++++++++++++++++++++-------
 include/hw/s390x/css.h         |   3 +-
 include/hw/s390x/s390-ccw.h    |   4 +-
 linux-headers/linux/vfio.h     |   2 +
 linux-headers/linux/vfio_ccw.h |   6 ++
 target/s390x/ioinst.c          |   3 +-
 8 files changed, 224 insertions(+), 122 deletions(-)

-- 
2.13.5
