Received: from eggs.gnu.org ([2001:4830:134:3::10]:51168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cEM8y-0005Y2-Hj
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cEM8v-0000yZ-CQ
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:15:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35033
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cEM8v-0000xk-6l
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:15:13 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB6KDTlQ007760
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 15:15:12 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 275xs6wk09-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 15:15:12 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Dec 2016 15:15:11 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Dec 2016 14:14:58 -0600
Message-Id: <1481055300-14239-1-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.8 0/2] Fixes/tests for hmp_object_del()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, bharata.rao@gmail.com, dgilbert@redhat.com, armbru@redhat.com

I'm tagging this as for-2.8 since there was interest expressed in getting
this fixed with the 2.8 timeframe:

  https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05488.html
  https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00607.html

I should note however that the issue noted in PATCH 1/2 is only visible when
using object_del via HMP, and not with QMP/libvirt. If anyone is willing/able
to pull this soon enough to make 2.8 that would be very much appreciated, but
I know this is quite late and I wouldn't consider this a release blocker.

Changes since v2:

  - Moved QemuOpt cleanup out of {qmp,hmp}_object_del() and into common
    user_creatable_del() path (Daniel, David)
  - Added corresponding test case in check-qom-proplist (Daniel)
