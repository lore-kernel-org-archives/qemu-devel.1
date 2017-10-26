Received: from eggs.gnu.org ([2001:4830:134:3::10]:42702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7r7d-0001mK-D6
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7r7a-0001wN-By
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1e7r7a-0001v6-5c
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 18:59:30 -0400
Date: Thu, 26 Oct 2017 15:59:27 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1710261556510.3086@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PULL 0/3] xen-20171026-tag
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

The following changes since commit 325a084c1ebccb265a3c8f1dd092ffbbfb448a00:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2017-10-24-1' into staging (2017-10-26 09:20:11 +0100)

are available in the git repository at:


  git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20171026-tag

for you to fetch changes up to 7cdcca725b6bfc96634c15e3f74ae4b148cf9c40:

  xen: Log errno rather than return value (2017-10-26 14:26:48 -0700)

----------------------------------------------------------------
Xen 2017/10/26

----------------------------------------------------------------
Juergen Gross (2):
      xen: add a global indicator for grant copy being available
      xen: dont try setting max grants multiple times

Ross Lagerwall (1):
      xen: Log errno rather than return value

 hw/block/xen_disk.c          | 34 ++++++++++++++++++----------------
 hw/i386/xen/xen-hvm.c        |  2 +-
 hw/xen/xen_backend.c         | 11 +++++++++++
 include/hw/xen/xen_backend.h |  1 +
 4 files changed, 31 insertions(+), 17 deletions(-)
