Received: from eggs.gnu.org ([2001:4830:134:3::10]:55711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eMYPT-0005pr-IX
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eMYPO-0004ys-Jn
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:02:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eMYPO-0004ww-BG
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:02:38 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6C2VEe089081
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 07:02:33 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epfj0jhnb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 07:02:33 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 07:02:32 -0500
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 10:02:14 -0200
Message-Id: <20171206120217.11392-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/3] qmp/hmp: wakeup-from-suspend-support
 command
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

This series introduces a new qmp/hmp command called
query-wakeup-from-suspend-support that retrieves information of
whether the running guest has support to properly wake up from
the SUSPENDED state, allowing management to forbid the
guest-suspend operation if this support isn't available.



Daniel Henrique Barboza (3):
  qmp: introduce query-wakeup-from-suspend-support command
  hmp: introduce wakeup-from-suspend-support command
  qga: update guest-suspend-ram and guest-suspend-hybrid descriptions

 hmp-commands-info.hx    | 15 +++++++++++++++
 hmp.c                   | 11 +++++++++++
 hmp.h                   |  1 +
 include/sysemu/sysemu.h |  1 +
 qapi-schema.json        | 23 +++++++++++++++++++++++
 qga/qapi-schema.json    | 12 ++++++++----
 qmp.c                   |  9 +++++++++
 vl.c                    |  5 +++++
 8 files changed, 73 insertions(+), 4 deletions(-)

-- 
2.13.6
