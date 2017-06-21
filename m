Received: from eggs.gnu.org ([2001:4830:134:3::10]:44373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dNfbf-0005Le-38
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dNfbd-0003YE-GQ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:23:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dNfbd-0003Xt-AK
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:23:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 687B27F6CF
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 13:23:36 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Jun 2017 15:23:34 +0200
Message-Id: <20170621132340.27686-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] Queue/ui patches
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

The following changes since commit 8dfaf23ae1f2273a9730a9b309cc8471269bb5=
24:

  tcg/tci: fix tcg-interpreter build (2017-06-20 18:39:15 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/queue/ui-pull-request

for you to fetch changes up to 95e92000c8b1e81fce6a7f54ef22656a94793096:

  ui: Remove inclusion of "hw/qdev.h" (2017-06-21 14:26:15 +0200)

----------------------------------------------------------------

----------------------------------------------------------------

Gerd Hoffmann (5):
  egl-helpers: add helpers to handle opengl framebuffers
  egl-headless: use framebuffer helper functions.
  sdl2: use framebuffer helper functions.
  gtk: use framebuffer helper functions.
  console: remove do_safe_dpy_refresh

Thomas Huth (1):
  ui: Remove inclusion of "hw/qdev.h"

 include/ui/egl-helpers.h | 15 ++++++++++
 include/ui/gtk.h         |  4 +--
 include/ui/sdl2.h        |  8 +++--
 ui/console.c             | 25 +---------------
 ui/egl-headless.c        | 67 +++++++++++-------------------------------
 ui/egl-helpers.c         | 76 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 ui/gtk-egl.c             | 36 +++++------------------
 ui/gtk-gl-area.c         | 26 +++++------------
 ui/input.c               |  1 -
 ui/sdl2-gl.c             | 36 +++++------------------
 ui/vnc.c                 |  1 -
 11 files changed, 138 insertions(+), 157 deletions(-)

--=20
2.9.3
