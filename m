Received: from eggs.gnu.org ([2001:4830:134:3::10]:51455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dIHlT-0001W1-M7
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dIHlP-0006Mn-Oc
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:55:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dIHlP-0006Ma-Eg
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:55:27 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56Gs7me017016
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 12:55:24 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2awv2s01kg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 12:55:24 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 6 Jun 2017 17:55:21 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue,  6 Jun 2017 18:55:07 +0200
Message-Id: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 0/3] vmstate: error hint for failed equal
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

The goal is to be able to specify a hint for the case
a vmstate equal assertion fails. Was previously discussed
here:
https://patchwork.kernel.org/patch/9720029/

The third patch is an usage example. It's on top of this
https://www.mail-archive.com/qemu-devel@nongnu.org/msg454941.html 
patch and mimics the behavior of the patch reference above.

I have faked the subject of this third patch so patchew
does not complain about that not applying on top of master
(let's see if that works).

Halil Pasic (3):
  vmstate: error hint for failed equal checks
  vmstate: error hint for failed equal checks part 2
  s390x/css: add hint for devno missmatch

 hw/s390x/css.c              |  6 ++++-
 include/migration/vmstate.h | 55 ++++++++++++++++++++++++++++++++++++++++-----
 migration/vmstate-types.c   | 36 ++++++++++++++++++++++++-----
 3 files changed, 85 insertions(+), 12 deletions(-)

-- 
2.11.2
