Received: from eggs.gnu.org ([2001:4830:134:3::10]:45301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fGZ7v-0000HA-Re
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fGZ7s-0006Ub-JC
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:08:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43136
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fGZ7s-0006U7-CJ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:08:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4A04NBa056293
	for <qemu-devel@nongnu.org>; Wed, 9 May 2018 20:08:03 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hv8d3696m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 20:08:03 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 10 May 2018 01:08:01 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 10 May 2018 02:07:10 +0200
Message-Id: <20180510000712.6472-1-pasic@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 0/2] vfio-ccw: loosen orb flags checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>

See the individual patches. The second one makes even more
sense with the corresponding kernel patch.

Halil Pasic (2):
  vfio-ccw: add force unlimited prefetch property
  vfio-ccw: remove orb.c64 (64 bit data addresses) check

 hw/s390x/css.c | 12 ------------
 hw/vfio/ccw.c  | 13 +++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.16.3
