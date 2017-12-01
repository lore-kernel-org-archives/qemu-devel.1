Received: from eggs.gnu.org ([2001:4830:134:3::10]:56747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eKncY-00069B-Hy
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eKnbv-0006la-Oi
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:52:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57444
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eKnbv-0006ky-G8
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:52:19 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB1EUn7L112554
	for <qemu-devel@nongnu.org>; Fri, 1 Dec 2017 09:31:52 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ek8wk824s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 09:31:51 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 1 Dec 2017 14:31:48 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  1 Dec 2017 15:31:33 +0100
Message-Id: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/3] unrestrict cssids related patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Hi all!

This serises is a follow up of:
* [RFC PATCH v2 1/1] s390x/css: unrestrict cssids
* [RFC PATCH 1/1] s390x: deprecate s390-squash-mcss

See the commit messages and cover letters of the individual
patches for more details.

Halil Pasic (3):
  s390x/css: unrestrict cssids
  s390x/css: advertise unrestricted cssids
  s390x: deprecate s390-squash-mcss machine prop

 hw/s390x/3270-ccw.c        |  2 +-
 hw/s390x/css-bridge.c      | 11 +++++++++++
 hw/s390x/css.c             | 28 ++++------------------------
 hw/s390x/s390-ccw.c        |  2 +-
 hw/s390x/s390-virtio-ccw.c |  7 +++++--
 hw/s390x/virtio-ccw.c      |  2 +-
 include/hw/s390x/css.h     | 12 ++++--------
 qemu-doc.texi              |  8 ++++++++
 qemu-options.hx            |  8 +++++++-
 9 files changed, 42 insertions(+), 38 deletions(-)

-- 
2.13.5
