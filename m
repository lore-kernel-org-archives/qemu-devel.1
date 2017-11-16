Received: from eggs.gnu.org ([2001:4830:134:3::10]:40642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eFSlR-0006OE-O9
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 17:36:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eFSlM-0003h0-HO
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 17:36:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38286
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eFSlM-0003gX-BM
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 17:36:00 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAGMXVPu106345
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 17:35:52 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e9ermf8rb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 17:35:52 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 16 Nov 2017 17:35:51 -0500
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2017 20:35:25 -0200
Message-Id: <20171116223527.4499-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/2] Fix savevm/loadvm after postcopy
 migration
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

v3:
- patch 1: added 'Reported-by' info in the commit msg. No code
changes were made.
- patch 2 *new*: a new qemu-iotest that verifies the behavior
fixed in patch1.

v2:
- added helper functions to simplify the code

Daniel Henrique Barboza (2):
  migration/ram.c: do not set 'postcopy_running' in
    POSTCOPY_INCOMING_END
  tests/qemu-iotests: adding savevm/loadvm with postcopy flag test

 migration/ram.c            |  16 ++++++-
 tests/qemu-iotests/198     | 110 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/198.out |  20 +++++++++
 tests/qemu-iotests/group   |   1 +
 4 files changed, 145 insertions(+), 2 deletions(-)
 create mode 100755 tests/qemu-iotests/198
 create mode 100644 tests/qemu-iotests/198.out

-- 
2.13.6
