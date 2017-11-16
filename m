Received: from eggs.gnu.org ([2001:4830:134:3::10]:48358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eFNbZ-0001xk-Ps
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:05:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eFNbW-000163-GW
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:05:33 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 16 Nov 2017 18:05:23 +0100
Message-Id: <20171116170526.12643-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.11 0/3] s390x: fixes for SIGP and DIAG
 308
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

First one also applies to KVM SIGP handling. The other two only
apply to TCG (allowing to IPL from disk with more than 1 VCPU- I
never tested that before).

David Hildenbrand (3):
  s390x: fix storing CPU status (again)
  s390x/tcg: fix DIAG 308 with > 1 VCPU (single threaded TCG)
  s390x/tcg: fix DIAG 308 with > 1 VCPU (MTTCG)

 target/s390x/diag.c        | 4 ----
 target/s390x/helper.c      | 2 +-
 target/s390x/misc_helper.c | 2 ++
 3 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.13.6
