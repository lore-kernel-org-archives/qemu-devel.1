Received: from eggs.gnu.org ([2001:4830:134:3::10]:38218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cZMEQ-0003lI-Dp
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cZMEL-0004dE-FH
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:35:42 -0500
Received: from mail.kernel.org ([198.145.29.136]:44988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cZMEL-0004cp-48
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:35:37 -0500
Date: Thu, 2 Feb 2017 10:35:33 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1702021024200.17946@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PULL 0/5] xen-20170202
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, peter.maydell@linaro.orgsstabellini@kernel.org, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

The following changes since commit 3aca12f841fcd6f3a7477076dad0d564360500de:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170127' into staging (2017-01-27 16:59:17 +0000)

are available in the git repository at:


  git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170202

for you to fetch changes up to e9dcbc86d614018923e26e31319b0a54c9e5abac:

  xen: use qdev_unplug() instead of g_free() in xen_pv_find_xendev() (2017-02-02 10:23:53 -0800)

----------------------------------------------------------------
Xen 2017/02/02

----------------------------------------------------------------
Anthony PERARD (1):
      MAINTAINERS: Update xen-devel mailing list address

Juergen Gross (1):
      xen: use qdev_unplug() instead of g_free() in xen_pv_find_xendev()

Paul Durrant (3):
      xen-platform: re-structure unplug_disks
      xen-platform: add support for unplugging NVMe disks...
      xen-platform: add missing disk unplug option

 MAINTAINERS                |  2 +-
 hw/i386/xen/xen_platform.c | 51 ++++++++++++++++++++++++++++------------------
 hw/ide/piix.c              |  4 ++--
 hw/xen/xen_backend.c       | 13 ++++++------
 include/hw/ide.h           |  2 +-
 5 files changed, 42 insertions(+), 30 deletions(-)
