Received: from eggs.gnu.org ([2001:4830:134:3::10]:39991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=66078d76a=Paul.Durrant@citrix.com>)
	id 1fGRIH-0007W9-6K
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=66078d76a=Paul.Durrant@citrix.com>)
	id 1fGRIB-000222-Hm
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:46:17 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:59874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=66078d76a=Paul.Durrant@citrix.com>)
	id 1fGRIB-0001uW-7z
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:46:11 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 9 May 2018 16:46:02 +0100
Message-ID: <20180509154604.25530-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] xen-hvm: use new resource mapping API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>

This series modifies QEMU to use the new guest resource mapping API
(available in Xen 4.11+) to map ioreq pages.

Paul Durrant (2):
  xen-hvm: create separate function for ioreq server initialization
  xen-hvm: try to use xenforeignmemory_map_resource() to map ioreq pages

 configure                   |   5 ++
 hw/i386/xen/trace-events    |   1 +
 hw/i386/xen/xen-hvm.c       | 114 ++++++++++++++++++++++++++++++++------------
 include/hw/xen/xen_common.h |  14 ++++++
 4 files changed, 104 insertions(+), 30 deletions(-)

-- 
2.11.0
