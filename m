Received: from eggs.gnu.org ([2001:4830:134:3::10]:55180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cWhpw-0007AV-Jq
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cWhpt-0003Er-HM
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:03:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cWhpt-0003EF-7O
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 06:03:25 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0QAwqc6101346
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 06:03:23 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 287b7t9qsm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 06:03:23 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 26 Jan 2017 11:03:20 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu, 26 Jan 2017 12:03:14 +0100
Message-Id: <20170126110315.21759-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 0/1] s390x build fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

The following changes since commit c7f1cf01b8245762ca5864e835d84f6677ae8b1f:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-01-25 17:54:14 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170126

for you to fetch changes up to a87adb6685bed1d4dffc55221197ea86ced48361:

  s390x/flic: fix compilation of kvm flic (2017-01-26 10:33:48 +0100)

----------------------------------------------------------------
One compile fix for s390x with kvm enabled.

----------------------------------------------------------------

Cornelia Huck (1):
  s390x/flic: fix compilation of kvm flic

 hw/intc/s390_flic_kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.11.0
