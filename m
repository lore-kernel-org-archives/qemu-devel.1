Received: from eggs.gnu.org ([2001:4830:134:3::10]:57182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fOSvw-0007Q2-4i
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fOSvs-0006GI-4S
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1fOSvr-0006F2-Tb
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:08:20 -0400
Date: Thu, 31 May 2018 12:08:16 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1805311206230.23991@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PULL 0/3] xen-20180531-tag
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

The following changes since commit c181ddaa176856b3cd2dfd12bbcf25fa9c884a97:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180531-1' into staging (2018-05-31 17:00:55 +0100)

are available in the git repository at:


  http://xenbits.xenproject.org/git-http/people/sstabellini/qemu-dm.git tags/xen-20180531-tag

for you to fetch changes up to dfb6578d69d60e464be36dafed9741dcfd73d2cf:

  xen-hvm: stop faking I/O to access PCI config space (2018-05-31 12:05:01 -0700)

----------------------------------------------------------------
Xen 2018/05/31

----------------------------------------------------------------
Igor Druzhinin (1):
      xen/hvm: correct reporting of modified memory under physmap during migration

Paul Durrant (2):
      xen-hvm: try to use xenforeignmemory_map_resource() to map ioreq pages
      xen-hvm: stop faking I/O to access PCI config space

 configure                     |   5 ++
 hw/i386/xen/trace-events      |   3 +
 hw/i386/xen/xen-hvm.c         | 205 +++++++++++++++++++++++++++++++-----------
 hw/i386/xen/xen-mapcache.c    |   2 +-
 include/hw/xen/xen_common.h   |  16 ++++
 include/sysemu/xen-mapcache.h |   5 +-
 6 files changed, 179 insertions(+), 57 deletions(-)
