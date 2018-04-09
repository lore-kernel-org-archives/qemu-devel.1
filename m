Received: from eggs.gnu.org ([2001:4830:134:3::10]:55703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f5V0L-0005ER-0l
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f5V0H-0007SM-Sy
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:30:33 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon,  9 Apr 2018 13:30:17 +0200
Message-Id: <20180409113019.14568-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.12 0/2] s390x/kvm: last minute fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>

Patch 1 only applies to old KVM instances without the virtual memory access
IOCTL in KVM.

Patch 2 could be problematic when toggling PER in a restart interrupt.
Watchpoint recomputation only applies to TCG.

David Hildenbrand (2):
  s390x/mmu: don't overwrite pending exception in mmu translate
  s390x: load_psw() should only exchange the PSW for KVM

 target/s390x/helper.c     | 10 ++++++----
 target/s390x/mmu_helper.c |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.14.3
