Received: from eggs.gnu.org ([2001:4830:134:3::10]:52259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e4Pou-0005K7-1h
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e4Pop-0001rK-7a
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:13:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e4Pop-0001p8-1w
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:13:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F7354E02A
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 11:13:54 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 17 Oct 2017 13:13:44 +0200
Message-Id: <20171017111350.8176-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/6] Opengl 20171017 patches
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

The following changes since commit c5bbcaa4b7c0f8a322bebe9ec563560178a68b55:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-10-16 17:29:16 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/opengl-20171017-pull-request

for you to fetch changes up to a35179170034b60bcfb997e06bc63258caaf5049:

  egl-headless: add dmabuf support (2017-10-17 10:25:42 +0200)

----------------------------------------------------------------
ui: opengl updates for dma-buf support.

----------------------------------------------------------------

Gerd Hoffmann (6):
  console: add support for dmabufs
  opengl: move shader init from console-gl.c to shader.c
  opengl: add flipping vertex shader
  egl-helpers: add dmabuf import support
  egl-helpers: add egl_texture_blit and egl_texture_blend
  egl-headless: add dmabuf support

 Makefile                         |  6 ++--
 include/qemu/typedefs.h          |  1 +
 include/ui/console.h             | 39 ++++++++++++++++-----
 include/ui/egl-helpers.h         |  7 ++++
 include/ui/gtk.h                 |  2 +-
 include/ui/sdl2.h                |  2 +-
 include/ui/shader.h              | 12 +++----
 include/ui/spice-display.h       |  2 +-
 ui/console-gl.c                  | 45 ++++---------------------
 ui/console.c                     | 33 ++++++++++++++++++
 ui/egl-headless.c                | 59 ++++++++++++++++++++++++++++++--
 ui/egl-helpers.c                 | 73 ++++++++++++++++++++++++++++++++++++++++
 ui/gtk-egl.c                     |  2 +-
 ui/gtk-gl-area.c                 |  2 +-
 ui/sdl2-gl.c                     |  4 +--
 ui/shader.c                      | 57 ++++++++++++++++++++++++++-----
 ui/spice-display.c               |  2 +-
 ui/shader/texture-blit-flip.vert | 10 ++++++
 18 files changed, 283 insertions(+), 75 deletions(-)
 create mode 100644 ui/shader/texture-blit-flip.vert

-- 
2.9.3
