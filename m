Received: from eggs.gnu.org ([2001:4830:134:3::10]:47150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cl5Fs-0006WJ-RR
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 21:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cl5Fo-0005TC-3Q
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 21:53:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57335
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1cl5Fn-0005St-T8
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 21:53:36 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v272mj2v057088
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 21:53:34 -0500
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2917d4c1k7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 21:53:33 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Tue, 7 Mar 2017 02:53:32 -0000
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Tue,  7 Mar 2017 03:53:27 +0100
Message-Id: <20170307025328.53409-1-haoqf@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC 0/1] vmstate: fix the failed iotests case
 68 and 91
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, pasic@linux.vnet.ibm.com, liujbjl@linux.vnet.ibm.com, kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com

Hi All,
I am not sure if the fix is correct because I am not very clear about the
logic in vmstate.c. From my test, once size=0, the iotests case 68 failed
due to the assert. So just send this draft patch for your comments!
The patch is based on commit 17783ac828a "Merge remote-tracking branch
'remotes/dgibson/tags/ppc-for-2.9-20170303' into staging".
Thanks!

QingFeng Hao (1):
  vmstate: fix the failure of iotests cases 68 and 91

 migration/vmstate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.8.4
