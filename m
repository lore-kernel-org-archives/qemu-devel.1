Received: from eggs.gnu.org ([2001:4830:134:3::10]:34243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=837a4a9fa=tim.smith@citrix.com>)
	id 1gIWH2-0002WA-2J
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=837a4a9fa=tim.smith@citrix.com>)
	id 1gIWH1-0000YZ-Aq
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:01:52 -0400
From: Tim Smith <tim.smith@citrix.com>
Date: Fri, 2 Nov 2018 10:00:54 +0000
Message-ID: <154115285434.11300.8459925605672823399.stgit@dhcp-3-135.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/3] Performance improvements for xen_disk v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Paul Durrant <Paul.Durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Max Reitz <mreitz@redhat.com>

A series of performance improvements for disks using the Xen PV ring.

These have had fairly extensive testing.

The batching and latency improvements together boost the throughput
of small reads and writes by two to six percent (measured using fio
in the guest)

Avoiding repeated calls to posix_memalign() reduced the dirty heap
from 25MB to 5MB in the case of a single datapath process while also
improving performance.

v2 removes some checkpatch complaints and fixes the CCs

---

Tim Smith (3):
      Improve xen_disk batching behaviour
      Improve xen_disk response latency
      Avoid repeated memory allocation in xen_disk


 hw/block/xen_disk.c |   82 +++++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 36 deletions(-)

--
Tim Smith <tim.smith@citrix.com>
