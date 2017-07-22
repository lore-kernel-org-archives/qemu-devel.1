Received: from eggs.gnu.org ([2001:4830:134:3::10]:39871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dYiYR-0007CH-RC
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dYiYM-0001Qj-Ob
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dYiYM-0001Ps-I7
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:45:54 -0400
Date: Fri, 21 Jul 2017 17:45:51 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1707211740220.22381@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PULL for-2.10 0/2] please pull xen-20170721-tag
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

The following changes since commit 91939262ffcd3c85ea6a4793d3029326eea1d649:

  configure: Drop ancient Solaris 9 and earlier support (2017-07-21 15:04:05 +0100)

are available in the git repository at:

  git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170721-tag

for you to fetch changes up to 7fb394ad8a7c4609cefa2136dec16cf65d028f40:

  xen-mapcache: Fix the bug when overlapping emulated DMA operations may cause inconsistency in guest memory mappings (2017-07-21 17:37:06 -0700)

----------------------------------------------------------------
Xen 2017/07/21

----------------------------------------------------------------
Alexey G (1):
      xen-mapcache: Fix the bug when overlapping emulated DMA operations may cause inconsistency in guest memory mappings

Igor Druzhinin (1):
      xen: fix compilation on 32-bit hosts

 hw/i386/xen/xen-mapcache.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)
