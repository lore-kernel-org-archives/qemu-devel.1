Received: from eggs.gnu.org ([2001:4830:134:3::10]:55626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cc7UL-0001kq-LX
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cc7UG-0007H6-OD
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:27:33 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Fri, 10 Feb 2017 10:27:21 +0100
Message-Id: <20170210092724.6470-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] ppc: replace debug printf with trace points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Laurent Vivier <lvivier@redhat.com>

This series replaces the remaining DPRINTF()
found under hw/ppc and replace them with trace
points.

Laurent Vivier (3):
  mac99: replace debug printf with trace points
  ppc4xx: replace debug printf with trace points
  spapr: replace debug printf with trace points

 hw/ppc/mac_newworld.c | 15 +++------------
 hw/ppc/ppc4xx_pci.c   | 13 +++----------
 hw/ppc/spapr_ovec.c   | 17 +++--------------
 hw/ppc/trace-events   | 12 ++++++++++++
 4 files changed, 21 insertions(+), 36 deletions(-)

-- 
2.9.3
