Received: from eggs.gnu.org ([2001:4830:134:3::10]:60501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cmCPV-0002VH-Qo
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cmCPR-0001IA-Uh
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:44:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40347
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1cmCPR-0001Hs-OL
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:44:09 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2A4hbb7127312
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 23:44:08 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2938sv0ac7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 23:44:08 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Fri, 10 Mar 2017 04:44:06 -0000
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Fri, 10 Mar 2017 05:44:01 +0100
Message-Id: <20170310044402.38880-1-haoqf@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 0/1] vmstate: fix failed iotests case 68 and
 91
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, pasic@linux.vnet.ibm.com, liujbjl@linux.vnet.ibm.com, kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, dgilbert@redhat.com, quintela@redhat.com

Hi All,
This patch is to fix the failed iotests case 68 and 91 and has been
tested. It's based on commit dd4d2578215 "Merge remote-tracking branch
'remotes/kraxel/tags/pull-fixes-20170309-1' into staging" and according
to Halil and Dave's comments. Also thanks for Fam and Kevin.

QingFeng Hao (1):
  vmstate: fix failed iotests case 68 and 91

 migration/vmstate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
1.8.3.1
