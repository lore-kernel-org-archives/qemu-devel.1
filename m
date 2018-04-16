Received: from eggs.gnu.org ([2001:4830:134:3::10]:58658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f87Qk-0005BR-3w
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f87Qg-0001Fr-2W
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:56:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1f87Qf-0001FO-RE
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:56:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3GGnsmQ093534
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 12:56:32 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hcxyfje32-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 12:56:32 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Mon, 16 Apr 2018 10:56:31 -0600
From: Collin Walling <walling@linux.ibm.com>
Date: Mon, 16 Apr 2018 12:56:06 -0400
Message-Id: <1523897770-30155-1-git-send-email-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/4] Small fixes for s390x QEMU boot menu
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

Change Log:

    v3

        - added r-b's
        - added check around memset

    v2

        - added r-b's
        - s/zipl_println/zipl_print_entry
            - prints entry and returns entry number
        - while loop now handles valid_entries

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

 hw/s390x/ipl.c              |  4 ++++
 pc-bios/s390-ccw/bootmap.c  | 16 +++++++------
 pc-bios/s390-ccw/bootmap.h  |  2 --
 pc-bios/s390-ccw/main.c     | 14 +++++------
 pc-bios/s390-ccw/menu.c     | 58 +++++++++++++++++++++++++++++++--------------
 pc-bios/s390-ccw/s390-ccw.h |  4 +++-
 6 files changed, 63 insertions(+), 35 deletions(-)

-- 
2.7.4
