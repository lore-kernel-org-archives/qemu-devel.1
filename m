Received: from eggs.gnu.org ([2001:4830:134:3::10]:41792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fLFbQ-0007nx-Ji
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fLFbH-0002sz-Cq
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:17:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50910
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fLFbH-0002sE-7a
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:17:47 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4MMF1a1008886
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 18:17:45 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2j4ueurwpb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 18:17:45 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 22 May 2018 23:17:43 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 23 May 2018 00:16:53 +0200
Message-Id: <20180522221655.78979-1-pasic@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/2] vfio-ccw: loosen orb flags checks
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
 hw/vfio/ccw.c  | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 12 deletions(-)

-- 
2.16.3
