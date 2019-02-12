Received: from eggs.gnu.org ([209.51.188.92]:38956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gtfoV-0000sB-Nf
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gtfdK-00047O-Uh
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:30:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gtfdI-00043K-TY
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:30:26 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CLSeu7079324
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 16:30:21 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qm35by4v6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 16:30:21 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 12 Feb 2019 21:30:20 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
	[9.57.199.108])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x1CLUHxB16580860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 21:30:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5554DB206B
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 21:30:17 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38A22B2065
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 21:30:17 +0000 (GMT)
Received: from localhost (unknown [9.53.179.197])
	by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 21:30:17 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 12 Feb 2019 15:29:15 -0600
Message-Id: <20190212212917.26977-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/2] qga-win: fixes for builds with
 VSS/fsfreeze enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

These fix a couple build regressions that have slipped in over that past
couple months and hopefully will help avoid future breakages.

 qga/vss-win32/Makefile.objs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
