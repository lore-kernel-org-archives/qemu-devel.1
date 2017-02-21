Received: from eggs.gnu.org ([2001:4830:134:3::10]:53872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiK-0002qg-Ct
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiH-0004Ry-5j
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgIiH-0004Rc-0V
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:13 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F358983F42
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 22:15:12 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 23:14:50 +0100
Message-Id: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/9] wire up -g <width>x<height> switch for
 virtio and qxl.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

  Hi,

Made a nice patch series out of it, first cleaning up graphics_* variable=
s,
then adding support for -g to virtio (just works), qxl (needs guest drive=
r
fixes) and stdvga (needs virtual hardware update, and therefore also an
guest driver update for obvious reasons).

linux kernel patches to test qxl and stdvga are here:
  https://www.kraxel.org/cgit/linux/log/?h=3Dqxl-display-size

please review & test,
  Gerd

Gerd Hoffmann (9):
  sysemu: add defines for sparc & ppc graphics_*
  sparc: use sparc_graphic_* defines
  ppc: use ppc_graphic_* defines
  drop arch-specific graphic_* initialization.
  enable -g command line switch for all archs
  virtio-gpu: use graphic_* variables.
  qxl: use graphic_* variables.
  update -g command line switch documentation
  [RfC] stdvga: use graphic_* variables.

 arch_init.c             | 11 -----------
 hw/display/qxl.c        | 32 ++++++++++++++++++++----------
 hw/display/vga-pci.c    | 52 ++++++++++++++++++++++++++++++++++---------=
------
 hw/display/vga_int.h    |  4 ++--
 hw/display/virtio-gpu.c |  9 +++++++--
 hw/display/virtio-vga.c |  3 ++-
 hw/ppc/mac_newworld.c   |  6 +++---
 hw/ppc/mac_oldworld.c   |  6 +++---
 hw/ppc/prep.c           | 10 +++++-----
 hw/ppc/spapr.c          |  6 +++---
 hw/sparc/sun4m.c        | 36 +++++++++++++++++-----------------
 include/sysemu/sysemu.h |  7 +++++++
 qemu-options.hx         | 15 ++++++++++++--
 vl.c                    |  3 +++
 14 files changed, 124 insertions(+), 76 deletions(-)

--=20
1.8.3.1
