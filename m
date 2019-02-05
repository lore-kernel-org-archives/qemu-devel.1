Received: from eggs.gnu.org ([209.51.188.92]:42552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQq-0007N3-Ok
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQm-0006Fv-VF
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12835)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqyQd-00066t-4F
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:12 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  5 Feb 2019 11:57:44 +0100
Message-Id: <20190205105758.4230-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] Ui 20190205 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 773c4a6228fd910556cee2d477ee56c591a300=
00:

  test-filter-mirror: pass UNIX domain socket through fd (2019-02-04 16:0=
3:20 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20190205-pull-request

for you to fetch changes up to 19c1b9fd3dd5955893c0d3c187a4180313e9a0f1:

  keymap: fix keyup mappings (2019-02-05 10:45:44 +0100)

----------------------------------------------------------------
ui: add kbd stats tracker.
ui: gtk scroll fixes.
ui: egl cursor scale fix.
ui: more sdl1 cleanup.

----------------------------------------------------------------

Brendan Shanks (1):
  ui/cocoa.m: Fix macOS 10.14 deprecation warnings

Chen Zhang (1):
  ui/egl-helpers: Augment parameter list of egl_texture_blend() to
    convey scales of viewport

Gerd Hoffmann (8):
  kbd-state: add keyboard state tracker
  sdl2: remove sdl2_reset_keys() function
  kbd-state: use state tracker for sdl2
  sdl2: use only QKeyCode in sdl2_process_key()
  kbd-state: use state tracker for gtk
  kbd-state: use state tracker for vnc
  keymap: pass full keyboard state to keysym2scancode
  keymap: fix keyup mappings

Sergio Lopez (2):
  ui: don't send any event if delta_y =3D=3D 0
  ui: listen for GDK_SMOOTH_SCROLL events

Thomas Huth (2):
  Remove deprecated -no-frame option
  ui/sdl_keysym: Remove obsolete SDL1.2 related code

 include/sysemu/sysemu.h  |   1 -
 include/ui/egl-helpers.h |   2 +-
 include/ui/gtk.h         |   2 +
 include/ui/kbd-state.h   | 101 +++++++++++++++++
 include/ui/sdl2.h        |   3 +-
 ui/keymaps.h             |   3 +-
 ui/sdl_keysym.h          | 278 -----------------------------------------=
------
 ui/vnc.h                 |   5 +-
 ui/curses.c              |   2 +-
 ui/egl-headless.c        |   3 +-
 ui/egl-helpers.c         |   9 +-
 ui/gtk-egl.c             |   3 +-
 ui/gtk.c                 |  43 ++------
 ui/kbd-state.c           | 130 ++++++++++++++++++++++
 ui/keymaps.c             |  55 ++++++----
 ui/sdl2-input.c          |  50 +--------
 ui/sdl2.c                |  12 +-
 ui/spice-display.c       |   2 +-
 ui/vnc.c                 | 119 ++++++--------------
 vl.c                     |  23 +---
 qemu-deprecated.texi     |   6 -
 qemu-options.hx          |  11 --
 ui/Makefile.objs         |   2 +-
 ui/cocoa.m               |  28 ++++-
 24 files changed, 360 insertions(+), 533 deletions(-)
 create mode 100644 include/ui/kbd-state.h
 delete mode 100644 ui/sdl_keysym.h
 create mode 100644 ui/kbd-state.c

--=20
2.9.3
