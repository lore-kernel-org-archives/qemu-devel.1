Received: from eggs.gnu.org ([2001:4830:134:3::10]:34513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1da8ZV-0002Yj-J2
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 18:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1da8ZS-0003Vi-Hc
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 18:44:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48612
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1da8ZS-0003Sl-BS
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 18:44:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6PMhgcG014057
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 18:44:51 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bxbbc9vk5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 18:44:51 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 25 Jul 2017 23:44:49 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 00:44:40 +0200
Message-Id: <20170725224442.13383-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/2] ccw interpretation AR compliance
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

There were some missing checks. There might be some more missing.  For details,
see the individual patches.

Regarding testing: did not do much more than a simple smoke test
with virtio-ccw.

Halil Pasic (2):
  s390x/css: check ccw address validity
  s390x/css: fix bits must be zero check for TIC

 hw/s390x/css.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

-- 
2.11.2
