Received: from eggs.gnu.org ([2001:4830:134:3::10]:34888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=338cb52eb=Paul.Durrant@citrix.com>)
	id 1dNf81-0000qI-HB
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=338cb52eb=Paul.Durrant@citrix.com>)
	id 1dNf80-0005qn-RM
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:53:01 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 21 Jun 2017 08:52:46 -0400
Message-ID: <20170621125249.8805-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/3] xen-disk: performance improvements
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
 hw/block/xen_disk.c   | 228 +++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 188 insertions(+), 47 deletions(-)

-- 
2.11.0
