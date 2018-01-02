Received: from eggs.gnu.org ([2001:4830:134:3::10]:33435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eWQ4Z-00013D-Tv
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eWQ4V-0002dv-L1
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:09:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33462
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eWQ4V-0002dX-EN
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:09:51 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w02H9OgR033131
	for <qemu-devel@nongnu.org>; Tue, 2 Jan 2018 12:09:50 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2f8csnumjc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 12:09:50 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 2 Jan 2018 12:09:50 -0500
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue,  2 Jan 2018 15:09:34 -0200
Message-Id: <20180102170936.6150-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATH v2 0/2] qmp: 'wakeup-suspend-support' in
 query-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, dgilbert@redhat.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

v2:
- changed the approach based on v1 discussions: instead of a new API, add
the required flag in QMP query-target
- dropped patch 2 since query-target does not have an HMP counterpart
- previous version link:
https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00889.html


Daniel Henrique Barboza (2):
  qmp: adding 'wakeup-suspend-support' in query-target
  qga: update guest-suspend-ram and guest-suspend-hybrid descriptions

 arch_init.c             |  1 +
 include/sysemu/sysemu.h |  1 +
 qapi-schema.json        |  3 ++-
 qga/qapi-schema.json    | 14 ++++++++++----
 vl.c                    |  5 +++++
 5 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.13.6
