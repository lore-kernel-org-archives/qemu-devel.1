Received: from eggs.gnu.org ([2001:4830:134:3::10]:50279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoo2E-0003J7-ME
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoo2B-0001zU-C8
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40848 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoo2B-0001yQ-59
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C365140201A0
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 10:23:22 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 22 Feb 2018 11:23:08 +0100
Message-Id: <20180222102317.25776-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] Ui 20180222 patches
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

The following changes since commit a6e0344fa0e09413324835ae122c4cadd78902=
31:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180220-pull-requ=
est' into staging (2018-02-20 14:05:00 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180222-pull-request

for you to fetch changes up to abb4f2c9655503f14dc55064f29c4f59b07e96ff:

  keymap: consider modifier state when picking a mapping (2018-02-22 10:3=
5:32 +0100)

----------------------------------------------------------------
ui: reverse keymap improvements.
sdl2: hotkey fix.
opengl: dmabuf fixes.

----------------------------------------------------------------

Gerd Hoffmann (9):
  sdl2: fix hotkey keyup
  console/opengl: split up dpy_gl_cursor ops
  egl-headless: cursor_dmabuf: handle NULL cursor
  egl-helpers: add alpha channel to texture format
  keymap: make struct kbd_layout_t private to ui/keymaps.c
  keymap: use glib hash for kbd_layout_t
  keymap: numpad keysyms and keycodes are fixed
  keymap: record multiple keysym -> keycode mappings
  keymap: consider modifier state when picking a mapping

 include/ui/console.h |  13 ++--
 ui/keymaps.h         |  30 +++-------
 ui/console.c         |  18 ++++--
 ui/curses.c          |   3 +-
 ui/egl-headless.c    |  30 ++++++----
 ui/egl-helpers.c     |   2 +-
 ui/keymaps.c         | 163 ++++++++++++++++++++++++++-------------------=
------
 ui/sdl.c             |   6 +-
 ui/sdl2.c            |  14 +----
 ui/vnc.c             |   9 ++-
 ui/trace-events      |   2 +-
 11 files changed, 151 insertions(+), 139 deletions(-)

--=20
2.9.3
