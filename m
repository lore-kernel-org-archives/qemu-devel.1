Received: from eggs.gnu.org ([2001:4830:134:3::10]:33124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6664e1dc0=Paul.Durrant@citrix.com>)
	id 1fId0X-0005s5-Ms
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6664e1dc0=Paul.Durrant@citrix.com>)
	id 1fId0U-0007RT-Pr
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:41:01 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:23739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6664e1dc0=Paul.Durrant@citrix.com>)
	id 1fId0U-0007Pf-H1
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:40:58 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 15 May 2018 17:40:50 +0100
Message-ID: <20180515164053.14604-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/3] xen-hvm: use new resource mapping API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

This series modifies QEMU to use the new guest resource mapping API
(available in Xen 4.11+) to map ioreq pages.

v2:
 - Add a patch to checkpatch to avoid misparsing of Xen stable API handles

Paul Durrant (3):
  xen-hvm: create separate function for ioreq server initialization
  checkpatch: generalize xen handle matching in the list of types
  xen-hvm: try to use xenforeignmemory_map_resource() to map ioreq pages

 configure                   |   5 ++
 hw/i386/xen/trace-events    |   1 +
 hw/i386/xen/xen-hvm.c       | 112 ++++++++++++++++++++++++++++++++------------
 include/hw/xen/xen_common.h |  16 +++++++
 scripts/checkpatch.pl       |   2 +-
 5 files changed, 105 insertions(+), 31 deletions(-)
---
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>

-- 
2.11.0
