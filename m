Received: from eggs.gnu.org ([2001:4830:134:3::10]:36894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3uVX-0005ui-ES
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3uVT-0003yt-Lt
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:20:11 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  5 Apr 2018 12:20:00 +1000
Message-Id: <20180405022002.17809-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 for-2.13 0/2] Helpers to obtain host page
 sizes for guest RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, imammedo@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This series makes some small changes to make it easier to obtain the
host page size backing given portions of guest RAM.  We use this in a
couple of places currently, and I have one or two more to add in some
upcoming code.

Changes since v1:
  * Reworked design based on Eduardo's feedback
  * Split into two patches

David Gibson (2):
  Make qemu_mempath_getpagesize() accept NULL
  Add host_memory_backend_pagesize() helper

 backends/hostmem.c       | 11 +++++++++++
 exec.c                   | 20 +++++---------------
 include/sysemu/hostmem.h |  2 ++
 target/ppc/kvm.c         | 10 +---------
 util/mmap-alloc.c        | 26 ++++++++++++++------------
 5 files changed, 33 insertions(+), 36 deletions(-)

-- 
2.14.3
