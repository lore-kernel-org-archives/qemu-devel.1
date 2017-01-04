Received: from eggs.gnu.org ([2001:4830:134:3::10]:52365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOjdJ-0001hz-MQ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOjdI-0001sf-I9
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOjdI-0001sJ-C1
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:28 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 580058DEED
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 11:21:28 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed,  4 Jan 2017 12:21:12 +0100
Message-Id: <1483528883-1753-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/11] ui patch queue
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

Here comes the ui patch queue with a bunch of small changes and fixes
all over the place: gtk, vnc, curses, sdl, keyboard.

please pull,
  Gerd

The following changes since commit dbe2b65566e76d3c3a0c3358285c0336ac61e7=
57:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-req=
uest' into staging (2016-12-28 17:11:11 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-ui-20170104-1

for you to fetch changes up to df07469e471a8a02b5b1dd23d73600bf32037ce3:

  curses: Fix compiler warnings (Mingw-w64 redefinition of macro KEY_EVEN=
T) (2017-01-04 10:09:27 +0100)

----------------------------------------------------------------
gtk,vnc: misc bugfixes.
kbd: add jp keys, fix ps2 regressions.
sdl: export window id for baum, remove sdl hooks from baum.
egl: egl-helpers.c license change.

----------------------------------------------------------------
Daniel P. Berrange (1):
      ui: use evdev keymap when running under wayland

Frediano Ziglio (1):
      egl-helpers: Change file licensing to LGPLv2

Gerd Hoffmann (1):
      ui: drop unused MOUSE_EVENT_WHEEL{UP, DN} defines

Herv=C3=A9 Poussineau (1):
      ui/gtk: fix crash at startup when no console is available

Marc-Andr=C3=A9 Lureau (1):
      gtk: avoid oob array access

OGAWA Hirofumi (1):
      ps2: Fix lost scancodes by recent changes

Samuel Thibault (3):
      console: add API to get underlying gui window ID
      console: move window ID code from baum to sdl
      sdl2: set window ID

Stefan Weil (1):
      curses: Fix compiler warnings (Mingw-w64 redefinition of macro KEY_=
EVENT)

Thomas Huth (1):
      ui/vnc: Fix problem with sending too many bytes as server name

 backends/baum.c      | 31 ++++++++-----------------------
 hw/input/ps2.c       |  3 +++
 include/ui/console.h | 12 ++++++++----
 include/ui/gtk.h     |  4 ++++
 qapi-schema.json     |  3 ++-
 ui/console.c         | 11 +++++++++++
 ui/curses.c          |  1 -
 ui/egl-helpers.c     | 16 ++++++++++++++++
 ui/gtk.c             | 18 +++++++++++++++++-
 ui/input-keymap.c    |  3 +++
 ui/sdl.c             | 25 +++++++++++++++++++++++++
 ui/sdl2.c            |  7 +++++++
 ui/vnc.c             |  8 ++++++--
 13 files changed, 110 insertions(+), 32 deletions(-)
