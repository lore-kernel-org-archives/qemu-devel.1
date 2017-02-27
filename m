Received: from eggs.gnu.org ([2001:4830:134:3::10]:41560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ciO0i-0002Qy-2M
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ciO0f-0002lY-C4
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:18:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ciO0f-0002l2-6r
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:18:49 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66266C05AA5B
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:18:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Feb 2017 17:18:34 +0100
Message-Id: <1488212323-26882-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] ui patch queue
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

Bringing some opengl improvements and fixes for gtk and vnc.

please pull,
  Gerd

The following changes since commit 3b1d8169844fafee184366b0e0d7080534758b=
4d:

  tests-aio-multithread: use atomic_read properly (2017-02-27 12:54:08 +0=
000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/pull-ui-20170227-1

for you to fetch changes up to 2dc120beb89b825033972db441ab540bcc42a17e:

  vnc: fix double free issues (2017-02-27 16:22:01 +0100)

----------------------------------------------------------------
gtk: fix kbd on xwayland
vnc: fix double free issues
opengl improvements

----------------------------------------------------------------
Daniel P. Berrange (1):
      ui: Use XkbGetMap and XkbGetNames instead of XkbGetKeyboard

Gerd Hoffmann (8):
      console: rename dpy_gl_scanout to dpy_gl_scanout_texture
      console: add dpy_gl_scanout_disable
      virtio-gpu: use dpy_gl_scanout_disable
      spice: add scanout_disable support
      sdl2: add scanout_disable support
      gtk-egl: add scanout_disable support
      spice: add display & head options
      vnc: fix double free issues

 hw/display/virtio-gpu-3d.c | 13 ++++----
 include/ui/console.h       | 21 ++++++++-----
 include/ui/gtk.h           | 25 +++++++++-------
 include/ui/sdl2.h          | 13 ++++----
 ui/console.c               | 30 ++++++++++++++-----
 ui/gtk-egl.c               | 25 +++++++++-------
 ui/gtk-gl-area.c           | 12 ++++----
 ui/gtk.c                   | 12 ++++----
 ui/sdl.c                   | 10 ++++---
 ui/sdl2-gl.c               | 28 +++++++++++-------
 ui/sdl2.c                  |  3 +-
 ui/spice-core.c            |  6 ++++
 ui/spice-display.c         | 74 +++++++++++++++++++++++++++++++---------=
------
 ui/vnc.c                   |  3 ++
 14 files changed, 178 insertions(+), 97 deletions(-)
