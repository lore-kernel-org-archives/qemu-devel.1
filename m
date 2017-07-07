Received: from eggs.gnu.org ([2001:4830:134:3::10]:52104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dTY0t-0001ko-Gs
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dTY0q-0006VI-9d
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dTY0q-0006Us-3a
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:29:56 -0400
Date: Fri, 7 Jul 2017 11:29:53 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1707071117420.2919@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PULL 0/3] please pull xen-20170707-tag
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

The following changes since commit b11365867568ba954de667a0bfe0945b8f78d6bd:

  Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20170706' into staging (2017-07-06 11:42:59 +0100)

are available in the git repository at:


  git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170707-tag

for you to fetch changes up to 4daf62594d13dfca2ce3a74dd3bddee5f54d7127:

  xen/pt: Fixup addr validation in xen_pt_pci_config_access_check (2017-07-07 11:13:10 -0700)

----------------------------------------------------------------
Xen 2017/07/07

----------------------------------------------------------------
Anoob Soman (1):
      xen/pt: Fixup addr validation in xen_pt_pci_config_access_check

Ross Lagerwall (1):
      xen-platform: Cleanup network infrastructure when emulated NICs are unplugged

Stefano Stabellini (1):
      xenfb: remove xen_init_display "temporary" hack

 hw/display/xenfb.c           | 81 ++++++++++----------------------------------
 hw/i386/xen/xen_platform.c   | 11 ++++++
 hw/xen/xen_pt.c              |  2 +-
 hw/xenpv/xen_machine_pv.c    |  3 --
 include/hw/xen/xen_backend.h |  2 --
 5 files changed, 30 insertions(+), 69 deletions(-)
