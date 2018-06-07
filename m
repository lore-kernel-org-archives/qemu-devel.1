Received: from eggs.gnu.org ([2001:4830:134:3::10]:37803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQx8A-0007x7-Cw
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQx85-0001Eh-Dz
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:47:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45330 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fQx85-0001EG-9O
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:47:13 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Jun 2018 17:47:03 +0200
Message-Id: <20180607154705.6316-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/2] memory: fix alignment checks/asserts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, david@redhat.com

We can currently hit two asserts. Let's fix those.

Patch nr. 1 is a result from:
    "[PATCH v4 00/14] MemoryDevice: use multi stage hotplug handlers"

We treat right now any alignment > 1GB as a violation, as it would
fragment guest memory heavily. Turn the assert into a check.

Also, we run into an assert when using alignments that are not a power of
two.

David Hildenbrand (2):
  memory-device: turn alignment assert into check
  exec: check that alignment is a power of two

 exec.c                 | 4 ++++
 hw/mem/memory-device.c | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.17.0
