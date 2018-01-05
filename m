Received: from eggs.gnu.org ([2001:4830:134:3::10]:34734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eXRep-0000ns-Bx
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:03:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eXRel-0004ru-6J
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:03:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eXRek-0004qu-TY
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:03:31 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w05D2M7O070712
	for <qemu-devel@nongnu.org>; Fri, 5 Jan 2018 08:03:29 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fa7xjn3cy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 08:03:29 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 5 Jan 2018 08:03:27 -0500
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri,  5 Jan 2018 11:03:12 -0200
Message-Id: <20180105130314.26026-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 0/2] qmp: 'wakeup-suspend-support' in
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
Cc: armbru@redhat.com, eblake@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

v4:
- added a comment in 'qemu_register_wakeup_notifier' about the effects
of adding a wakeup notifier without proper suspend/wakeup support in the
logic of the new wakeup-suspend-support flag, as suggested by Mike Roth
- previous version link:
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg00358.html

v3:
- added a "(since 2.12)" notation in the new flag, as suggested by
Eric Blake
- added a "backwards compatible" note in the commit msg
- previous version link:
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg00093.html

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
 qapi-schema.json        |  4 +++-
 qga/qapi-schema.json    | 14 ++++++++++----
 vl.c                    | 29 +++++++++++++++++++++++++++++
 5 files changed, 44 insertions(+), 5 deletions(-)

-- 
2.13.6
