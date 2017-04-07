Received: from eggs.gnu.org ([2001:4830:134:3::10]:60777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cwRv1-00089h-0r
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cwRux-0004X3-28
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:19:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49948
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cwRuw-0004Wp-S9
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:19:02 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v37BEMbN042406
	for <qemu-devel@nongnu.org>; Fri, 7 Apr 2017 07:19:01 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29p3dcjr3k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 07:19:01 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 7 Apr 2017 12:18:59 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri,  7 Apr 2017 13:18:43 +0200
Message-Id: <20170407111851.20680-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 0/8] s390x: Basic support for 3270
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, marcandre.lureau@redhat.com, Cornelia Huck <cornelia.huck@de.ibm.com>

Next version of the 3270 support patch set, originally sent in
February. Rebased on top of the current s390-next branch.

See http://wiki.qemu-project.org/Features/3270 for some information
on features, limitations and how to set this up.

I'd still like some acks for the first patch.

Changes v1 -> v2:
- qapi: added "since 2.10", removed "#optional"
- adapt to css id introspection patch and busid cleanup

Jing Liu (6):
  chardev: Basic support for TN3270
  s390x/css: Add an algorithm to find a free chpid
  s390x/3270: 3270 data stream handling
  s390x/3270: Add the TCP socket events handler for 3270
  s390x/3270: Detect for continued presence of a 3270 client
  s390x/3270: Mark non-migratable and enable the device

Yang Chen (2):
  s390x/3270: Add abstract emulated ccw-attached 3270 device
  s390x/3270: Add emulated terminal3270 device

 chardev/char-socket.c             |  76 +++++++---
 chardev/char.c                    |  11 +-
 default-configs/s390x-softmmu.mak |   1 +
 hw/char/Makefile.objs             |   1 +
 hw/char/terminal3270.c            | 293 ++++++++++++++++++++++++++++++++++++++
 hw/s390x/3270-ccw.c               | 174 ++++++++++++++++++++++
 hw/s390x/Makefile.objs            |   1 +
 hw/s390x/css.c                    |  24 ++++
 include/hw/s390x/3270-ccw.h       |  53 +++++++
 include/hw/s390x/css.h            |   2 +
 include/sysemu/char.h             |   8 ++
 qapi-schema.json                  |   3 +
 12 files changed, 625 insertions(+), 22 deletions(-)
 create mode 100644 hw/char/terminal3270.c
 create mode 100644 hw/s390x/3270-ccw.c
 create mode 100644 include/hw/s390x/3270-ccw.h

-- 
2.11.0
