Received: from eggs.gnu.org ([2001:4830:134:3::10]:33478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg6sz-0000rX-0X
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:37:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg6sv-00069t-VF
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:37:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg6sv-00069F-OH
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:37:25 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D59CA3D968
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 09:37:25 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 10:37:15 +0100
Message-Id: <1487669841-13668-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] ui: some gl scanout improvements.
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

Upcoming intel vgpu support will need some updates for the qemu opengl
support, specifically we will need support for importing dma-bufs.
The kernel support for this is still brewing though and thus the qemu
patches are still experimental and a moving target.

While working on it I did some cleanups and improvements on the opengl
code in qemu though, and there is no reason to wait with merging them,
so here are the first bits.

cheers,
  Gerd

Gerd Hoffmann (6):
  console: rename dpy_gl_scanout to dpy_gl_scanout_texture
  console: add dpy_gl_scanout_disable
  virtio-gpu: use dpy_gl_scanout_disable
  spice: add scanout_disable support
  sdl2: add scanout_disable support
  gtk-egl: add scanout_disable support

 hw/display/virtio-gpu-3d.c | 13 ++++++------
 include/ui/console.h       | 21 ++++++++++++-------
 include/ui/gtk.h           | 25 +++++++++++++---------
 include/ui/sdl2.h          | 13 +++++++-----
 ui/console.c               | 30 +++++++++++++++++++-------
 ui/gtk-egl.c               | 25 +++++++++++++---------
 ui/gtk-gl-area.c           | 12 ++++++-----
 ui/gtk.c                   |  5 +++--
 ui/sdl2-gl.c               | 28 ++++++++++++++++---------
 ui/sdl2.c                  |  3 ++-
 ui/spice-display.c         | 52 ++++++++++++++++++++++++++--------------------
 11 files changed, 138 insertions(+), 89 deletions(-)

-- 
1.8.3.1
