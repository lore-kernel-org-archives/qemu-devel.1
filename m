Received: from eggs.gnu.org ([2001:4830:134:3::10]:55039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYVFo-00023p-IP
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYVFk-0008Fz-Ik
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:38:24 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Jun 2018 13:38:15 +0200
Message-Id: <20180628113817.30814-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/2] s390x/kvm: legacy_s390_alloc() fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

Two patches for legacy_s390_alloc(), only relevant under old z/VM versions.

Patch #1 is relevant when trying to allocate memory for more than one
memory region. Patch #2 is only for completeness, to make it behave
more similar to qemu_anon_ram_alloc().

David Hildenbrand (2):
  s390x/kvm: legacy_s390_alloc() only supports one allocation
  s390x/kvm: indicate alignment in legacy_s390_alloc()

 target/s390x/kvm.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
2.17.1
