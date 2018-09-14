Received: from eggs.gnu.org ([2001:4830:134:3::10]:47660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7883262b0=anthony.perard@citrix.com>)
	id 1g0m7S-00014u-27
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 07:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7883262b0=anthony.perard@citrix.com>)
	id 1g0m7O-0001vH-QE
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 07:18:37 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:40306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=7883262b0=anthony.perard@citrix.com>)
	id 1g0m7O-0001sf-GU
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 07:18:34 -0400
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Fri, 14 Sep 2018 12:18:28 +0100
Message-ID: <20180914111830.28466-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] Remove Xen PV domain creation in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org

See first patch description.

Anthony PERARD (2):
  Remove broken Xen PV domain builder
  xen: Replace few mentions of xend by libxl

 configure                   |  17 --
 hw/xenpv/Makefile.objs      |   2 -
 hw/xenpv/xen_domainbuild.c  | 299 ------------------------------------
 hw/xenpv/xen_domainbuild.h  |  13 --
 hw/xenpv/xen_machine_pv.c   |  16 +-
 include/hw/xen/xen.h        |   3 +-
 include/hw/xen/xen_common.h |  18 ---
 qemu-options.hx             |  12 +-
 vl.c                        |   7 -
 9 files changed, 4 insertions(+), 383 deletions(-)
 delete mode 100644 hw/xenpv/xen_domainbuild.c
 delete mode 100644 hw/xenpv/xen_domainbuild.h

-- 
Anthony PERARD
