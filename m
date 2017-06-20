Received: from eggs.gnu.org ([2001:4830:134:3::10]:34165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3370d2115=Paul.Durrant@citrix.com>)
	id 1dNJVx-00025Z-D4
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3370d2115=Paul.Durrant@citrix.com>)
	id 1dNJVu-0000Eq-CM
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:48:17 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 20 Jun 2017 09:47:53 -0400
Message-ID: <20170620134756.9632-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] xen-disk: performance improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>

Paul Durrant (3):
  xen-disk: only advertize feature-persistent if grant copy is not
    available
  xen-disk: add support for multi-page shared rings
  xen-disk: use an IOThread per instance

 hw/block/trace-events |   7 ++
 hw/block/xen_disk.c   | 200 ++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 168 insertions(+), 39 deletions(-)

-- 
2.11.0
