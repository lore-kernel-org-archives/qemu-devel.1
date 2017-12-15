Received: from eggs.gnu.org ([2001:4830:134:3::10]:42748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ePdr2-0002l7-R4
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ePdqy-0005ep-Sz
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:27:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1ePdqy-0005cv-NO
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 19:27:52 -0500
Date: Thu, 14 Dec 2017 16:27:50 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1712141612170.3857@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PULL 0/6] xen-20171214-tag
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

The following changes since commit 0a0dc59d27527b78a195c2d838d28b7b49e5a639:

  Update version for v2.11.0 release (2017-12-13 14:31:09 +0000)

are available in the git repository at:

  git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20171214-tag

for you to fetch changes up to 2e63eb2becc228232f12a1ea30a91b2aa8c5cecd:

  xen/pt: Set is_express to avoid out-of-bounds write (2017-12-14 16:11:53 -0800)

----------------------------------------------------------------
Xen 2017/12/14

----------------------------------------------------------------
Owen Smith (4):
      ui: generate qcode to linux mappings
      xenfb: Use Input Handlers directly
      xenfb: Add [feature|request]-raw-pointer
      xenfb: activate input handlers for raw pointer devices

Paul Durrant (1):
      xen-disk: use an IOThread per instance

Simon Gaiser (1):
      xen/pt: Set is_express to avoid out-of-bounds write

 Makefile              |   1 +
 hw/block/trace-events |   7 ++
 hw/block/xen_disk.c   |  53 +++++++--
 hw/display/xenfb.c    | 294 ++++++++++++++++++++++++++------------------------
 hw/xen/xen_pt.c       |   1 +
 include/ui/input.h    |   3 +
 ui/input-keymap.c     |   1 +
 7 files changed, 215 insertions(+), 145 deletions(-)
