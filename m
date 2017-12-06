Received: from eggs.gnu.org ([2001:4830:134:3::10]:50970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMawz-0006Xr-3B
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:45:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMaww-0002Hr-1P
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:45:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52822
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eMawv-0002HV-JD
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:45:25 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6Ej6J9013127
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 09:45:23 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2eph2cpgrp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 09:45:21 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:44:43 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 15:44:36 +0100
Message-Id: <20171206144438.28908-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/2] unrestrict cssids related patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

See the commit messages and cover letters of the individual
patches for more details.

v1 -> v2:
* Squashed advertising via property into #1 
* Fixed commit message for #1 
* Dropped machine name in the doc and changed
  how the 'deprecated' warning works
* Added acks and r-b's when appropriate

Halil Pasic (2):
  s390x/css: unrestrict cssids
  s390x: deprecate s390-squash-mcss machine prop

 hw/s390x/3270-ccw.c        |  2 +-
 hw/s390x/css-bridge.c      | 11 +++++++++++
 hw/s390x/css.c             | 28 ++++------------------------
 hw/s390x/s390-ccw.c        |  2 +-
 hw/s390x/s390-virtio-ccw.c |  8 ++++++--
 hw/s390x/virtio-ccw.c      |  2 +-
 include/hw/s390x/css.h     | 12 ++++--------
 qemu-doc.texi              |  8 ++++++++
 qemu-options.hx            |  8 +++++++-
 9 files changed, 43 insertions(+), 38 deletions(-)

-- 
2.13.5
