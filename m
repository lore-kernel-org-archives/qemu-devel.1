Received: from eggs.gnu.org ([2001:4830:134:3::10]:32898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f5umF-00013v-6g
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f5um9-0000Lx-Mn
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:01:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59018
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1f5um9-0000LR-Hg
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:01:37 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3AF1aZ8063125
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 11:01:36 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h8w118cmk-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 11:01:36 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 10 Apr 2018 09:01:32 -0600
From: Collin Walling <walling@linux.ibm.com>
Date: Tue, 10 Apr 2018 11:01:22 -0400
Message-Id: <1523372486-13190-1-git-send-email-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 0/4] Small fixes for s390x QEMU boot menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com, borntraeger@de.ibm.com
Cc: gor@linux.ibm.com, frankja@linux.ibm.com

These patches fix the following:

    - The QEMU zIPL boot menu does not allow accurate selection of
        non-sequential entries.

    - The QEMU zIPL boot menu does not have all the capabilities of the
        real zIPL menu (such as commandline args). We should print a different
        banner to reflect this.

    - The loadparm array in main.c can end up being not null terminated when
        converted to an integer via atoui.

    - A loadparm set to an empty string does not allow a boot menu.

Collin Walling (4):
  pc-bios/s390-ccw: rename MAX_TABLE_ENTRIES to MAX_BOOT_ENTRIES
  pc-bios/s390-ccw: fix loadparm initialization and int conversion
  pc-bios/s390-ccw: fix non-sequential boot entries (eckd)
  pc-bios/s390-ccw: fix non-sequential boot entries (enum)

 hw/s390x/ipl.c              |  2 ++
 pc-bios/s390-ccw/bootmap.c  | 16 ++++++------
 pc-bios/s390-ccw/bootmap.h  |  2 --
 pc-bios/s390-ccw/main.c     | 14 +++++------
 pc-bios/s390-ccw/menu.c     | 61 +++++++++++++++++++++++++++++----------------
 pc-bios/s390-ccw/s390-ccw.h |  4 ++-
 6 files changed, 61 insertions(+), 38 deletions(-)

-- 
2.7.4
