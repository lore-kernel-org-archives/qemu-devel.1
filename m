Received: from eggs.gnu.org ([2001:4830:134:3::10]:48529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1d0vXk-0008JT-Up
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 15:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1d0vXh-0007Kn-T4
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 15:45:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1d0vXh-0007KA-Ks
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 15:45:33 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3JJhlqt084872
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 15:45:30 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29x753dsbp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 15:45:30 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Wed, 19 Apr 2017 16:45:27 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v3JJjOv930998728
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 16:45:24 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v3JJjNva018113
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 16:45:24 -0300
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Wed, 19 Apr 2017 16:44:41 -0300
Message-Id: <1492631083-23965-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/2] VFIO: Make 8-byte accesses atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, pbonzini@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru

This patchset has two patches:
[1] 8-byte writes to non-mapped MMIO are broken into pairs of 4-byte writes, this patch makes such pairs atomic.

[2] Enable 8-byte accesses in vfio_region_write and vfio_region_read.

Patches based on master.

Jose Ricardo Ziviani (2):
  vfio: Set MemoryRegionOps:max_access_size and min_access_size
  vfio: enable 8-byte reads/writes to vfio

 hw/vfio/common.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.7.4
