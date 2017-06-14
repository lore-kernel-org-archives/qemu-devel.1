Received: from eggs.gnu.org ([2001:4830:134:3::10]:60227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3sA-0000cC-Uj
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dL3s7-0007b3-0M
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:41:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dL3s6-0007aq-Qb
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:41:50 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Jun 2017 10:41:45 +0200
Message-Id: <20170614084149.31314-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] ui/opengl: add and use helper functions to
 handle framebuffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

All UIs with opengl support have simliar code to handle opengl
framebuffers.  Create some helpers and put them into use to reduce
code duplication.

v2:
 * use GL_LINEAR
 * add helper for default framebuffer setup

Gerd Hoffmann (4):
  egl-helpers: add helpers to handle opengl framebuffers
  egl-headless: use framebuffer helper functions.
  sdl2: use framebuffer helper functions.
  gtk: use framebuffer helper functions.

 include/ui/egl-helpers.h | 15 ++++++++++
 include/ui/gtk.h         |  4 +--
 include/ui/sdl2.h        |  8 +++--
 ui/egl-headless.c        | 67 +++++++++++-------------------------------
 ui/egl-helpers.c         | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 ui/gtk-egl.c             | 36 +++++------------------
 ui/gtk-gl-area.c         | 26 +++++------------
 ui/sdl2-gl.c             | 36 +++++------------------
 8 files changed, 137 insertions(+), 131 deletions(-)

-- 
2.9.3
