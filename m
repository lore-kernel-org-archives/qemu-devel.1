Received: from eggs.gnu.org ([2001:4830:134:3::10]:47614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cW2i8-0001un-Ur
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:08:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cW2hz-0002oT-Cj
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:08:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38362
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cW2hz-0002na-61
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:08:31 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0OEoe94122494
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:08:30 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2867gm6akb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:08:30 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 24 Jan 2017 15:08:28 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 24 Jan 2017 16:08:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20170124150823.30162-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 0/2] s390x fixes
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

The following changes since commit 48cef39bf39846ce4aaf79d4a2ae620373b3e181:

  Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20170123' into staging (2017-01-24 09:52:42 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170124

for you to fetch changes up to 0cf4d747cb8d053e6a6161aadfd3531fa1a62be1:

  s390x/kvm: fix cmma reset for KVM (2017-01-24 15:47:31 +0100)

----------------------------------------------------------------
Two s390x fixes: One for the kvm.c build failure, and one for a bug
that might cause random guest crashes with zeroed out pages on host
kernels with working cmma (< 4.6 and likely >= 4.10).

----------------------------------------------------------------

Christian Borntraeger (1):
  s390x/kvm: fix cmma reset for KVM

Cornelia Huck (1):
  s390x/kvm: include hw_accel.h instead of kvm.h

 target/s390x/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.11.0
