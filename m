Received: from eggs.gnu.org ([2001:4830:134:3::10]:42598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eboZq-0005l0-65
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eboZj-00051e-Vs
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:20:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eboZj-0004zS-IE
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:20:23 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0HEKBhE093758
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 09:20:20 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fj5xrexu1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 09:20:16 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 17 Jan 2018 14:18:54 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 17 Jan 2018 15:18:46 +0100
Message-Id: <20180117141849.65757-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH/RFC 0/3] s390x/kvm: implement new
 hardware/firmware features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

We want to provide more hw features to guests, namely the new bpb
control as well as other transparent facilities that might be
introduced by firmware updates (e.g. the stfle facility 81).

See the kernel discussion for the KVM side
https://www.spinics.net/lists/kernel/msg2700551.html

Christian Borntraeger (2):
  header sync
  s390x/kvm: Handle bpb feature

Halil Pasic (1):
  s390x/cpumodel: fix transparency for non-hyp STFL features

 linux-headers/asm-s390/kvm.h    |   9 ++--
 linux-headers/linux/kvm.h       |   5 +-
 target/s390x/cpu.c              |   1 +
 target/s390x/cpu.h              |   1 +
 target/s390x/cpu_features.c     |  55 +++++++++++++++++++++
 target/s390x/cpu_features_def.h |  55 +++++++++++++++++++++
 target/s390x/gen-features.c     | 104 ++++++++++++++++++++++++++++++++++++++++
 target/s390x/kvm.c              |  16 +++++++
 target/s390x/machine.c          |  17 +++++++
 9 files changed, 256 insertions(+), 7 deletions(-)

-- 
2.9.4
