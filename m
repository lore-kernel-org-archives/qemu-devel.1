Received: from eggs.gnu.org ([2001:4830:134:3::10]:51884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eLsVP-00008B-TY
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eLsVK-000468-AZ
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:18:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eLsVK-00045y-03
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:17:58 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB4FGMSL083659
	for <qemu-devel@nongnu.org>; Mon, 4 Dec 2017 10:17:55 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2en7xbk4r5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 10:17:54 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 4 Dec 2017 08:17:53 -0700
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon,  4 Dec 2017 13:17:40 -0200
Message-Id: <20171204151741.14485-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 0/1] savevm/loadvm with postcopy flag
 qemu-iotest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Changes from v3:
- rebased with master - file name changed from 198 to 201
- removed Creator/owner information (it can be retrieved with git)
- added a migration successful check before executing savevm
- removed a trailing double comma in the snapshot name


Daniel Henrique Barboza (1):
  tests/qemu-iotests: adding savevm/loadvm with postcopy flag test

 tests/qemu-iotests/201     | 116 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/201.out |  23 +++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 140 insertions(+)
 create mode 100755 tests/qemu-iotests/201
 create mode 100644 tests/qemu-iotests/201.out

-- 
2.13.6
