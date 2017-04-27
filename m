Received: from eggs.gnu.org ([2001:4830:134:3::10]:55842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d3gQ8-0005Zs-17
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d3gQ3-0008PB-3e
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:13:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1d3gQ2-0008Oi-TZ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:13:03 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu, 27 Apr 2017 12:12:57 +0200
Message-Id: <20170427101259.13798-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] numa,
 spapr: equally distribute memory on nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>

When there are more nodes than memory available to put the minimum
allowed memory by node, all the memory is put on the last node.

This series introduces a new MachineState function to
distribute equally the memory across the nodes
without breaking compatibility with previous
machine types.

The new function uses an error diffusion algorithm to
distribute the memory across the nodes.

As the memory alignment for pseries is 256MB and for the others
is only 8MB, we introduce this change only for pseries-2.10

Laurent Vivier (2):
  numa: introduce numa_auto_assign_ram() function in MachineClass
  numa,spapr: equally distribute memory on nodes

 hw/ppc/spapr.c         | 21 ++++++++++++++++++++-
 include/hw/boards.h    |  2 ++
 include/hw/ppc/spapr.h |  3 ++-
 numa.c                 | 44 +++++++++++++++++++++++++++++++++-----------
 4 files changed, 57 insertions(+), 13 deletions(-)

-- 
2.9.3
