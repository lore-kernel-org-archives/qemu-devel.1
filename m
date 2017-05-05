Received: from eggs.gnu.org ([2001:4830:134:3::10]:53528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6aff-0004gX-Bl
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6afc-00088O-DD
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:41:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6afc-00087y-7G
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:41:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DC9880C08
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 10:41:07 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  5 May 2017 12:40:55 +0200
Message-Id: <20170505104101.30589-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] opengl: add headless ui, misc fixes
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

This patch adds a headless opengl ui (see patch 6 for details) and fixes
a bunch of issues along the way which I've trapped into while coding
things up (patches 1-5).

cheers,
  Gerd

Gerd Hoffmann (6):
  virtio-gpu: move virtio_gpu_gl_block
  egl-helpers: drop support for gles and debug logging
  egl-helpers: fix display init for x11
  egl-helpers: add missing error check
  egl: explicitly ask for core context
  opengl: add egl-headless display

 include/hw/virtio/virtio-gpu.h |   1 +
 include/ui/console.h           |   3 +
 include/ui/egl-helpers.h       |   3 +-
 hw/display/virtio-gpu-3d.c     |  16 +++++
 hw/display/virtio-gpu.c        |  18 +----
 ui/egl-context.c               |   7 +-
 ui/egl-headless.c              | 158 +++++++++++++++++++++++++++++++++++++++++
 ui/egl-helpers.c               |  88 +++++++++--------------
 ui/gtk-egl.c                   |   2 +-
 vl.c                           |  16 +++++
 ui/Makefile.objs               |   1 +
 11 files changed, 239 insertions(+), 74 deletions(-)
 create mode 100644 ui/egl-headless.c

-- 
2.9.3
