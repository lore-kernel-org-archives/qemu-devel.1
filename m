Received: from eggs.gnu.org ([2001:4830:134:3::10]:59818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1enmC0-00065x-Bo
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 09:13:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1enmBx-0003Z0-6C
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 09:13:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1enmBw-0003Xj-Si
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 09:13:17 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JECSJ9139799
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 09:13:14 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g7yp21fw6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 09:13:13 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 07:13:11 -0700
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 11:12:57 -0300
Message-Id: <20180219141259.26526-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 0/2] qmp: 'wakeup-suspend-support' in
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
Cc: armbru@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

v5:
- removed a paragraph in the recently added qemu_register_wakeup_notifier
comment that was added. That paragraph was adding too much in-depth
information about the current design of the system_wakeup, making it
harder to understand the whole point (suggested by Mike Roth).
- previous version link:
https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg00879.html 

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
 vl.c                    | 21 +++++++++++++++++++++
 5 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.14.3
