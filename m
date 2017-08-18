Received: from eggs.gnu.org ([2001:4830:134:3::10]:54729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dii3W-00066k-8T
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dii3S-0005jq-9I
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dii3S-0005j8-2i
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E03C4A6EB
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 14:15:17 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 18 Aug 2017 22:15:09 +0800
Message-Id: <20170818141512.15205-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] scsi-block: Support werror/rerror
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

v3: Enhance and reuse iscsi sense data translation. [Paolo]

First refactor and enhance the code in iscsi for sense data translation, then
modify error handing of scsi-block and expose the qdev properties.

Fam Zheng (3):
  scsi: Refactor scsi sense interpreting code
  scsi: Enhance scsi_sense_to_errno
  scsi-block: Support rerror/werror

 MAINTAINERS         |  2 ++
 block/iscsi.c       | 45 ++++----------------------------------------
 hw/scsi/scsi-disk.c | 54 +++++++++++++++++++++++++++++++++++++++--------------
 include/scsi/scsi.h | 19 +++++++++++++++++++
 util/Makefile.objs  |  1 +
 util/scsi.c         | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 117 insertions(+), 55 deletions(-)
 create mode 100644 include/scsi/scsi.h
 create mode 100644 util/scsi.c

-- 
2.13.4
