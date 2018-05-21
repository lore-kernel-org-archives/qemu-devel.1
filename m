Received: from eggs.gnu.org ([2001:4830:134:3::10]:41532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fKqZt-0008U5-SJ
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fKqZp-0002lF-Oy
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1fKqZp-0002kf-IB
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:34:37 -0400
Date: Mon, 21 May 2018 12:34:32 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1805211229070.4520@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PULL 00/15] xen-20180521-tag
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

The following changes since commit d32e41a1188e929cc0fb16829ce3736046951e39:

  Merge remote-tracking branch 'remotes/famz/tags/docker-and-block-pull-request' into staging (2018-05-18 14:11:52 +0100)

are available in the git repository at:


  http://xenbits.xenproject.org/git-http/people/sstabellini/qemu-dm.git tags/xen-20180521-tag

for you to fetch changes up to f03df99f09ee0ca27ea2298a1b77438e7999044d:

  xen_disk: be consistent with use of xendev and blkdev->xendev (2018-05-18 11:13:01 -0700)

----------------------------------------------------------------
Xen 2018/05/21

----------------------------------------------------------------
Anthony PERARD (1):
      configure: Add explanation for --enable-xen-pci-passthrough

Igor Druzhinin (2):
      xen-pvdevice: Introduce a simplistic xen-pvdevice save state
      xen/pt: use address_space_memory object for memory region hooks

Paul Durrant (11):
      xen-hvm: create separate function for ioreq server initialization
      All the xen stable APIs define handle types of the form:
      xen: add a meaningful declaration of grant_copy_segment into xen_common.h
      xen_backend: add grant table helpers
      xen_disk: remove open-coded use of libxengnttab
      xen: remove other open-coded use of libxengnttab
      xen_backend: add an emulation of grant copy
      xen_disk: remove use of grant map/unmap
      xen_backend: make the xen_feature_grant_copy flag private
      xen_disk: use a single entry iovec
      xen_disk: be consistent with use of xendev and blkdev->xendev

Ross Lagerwall (1):
      xen_pt: Present the size of 64 bit BARs correctly

 configure                    |   2 +-
 dtc                          |   2 +-
 hw/9pfs/xen-9p-backend.c     |  32 ++-
 hw/block/xen_disk.c          | 614 +++++++------------------------------------
 hw/char/xen_console.c        |   9 +-
 hw/i386/xen/xen-hvm.c        |  76 +++---
 hw/i386/xen/xen_pvdevice.c   |  11 +
 hw/net/xen_nic.c             |  33 +--
 hw/usb/xen-usb.c             |  37 ++-
 hw/xen/xen_backend.c         | 178 ++++++++++++-
 hw/xen/xen_pt.c              |   2 +-
 hw/xen/xen_pt_config_init.c  |   2 +
 include/hw/xen/xen_backend.h |  34 ++-
 include/hw/xen/xen_common.h  |  17 +-
 scripts/checkpatch.pl        |   2 +-
 ui/keycodemapdb              |   2 +-
 16 files changed, 429 insertions(+), 624 deletions(-)
