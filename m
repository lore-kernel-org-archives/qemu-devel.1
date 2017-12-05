Received: from eggs.gnu.org ([2001:4830:134:3::10]:47618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eMDNe-0002U9-Ij
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eMDNZ-0001VP-MM
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:35:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eMDNZ-0001Ul-Bu
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:35:21 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB5DXrWU050490
	for <qemu-devel@nongnu.org>; Tue, 5 Dec 2017 08:35:18 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2enrg74nm0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 08:35:18 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 5 Dec 2017 08:35:17 -0500
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue,  5 Dec 2017 11:35:07 -0200
Message-Id: <20171205133508.15061-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 0/1] savevm/loadvm with postcopy flag
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

Changes from v4:
- added a 'refcount_bits=1' constraint for internal snapshots

Changes from v3:
- rebased with master - file name changed from 198 to 201
- removed Creator/owner information (it can be retrieved with git)
- added a migration successful check before executing savevm
- removed a trailing double comma in the snapshot name

Daniel Henrique Barboza (1):
  tests/qemu-iotests: adding savevm/loadvm with postcopy flag test

 tests/qemu-iotests/201     | 120 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/201.out |  23 +++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 144 insertions(+)
 create mode 100755 tests/qemu-iotests/201
 create mode 100644 tests/qemu-iotests/201.out

-- 
2.13.6
