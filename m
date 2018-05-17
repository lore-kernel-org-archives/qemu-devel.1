Received: from eggs.gnu.org ([2001:4830:134:3::10]:43024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fJOV6-0008QC-Bo
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fJOV1-0001I1-CS
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:23:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57442
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.ibm.com>)
	id 1fJOV1-0001Ho-6J
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:23:39 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4HJIsUV008470
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 15:23:38 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j1cjs91r1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 15:23:38 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.ibm.com>;
	Thu, 17 May 2018 13:23:37 -0600
From: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Date: Thu, 17 May 2018 16:23:22 -0300
Message-Id: <20180517192325.8335-1-danielhb@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v7 0/3] wakeup-from-suspend and system_wakeup
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com, dgilbert@redhat.com, Daniel Henrique Barboza <danielhb@linux.ibm.com>

This is the follow-up version of the series:

[PATCH v6 0/2] qmp: 'wakeup-suspend-support' in query-target

With an extra patch that was standalone:

[PATCH v3 1/1] qmp.c: system_wakeup: adding RUN_STATE_SUSPENDED
check before proceeding

Changes from v6 version:
- patch 1:
    * renamed the method to qemu_wakeup_suspend_support;
    * added an extra wing in a comment;
    * changed the documentation of system_wakeup to mention the
new flag 'wakeup-suspend-support'.

- patch 2:
    * shortened the documentation of both guest-suspend-ram and
guest-suspend-hybrid.

- patch 3:
    * added a verification for wakeup-from-suspend in
qmp_system_wakeup with an exclusive error message if the guest
does not have wake-up support;
    * updated system_wakeup documentation to mention that now
we're not silently failing anymore.


Daniel Henrique Barboza (3):
  qmp: adding 'wakeup-suspend-support' in query-target
  qga: update guest-suspend-ram and guest-suspend-hybrid descriptions
  qmp.c: system_wakeup: runstate and wake-up support check

 arch_init.c             |  1 +
 hmp.c                   |  4 +++-
 include/sysemu/sysemu.h |  1 +
 qapi/misc.json          |  9 +++++++--
 qga/qapi-schema.json    | 12 ++++++------
 qmp.c                   | 10 ++++++++++
 vl.c                    | 22 ++++++++++++++++++++++
 7 files changed, 50 insertions(+), 9 deletions(-)

-- 
2.14.3
