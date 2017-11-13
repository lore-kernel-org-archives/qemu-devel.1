Received: from eggs.gnu.org ([2001:4830:134:3::10]:53435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eEJa6-0006QQ-Dj
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 13:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eEJa2-0001qu-F7
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 13:35:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34426
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eEJa2-0001qQ-9S
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 13:35:34 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vADIYo7O099954
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 13:35:28 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e7e3p25vj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 13:35:27 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 13 Nov 2017 11:35:27 -0700
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2017 16:35:16 -0200
Message-Id: <20171113183517.890-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/1] Fix savevm/loadvm after postcopy
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
Cc: mdroth@linux.vnet.ibm.com, dgilbert@redhat.com, quintela@redhat.com, peterx@redhat.com

v2:
- added helper functions to simplify the code

Daniel Henrique Barboza (1):
  migration/ram.c: do not set 'postcopy_running' in
    POSTCOPY_INCOMING_END

 migration/ram.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.13.6
