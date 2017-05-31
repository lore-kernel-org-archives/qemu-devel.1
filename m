Received: from eggs.gnu.org ([2001:4830:134:3::10]:37336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dG9OJ-0002NE-H7
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dG9OF-0003Mz-K3
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:34:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dG9OF-0003Ls-EU
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:34:43 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 31 May 2017 21:34:32 +0200
Message-Id: <20170531193434.6918-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/2] s390x cpu model improvements for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, david@redhat.com

We should properly forward the CPUID format bit. CPU model
detection on systems without IBC might select a model with a wrong
CPU type (esp. selecting the business class (BC) model on an enterprise
class (EC) machine). So let's improve that, too.

I am also preparing a patch to properly indicate the correct cpu type
to the guest via STORE CPU ID and STORE HYPERVISOR INFORMATION for the
TCG case, but will send that separately after I tested it (want to write a
kvm-unit-test for STORE CPU ID).

David Hildenbrand (2):
  s390x/cpumodel: take care of the cpuid format bit for KVM
  s390x/cpumodel: improve defintion search without an IBC

 target/s390x/cpu_models.c | 10 ++++++++++
 target/s390x/cpu_models.h | 10 +++++++---
 target/s390x/kvm.c        |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.9.3
