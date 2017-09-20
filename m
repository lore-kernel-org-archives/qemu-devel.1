Received: from eggs.gnu.org ([2001:4830:134:3::10]:51573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duiis-000541-3X
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duiim-0005w0-0T
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:23:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1duiil-0005uA-OG
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:23:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8KHM7Ai042761
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 13:23:32 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3s8mxf5d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 13:23:32 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 20 Sep 2017 18:23:29 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 20 Sep 2017 19:23:12 +0200
Message-Id: <20170920172314.102710-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/2] 3270 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Jason found some problems with 3270 which he traced down to insufficient
output buffer size. I've looked into the underlying issue (and the
relevant code) and I saw strange things. Among others an unreasonable
assert requiring the payload of a ccw being less than some more or
less arbitrary limit (dictated by the size of the output buffer).

Because we were already considering converting 3270 to CcwDataStream I've
decided to try do get rid of this strange limitation on the length of the
writes too. 

This series depends on my IDA work, which can be found here:
https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg03434.html.

Halil Pasic (2):
  s390x/3270: IDA support for 3270 via CcwDataStream
  s390x/3270: handle writes of arbitrary length

 hw/char/terminal3270.c      | 46 +++++++++++++++++++++++++++------------------
 hw/s390x/3270-ccw.c         |  4 ++--
 include/hw/s390x/3270-ccw.h |  5 ++---
 3 files changed, 32 insertions(+), 23 deletions(-)

-- 
2.13.5
