Received: from eggs.gnu.org ([2001:4830:134:3::10]:54465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQZhw-0004yX-GS
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQZht-0008RN-Hz
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cQZht-0008Qs-CA
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:09:49 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AA54811A9
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 13:09:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  9 Jan 2017 14:09:34 +0100
Message-Id: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/11] ui patch queue
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

v2 changes:  Replace the ps2 fix (v3 instead of v2 of the patch).

please pull,
  Gerd

The following changes since commit dbe2b65566e76d3c3a0c3358285c0336ac61e7=
57:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-req=
uest' into staging (2016-12-28 17:11:11 +0000)

are available in the git repository at:


  git://git.kraxel.org/qemu tags/pull-ui-20170109-1

for you to fetch changes up to f46c4259f489d2e7742890ddfaa862bde3731e3e:

  ps2: Fix lost scancodes by recent changes (2017-01-06 10:36:49 +0100)

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
 hw/input/ps2.c       | 10 ++++++++++
 include/ui/console.h | 12 ++++++++----
 include/ui/gtk.h     |  4 ++++
 qapi-schema.json     |  6 +++++-
 ui/console.c         | 11 +++++++++++
 ui/curses.c          |  1 -
 ui/egl-helpers.c     | 16 ++++++++++++++++
 ui/gtk.c             | 18 +++++++++++++++++-
 ui/input-keymap.c    |  3 +++
 ui/sdl.c             | 25 +++++++++++++++++++++++++
 ui/sdl2.c            |  7 +++++++
 ui/vnc.c             |  8 ++++++--
 13 files changed, 120 insertions(+), 32 deletions(-)
