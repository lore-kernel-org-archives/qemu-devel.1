Received: from eggs.gnu.org ([2001:4830:134:3::10]:59794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fLuVm-00070m-Oe
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fLuVh-0006at-Oc
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:58:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fLuVh-0006aE-FK
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:58:45 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4OHrxjY002988
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 13:58:44 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j5yq5fr6u-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 13:58:43 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 24 May 2018 18:58:41 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 24 May 2018 19:58:26 +0200
Message-Id: <20180524175828.3143-1-pasic@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/2] vfio-ccw: loosen orb flags checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

See the individual patches (inclusive change log).

Halil Pasic (2):
  vfio-ccw: add force unlimited prefetch property
  vfio-ccw: remove orb.c64 (64 bit data addresses) check

 hw/s390x/css.c | 12 ------------
 hw/vfio/ccw.c  | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 12 deletions(-)

-- 
2.16.3
