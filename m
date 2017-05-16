Received: from eggs.gnu.org ([2001:4830:134:3::10]:46787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dAi0K-0002Tm-Jc
	for qemu-devel@nongnu.org; Tue, 16 May 2017 15:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dAi0H-0007C4-D7
	for qemu-devel@nongnu.org; Tue, 16 May 2017 15:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dAi0H-0007Bi-6a
	for qemu-devel@nongnu.org; Tue, 16 May 2017 15:19:29 -0400
Date: Tue, 16 May 2017 12:19:26 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1705161157280.4103@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PULL 0/4] please pull xen-20170516-tag
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

The following changes since commit cdece0467c00007cf8e3f4b3c3f0b13bf2c4fea9:

  block/win32: fix 'ret not initialized' warning (2017-05-16 15:34:18 +0100)

are available in the git repository at:

  git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170516-tag

for you to fetch changes up to 01cd90b641e1aed40cf13a577e6a737af94d55e7:

  xen: call qemu_set_cloexec instead of fcntl (2017-05-16 11:51:25 -0700)

----------------------------------------------------------------
Xen 2017/05/16

----------------------------------------------------------------
Anthony PERARD (1):
      configure: Remove -lxencall for Xen detection

Stefano Stabellini (3):
      xen/mapcache: store dma information in revmapcache entries for debugging
      xen/9pfs: fix two resource leaks on error paths, discovered by Coverity
      xen: call qemu_set_cloexec instead of fcntl

 configure                     |  2 +-
 exec.c                        |  8 ++++----
 hw/9pfs/xen-9p-backend.c      |  4 +++-
 hw/i386/xen/xen-mapcache.c    | 15 ++++++++++-----
 hw/xen/xen_backend.c          |  2 +-
 include/sysemu/xen-mapcache.h |  5 +++--
 6 files changed, 22 insertions(+), 14 deletions(-)
