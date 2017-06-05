Received: from eggs.gnu.org ([2001:4830:134:3::10]:46594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dHpZd-0004fn-6s
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dHpZY-0006LN-Dz
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:49:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dHpZY-0006If-5f
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:49:20 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v55AmcWY044531
	for <qemu-devel@nongnu.org>; Mon, 5 Jun 2017 06:49:18 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aw3p455kj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 06:49:17 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Mon, 5 Jun 2017 11:49:15 +0100
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Mon,  5 Jun 2017 12:48:50 +0200
Message-Id: <20170605104851.61818-1-haoqf@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 0/1] qemu/migration: fix the migration bug
 found by qemu-iotests case 068
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: peterx@redhat.com, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, liujbjl@linux.vnet.ibm.com, kwolf@redhat.com, famz@redhat.com, QingFeng Hao <haoqf@linux.vnet.ibm.com>

Hi all,
This patch is to fix the migration bug found by qemu-iotests case 068
and based on upstream master's commit:
cb8b8ef4578:  Merge remote-tracking branch 'remotes/elmarco/tags/chrfe-pull-request' into staging.
The bug was introduced by commit "660819b migration: shut src return path unconditionally".
Thanks!

QingFeng Hao (1):
  qemu/migration: fix the double free problem on from_src_file

 migration/savevm.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.11.2
