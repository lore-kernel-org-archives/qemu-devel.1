Received: from eggs.gnu.org ([2001:4830:134:3::10]:59121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1f8StM-000258-0U
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1f8StH-0003Xq-Jf
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:51:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1f8StH-0003X8-B6
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:51:31 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3HFmKCL045263
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 11:51:30 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hdk93a9fx-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 11:51:29 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Tue, 17 Apr 2018 11:51:28 -0400
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 23:51:09 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Message-Id: <16124cce-593c-8191-074c-19164acc3626@linux.vnet.ibm.com>
Subject: [Qemu-devel] Why is there no qom_get in hmp.c?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu block <qemu-block@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Hi all,
I did some investigation and found that "virsh qemu-monitor-command" supports qom-get,
but qemu hmp doesn't. However, in hmp.c there are qom_list and qom_set. It confused me
and my question is: why is this? And how can I get a property's value in hmp? e.g.
qemu-system-* -nodefaults -machine accel=qtest -no-shutdown -nographic -monitor stdio -serial none -hda /root/t.qcow2
"info qtree" can only get a few properties.

Thanks a lot!
-- 
Regards
QingFeng Hao
