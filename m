Received: from eggs.gnu.org ([2001:4830:134:3::10]:44125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dqL9f-0000oT-VE
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dqL9b-0004xa-1I
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:25:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42958
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dqL9a-0004x1-R3
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:25:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v88FOVON022484
	for <qemu-devel@nongnu.org>; Fri, 8 Sep 2017 11:25:10 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2curs77yta-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 11:25:09 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 8 Sep 2017 16:24:53 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  8 Sep 2017 17:24:42 +0200
Message-Id: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/4] s390x/css: ccw interpretation fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Here come some bug fixes concerning CCW interpretation.

Patch #1 was already posted as a stand alone patch, is (kind of)
required by patch #4 so it's included in this series too. 

Halil Pasic (4):
  s390x/css: drop data-check in interpretation
  s390x/css: fix NULL handling for CCW addresses
  s390x/css: remove dubious error handling branch
  s390x/css: fix incorrect length indication

 hw/s390x/3270-ccw.c    |  24 +++++-----
 hw/s390x/css.c         |  79 ++++++++++++++----------------
 hw/s390x/virtio-ccw.c  | 128 ++++++++++++++++++++++++-------------------------
 include/hw/s390x/css.h |  13 ++++-
 4 files changed, 125 insertions(+), 119 deletions(-)

-- 
2.13.5
