Received: from eggs.gnu.org ([2001:4830:134:3::10]:52121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1elF2s-0005Wv-RR
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1elF2q-0003aK-4b
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:25:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1elF2p-0003YT-NS
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:25:23 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1CEOWC9082620
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 09:25:21 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g3abqx518-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 09:25:20 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 12 Feb 2018 07:25:19 -0700
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2018 12:25:05 -0200
Message-Id: <20180212142506.28445-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/1] dump.c: allow fd_write_vmcore to return
 errno on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

v3:
- added set_errg_errno() to all callers of fd_write_vmcore
- changed patch subject to reflect what it is addressing now
- link to previous version:
http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02787.html


Yasmin Beatriz (1):
  dump.c: allow fd_write_vmcore to return errno on failure

 dump.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

-- 
2.14.3
