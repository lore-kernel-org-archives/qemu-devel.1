Received: from eggs.gnu.org ([2001:4830:134:3::10]:56708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ekEjC-0001La-1g
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ekEjA-00031Q-Rs
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:52:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1ekEjA-00031I-N3
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:52:56 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  9 Feb 2018 20:52:36 +0100
Message-Id: <20180209195239.16048-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/3] cpus: single-threaded TCG CPU creation
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

While looking into CPU hotplug for s390x TCG, I noticed that
single-threaded TCG does not properly inititalize CPUs > 1. Fix this
and cleanup the code a bit.

David Hildenbrand (3):
  cpus: properly inititalize CPU > 1 under single-threaded TCG
  cpus: wait for CPU creation at central place
  cpus: CPU threads are always created initially for one CPU only

 cpus.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

-- 
2.14.3
