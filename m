Received: from eggs.gnu.org ([2001:4830:134:3::10]:53079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eheZn-0003sR-NU
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eheYj-0005Rl-JF
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:52:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34252
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eheYj-0005Qx-4T
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:51:29 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w12ETZIc121926
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 09:37:54 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fvrwbb53p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 09:37:52 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 2 Feb 2018 14:37:51 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri,  2 Feb 2018 14:37:45 +0000
Message-Id: <20180202143746.204851-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/1] respin of s390 crash information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

This patch - originally from Jing Liu - was still on my disk and 
somehow dropped of my attention. Here is a fixed up version.
It probably still needs some review and polish.
One open aspect is migration. Right now QEMU switches from crashed
back into running state after migration (even without this patch).
Some fixup will be necessary. 

Christian Borntraeger (1):
  s390x/cpu: expose the guest crash information

 qapi/run-state.json   | 29 ++++++++++++++++++++++++--
 target/s390x/cpu.c    | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/cpu.h    | 10 +++++++++
 target/s390x/helper.c |  5 ++++-
 target/s390x/kvm.c    | 27 +++++++++++++++++++-----
 vl.c                  |  6 ++++++
 6 files changed, 126 insertions(+), 8 deletions(-)

-- 
2.14.3
