Received: from eggs.gnu.org ([2001:4830:134:3::10]:45840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpzoD-00030k-HW
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpznb-0000PY-Uc
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:05:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cpznb-0000PQ-Mb
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:04:47 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9043C804E0
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 16:04:47 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-118.ams2.redhat.com
	[10.36.117.118])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F0FC12D5C1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 16:04:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 20 Mar 2017 17:04:42 +0100
Message-Id: <20170320160446.14643-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] Misc fixes for 2.9.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit ebedf0f9cd46b617df331eecc857c379d574ac62:

  nios2: iic: Convert CPU prop to qom link (2017-03-18 18:22:54 +0000)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to b3d3a426da9b067366bc132d53a6fa6b72675b55:

  hax: fix breakage in locking (2017-03-20 12:24:43 +0100)

----------------------------------------------------------------
fixes for 2.9-rc1, plus removal of -mno-cygwin references

----------------------------------------------------------------
Paolo Bonzini (2):
      qemu-ga: obey LISTEN_PID when using systemd socket activation
      configure: remove Cygwin

Stefano Stabellini (1):
      xen: do not build backends for targets that do not support xen

Vincent Palatin (1):
      hax: fix breakage in locking

 Makefile                 |   1 +
 bsd-user/mmap.c          |   5 ---
 configure                |   6 ---
 cpus.c                   |   3 +-
 hw/block/Makefile.objs   |   2 +-
 hw/char/Makefile.objs    |   2 +-
 hw/display/Makefile.objs |   2 +-
 hw/net/Makefile.objs     |   2 +-
 hw/usb/Makefile.objs     |   2 +-
 hw/xen/Makefile.objs     |   2 +-
 include/qemu/systemd.h   |  26 ++++++++++++
 qemu-nbd.c               | 100 ++++-------------------------------------------
 qga/main.c               |  51 ++++++------------------
 util/Makefile.objs       |   1 +
 util/systemd.c           |  77 ++++++++++++++++++++++++++++++++++++
 15 files changed, 134 insertions(+), 148 deletions(-)
 create mode 100644 include/qemu/systemd.h
 create mode 100644 util/systemd.c
-- 
2.9.3
