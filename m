Received: from eggs.gnu.org ([2001:4830:134:3::10]:40676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxZ8r-0006gz-Q5
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxZ8o-0002C8-2i
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxZ8n-0002Bv-T8
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:14 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 15:46:04 +0200
Message-Id: <20170928134609.16985-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/5] s390x: CPU related cleanups and one fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>

Patch 2-5 are split out from the series "[PATCH v1 00/27] s390x: SMP for
TCG (+ cleanups)"

They make sense even without the SMP TCG changes, which could still take
a while.

David Hildenbrand (5):
  MAINTAINERS: use KVM s390x maintainers for kvm-stubs.c and kvm_s390x.h
  s390x: raise CPU hotplug irq after really hotplugged
  s390x/cpumodel: fix max STFL(E) bit number
  target/s390x: get rid of next_core_id
  s390x: introduce and use S390_MAX_CPUS

 MAINTAINERS                 |  2 ++
 hw/s390x/s390-virtio-ccw.c  |  6 +++++-
 target/s390x/cpu-qom.h      |  2 --
 target/s390x/cpu.c          | 22 +++++++---------------
 target/s390x/cpu.h          |  4 ++++
 target/s390x/cpu_features.c |  2 +-
 target/s390x/cpu_models.c   |  2 ++
 7 files changed, 21 insertions(+), 19 deletions(-)

-- 
2.13.5
