Received: from eggs.gnu.org ([2001:4830:134:3::10]:57695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dX9M0-0008Qw-4D
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dX9Lv-0005ES-DJ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:58:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dX9Lv-0005DA-4f
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:58:35 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6HGvbuF146735
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 12:58:33 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2brq7ju5nn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 12:58:32 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 17 Jul 2017 17:58:30 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 17 Jul 2017 18:58:24 +0200
Message-Id: <1500310706-36211-1-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 0/2] 2 more s390 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

as announced in the last pull request here is the pending bugfix for
the linux headers.

In addition lets wire up the newly announced z14 in the CPU model.

Conny, unless you want to handle that, I will send a pull request the next
days.

Christian Borntraeger (1):
  linux header sync against v4.13-rc1

Jason J. Herne (1):
  s390x/cpumodel: z14 cpu models

 linux-headers/asm-x86/kvm_para.h |  1 +
 linux-headers/linux/kvm.h        |  4 +++-
 target/s390x/cpu_models.c        |  1 +
 target/s390x/gen-features.c      | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 1 deletion(-)

-- 
2.7.4
