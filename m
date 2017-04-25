Received: from eggs.gnu.org ([2001:4830:134:3::10]:51938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d35Iq-0007hT-9p
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d35In-0005Z5-2j
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:35:08 -0400
Received: from mail.kernel.org ([198.145.29.136]:49512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d35Im-0005Yv-QJ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:35:05 -0400
Date: Tue, 25 Apr 2017 11:34:59 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1704251134220.2875@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PULL 0/21] Please pull xen-20170421-v2-tag for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

Added a fix for the clang build, see
alpine.DEB.2.10.1704251014320.2875@sstabellini-ThinkPad-X260


The following changes since commit 55a19ad8b2d0797e3a8fe90ab99a9bb713824059:

  Update version for v2.9.0-rc1 release (2017-03-21 17:13:29 +0000)

are available in the git repository at:

  git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170421-v2-tag

for you to fetch changes up to 28b99f473bda682385da944b0404aedbe11ea0dc:

  move xen-mapcache.c to hw/i386/xen/ (2017-04-25 11:04:34 -0700)

----------------------------------------------------------------
Xen 2017/04/21 + fix

----------------------------------------------------------------
Anthony Xu (3):
      move xen-common.c to hw/xen/
      move xen-hvm.c to hw/i386/xen/
      move xen-mapcache.c to hw/i386/xen/

Juergen Gross (2):
      xen: use 5 digit xen versions
      configure: use pkg-config for obtaining xen version

Paul Durrant (7):
      xen: make use of xen_xc implicit in xen_common.h inlines
      xen: rename xen_modified_memory() to xen_hvm_modified_memory()
      xen: create wrappers for all other uses of xc_hvm_XXX() functions
      configure: detect presence of libxendevicemodel
      xen: use libxendevicemodel when available
      xen: use libxendevice model to restrict operations
      xen: additionally restrict xenforeignmemory operations

Stefano Stabellini (9):
      xen: import ring.h from xen
      9p: introduce a type for the 9p header
      xen/9pfs: introduce Xen 9pfs backend
      xen/9pfs: connect to the frontend
      xen/9pfs: receive requests from the frontend
      xen/9pfs: implement in/out_iov_from_pdu and vmarshal/vunmarshal
      xen/9pfs: send responses back to the frontend
      xen/9pfs: build and register Xen 9pfs backend
      add xen-9p-backend to MAINTAINERS under Xen

 MAINTAINERS                                  |   1 +
 Makefile.target                              |   6 -
 configure                                    | 164 +++++----
 default-configs/i386-softmmu.mak             |   1 -
 default-configs/x86_64-softmmu.mak           |   1 -
 hw/9pfs/9p.h                                 |   6 +
 hw/9pfs/Makefile.objs                        |   1 +
 hw/9pfs/virtio-9p-device.c                   |   6 +-
 hw/9pfs/xen-9p-backend.c                     | 440 ++++++++++++++++++++++++
 hw/9pfs/xen-9pfs.h                           |  21 ++
 hw/block/xen_blkif.h                         |   2 +-
 hw/block/xen_disk.c                          |   2 +-
 hw/i386/xen/Makefile.objs                    |   2 +-
 hw/i386/xen/trace-events                     |  17 +
 xen-hvm.c => hw/i386/xen/xen-hvm.c           |  59 ++--
 xen-mapcache.c => hw/i386/xen/xen-mapcache.c |   2 +-
 hw/i386/xen/xen_platform.c                   |   2 +-
 hw/usb/xen-usb.c                             |   2 +-
 hw/xen/Makefile.objs                         |   2 +-
 hw/xen/trace-events                          |   1 +
 xen-common.c => hw/xen/xen-common.c          |  11 +
 hw/xen/xen_backend.c                         |   5 +-
 include/exec/ram_addr.h                      |   4 +-
 include/hw/xen/io/ring.h                     | 482 +++++++++++++++++++++++++++
 include/hw/xen/xen.h                         |   3 +-
 include/hw/xen/xen_backend.h                 |   5 +-
 include/hw/xen/xen_common.h                  | 345 +++++++++++++++----
 qemu-options.hx                              |   7 +
 stubs/Makefile.objs                          |   2 +
 xen-common-stub.c => stubs/xen-common.c      |   0
 xen-hvm-stub.c => stubs/xen-hvm.c            |   2 +-
 trace-events                                 |  16 -
 vl.c                                         |   8 +
 33 files changed, 1435 insertions(+), 193 deletions(-)
 create mode 100644 hw/9pfs/xen-9p-backend.c
 create mode 100644 hw/9pfs/xen-9pfs.h
 rename xen-hvm.c => hw/i386/xen/xen-hvm.c (96%)
 rename xen-mapcache.c => hw/i386/xen/xen-mapcache.c (99%)
 rename xen-common.c => hw/xen/xen-common.c (91%)
 create mode 100644 include/hw/xen/io/ring.h
 rename xen-common-stub.c => stubs/xen-common.c (100%)
 rename xen-hvm-stub.c => stubs/xen-hvm.c (94%)
