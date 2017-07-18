Received: from eggs.gnu.org ([2001:4830:134:3::10]:57920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dXarW-0006vB-HB
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dXarS-0007dE-JE
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:21:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dXarS-0007Z8-DN
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:20:58 -0400
Date: Tue, 18 Jul 2017 15:20:56 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1707181519030.17537@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PULL for-2.0 0/7] please pull xen-20170718-tag
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

The following changes since commit f9dada2baabb639feb988b3a564df7a06d214e18:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-07-18 20:29:36 +0100)

are available in the git repository at:


  git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170718-tag

for you to fetch changes up to 331b5189d756d431b1d18ae7097527ba3d3ea809:

  xen: don't use xenstore to save/restore physmap anymore (2017-07-18 14:16:52 -0700)

----------------------------------------------------------------
Xen 2017/07/18

----------------------------------------------------------------
Igor Druzhinin (4):
      xen: move physmap saving into a separate function
      xen/mapcache: add an ability to create dummy mappings
      xen/mapcache: introduce xen_replace_cache_entry()
      xen: don't use xenstore to save/restore physmap anymore

Peter Maydell (1):
      xen_pt_msi.c: Check for xen_host_pci_get_* failures in xen_pt_msix_init()

Stefano Stabellini (1):
      xen-platform: separate unplugging of NVMe disks

Xiong Zhang (1):
      hw/xen: Set emu_mask for igd_opregion register

 configure                     |  18 +++++++
 hw/i386/xen/xen-hvm.c         | 105 +++++++++++++++++++++++-------------
 hw/i386/xen/xen-mapcache.c    | 121 ++++++++++++++++++++++++++++++++++++++----
 hw/i386/xen/xen_platform.c    |  47 +++++++++++-----
 hw/xen/xen_pt_config_init.c   |   1 +
 hw/xen/xen_pt_msi.c           |  12 ++++-
 include/hw/xen/xen_common.h   |  15 ++++++
 include/sysemu/xen-mapcache.h |  11 +++-
 8 files changed, 267 insertions(+), 63 deletions(-)
