Received: from eggs.gnu.org ([2001:4830:134:3::10]:40450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ds7iC-0008Ut-5W
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ds7i9-0006Lf-0v
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:28:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60282
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ds7i8-0006LH-QW
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:28:12 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8DDObYZ087794
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:28:12 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cy2xpgwr2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:28:10 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 13 Sep 2017 14:28:09 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 13 Sep 2017 15:27:50 +0200
Message-Id: <20170913132752.8484-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/2] tests for CCW IDA
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

Because there is not matching (emulated) QEMU device for the Linux
drivers using IDA, testing IDA requires extra effort. 

The last patch of this  series is a QEMU patch which introduces an
emulated CCW device,  which does support IDA. This patch depends on my
IDA work and is intended to be used with the following patch set:
https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg03434.html

The second patch is an out-of-tree Linux kernel module, meant to exercise
the QEMU device introduced by the first patch. The idea is to apply this
patch to an empty git repository.

Both of the patches used to be included in my IDA series, but I've split
them out on maintainer request.

Halil Pasic (1):
  s390x/ccs: add ccw-tester emulated device

 hw/s390x/Makefile.objs |   1 +
 hw/s390x/ccw-tester.c  | 179 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+)
 create mode 100644 hw/s390x/ccw-tester.c

-- 
2.13.5
