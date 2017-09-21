Received: from eggs.gnu.org ([2001:4830:134:3::10]:34139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dur7B-0001nu-NP
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 22:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dur76-0006zB-Px
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 22:21:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dur76-0006yi-Jr
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 22:21:16 -0400
Date: Wed, 20 Sep 2017 19:21:14 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1709201906040.2968@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PULL 0/2] xen-20170920-tag
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

The following changes since commit b62b7ed0fc9c58e373b8946c9bd2e193be98dae6:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-09-20 20:33:48 +0100)

are available in the git repository at:


  git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170920-tag

for you to fetch changes up to a8036336609d2e184fc3543a4c439c0ba7d7f3a2:

  xen/pt: allow QEMU to request MSI unmasking at bind time (2017-09-20 19:05:27 -0700)

----------------------------------------------------------------
Xen 2017/09/20

----------------------------------------------------------------
Olaf Hering (1):
      xen-disk: use g_new0 to fix build

Roger Pau Monne (1):
      xen/pt: allow QEMU to request MSI unmasking at bind time

 hw/block/xen_disk.c         |  2 +-
 hw/xen/xen_pt.h             |  1 +
 hw/xen/xen_pt_config_init.c | 20 ++++++++++++++++++--
 hw/xen/xen_pt_msi.c         | 13 ++++++++++---
 4 files changed, 30 insertions(+), 6 deletions(-)
