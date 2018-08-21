Received: from eggs.gnu.org ([2001:4830:134:3::10]:39942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1Lr-0001eB-Br
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1Ln-0002hd-U7
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:45:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41232 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs1Ln-0002h0-NL
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:45:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2124087927
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 07:45:15 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Aug 2018 09:44:57 +0200
Message-Id: <20180821074509.22688-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/12] Ui 20180821 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit d0092d90eb546a8bbe9e9120426c1894741237=
97:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180820' into =
staging (2018-08-20 17:41:18 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180821-pull-request

for you to fetch changes up to 8a674d96a572c7ec1219a24ef223160dc6a27ca8:

  util: promote qemu_egl_rendernode_open() to libqemuutil (2018-08-21 08:=
24:30 +0200)

----------------------------------------------------------------
ui: misc ui fixed which piled up during 3.0 release freeze.

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (2):
  doc: switch to modern syntax for VNC TLS setup
  vnc: remove support for deprecated tls, x509, x509verify options

Marc-Andr=C3=A9 Lureau (3):
  ui: use enum to string helpers
  dmabuf: add y0_top, pass it to spice
  util: promote qemu_egl_rendernode_open() to libqemuutil

Paolo Bonzini (2):
  spice-display: access ptr_x/ptr_y under Mutex
  spice-display: fix qemu_spice_cursor_refresh_bh locking

Peter Wu (1):
  vnc: fix memleak of the "vnc-worker-output" name

Philippe Mathieu-Daud=C3=A9 (1):
  ui/vnc: Remove useless parenthesis around DIV_ROUND_UP macro

Tao Wu via Qemu-devel (1):
  sdl2: redraw correctly when scanout_mode enabled.

Thomas Huth (2):
  ui/sdl2: Remove the obsolete SDL_INIT_NOPARACHUTE flag
  ui/sdl2: Fix broken -full-screen CLI option

 include/qemu/drm.h   |  6 ++++
 include/ui/console.h |  1 +
 qemu-keymap.c        |  2 +-
 ui/console.c         |  6 ++--
 ui/egl-helpers.c     | 51 ++--------------------------
 ui/sdl2-gl.c         |  5 +++
 ui/sdl2.c            | 13 +++-----
 ui/spice-display.c   | 40 ++++++++++++++--------
 ui/vnc-enc-tight.c   |  2 +-
 ui/vnc-jobs.c        |  3 +-
 ui/vnc.c             | 94 ++--------------------------------------------=
------
 util/drm.c           | 66 ++++++++++++++++++++++++++++++++++++
 MAINTAINERS          |  1 +
 qemu-deprecated.texi | 20 -----------
 qemu-doc.texi        | 20 ++++++++---
 qemu-options.hx      | 43 ------------------------
 util/Makefile.objs   |  1 +
 17 files changed, 138 insertions(+), 236 deletions(-)
 create mode 100644 include/qemu/drm.h
 create mode 100644 util/drm.c

--=20
2.9.3
