Received: from eggs.gnu.org ([2001:4830:134:3::10]:60034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6EIx-0006qj-Rr
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6EIu-0005tU-Mi
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33584
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d6EIu-0005tE-GO
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:12 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v44Ai9Co108637
	for <qemu-devel@nongnu.org>; Thu, 4 May 2017 06:48:11 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a7u1aum93-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 06:48:11 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 4 May 2017 11:48:09 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu,  4 May 2017 12:47:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20170504104806.8120-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 0/8] s390x: basic 3270 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

[This should not conflict with the outstanding s390x pull request
which deals with LOADPARM and booting.]

The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d60:

  Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into staging (2017-05-02 15:16:29 +0100)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-3270-20170504

for you to fetch changes up to 9e8b3009b7dbe4c2f3e407999e30813122fa4af9:

  s390x/3270: Mark non-migratable and enable the device (2017-05-04 10:34:37 +0200)

----------------------------------------------------------------
Basic support for using channel-attached 3270 'green-screen'
devices via tn3270. Actual handling of the data stream is
delegated to x3270; more info at http://wiki.qemu.org/Features/3270

----------------------------------------------------------------

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
