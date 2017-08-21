Received: from eggs.gnu.org ([2001:4830:134:3::10]:54761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1djnPN-0002r0-8o
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1djnPI-0001S2-JT
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:10:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1djnPI-0001Re-DH
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:10:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66D776147F
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 14:10:19 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Mon, 21 Aug 2017 22:10:04 +0800
Message-Id: <20170821141008.19383-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/4] scsi-block: Support werror/rerror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

v4: Handle more sense keys/ascqs. [Paolo]
    Add scsi_sense_buf_to_errno to util/scsi.c. [Paolo]
    Shorten the comment notes on SCSI constants.

v3: Enhance and reuse iscsi sense data translation. [Paolo]

First refactor and enhance the code in iscsi for sense data translation, then
modify error handing of scsi-block and expose the qdev properties.

Fam Zheng (4):
  scsi: Refactor scsi sense interpreting code
  scsi: Improve scsi_sense_to_errno
  scsi: Introduce scsi_sense_buf_to_errno
  scsi-block: Support rerror/werror

 MAINTAINERS         |  2 ++
 block/iscsi.c       | 45 +++------------------------
 hw/scsi/scsi-disk.c | 38 +++++++++++++---------
 include/scsi/scsi.h | 20 ++++++++++++
 util/Makefile.objs  |  1 +
 util/scsi.c         | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 141 insertions(+), 55 deletions(-)
 create mode 100644 include/scsi/scsi.h
 create mode 100644 util/scsi.c

-- 
2.13.5
