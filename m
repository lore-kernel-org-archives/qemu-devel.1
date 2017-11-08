Received: from eggs.gnu.org ([2001:4830:134:3::10]:55202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eCTcx-0003Vo-Kt
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eCTct-0000Sg-2u
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:54:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54132
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eCTcs-0000SD-Sy
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:54:54 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA8GqlAh063222
	for <qemu-devel@nongnu.org>; Wed, 8 Nov 2017 11:54:50 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e45pt8j7a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 11:54:48 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 8 Nov 2017 16:54:46 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed,  8 Nov 2017 17:54:19 +0100
Message-Id: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 0/3] tests for CCW IDA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

I've keept the title althogh the scope shifted a bit: it's
more about introducing ccw-testdev than about IDA. The goal
is to facilitate testing the virtual channel subsystem
implementation, and the ccw interpretation.

The first patch is the interesting one. See it's cover letter
for details. The RFC is about discussing some technical issues
with this patch.

The other two patches are an out of source kernel module which
is basically only there so you can try out the first patch. The
tests there should probably be ported to something else. I don't
know what: maybe kvm-unit-tests, maybe qtest+libqos, or maybe some
bios based test image. We still have to figure out that. 

Halil Pasic (3):
  s390x/ccs: add ccw-testdev emulated device
  ccw-tester: a tester device for ccw I/O
  ccw-tester: add tic test

 hw/misc/Makefile.objs |   1 +
 hw/misc/ccw-testdev.c | 284 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/misc/ccw-testdev.h |  18 ++++
 3 files changed, 303 insertions(+)
 create mode 100644 hw/misc/ccw-testdev.c
 create mode 100644 hw/misc/ccw-testdev.h

-- 
2.13.5
