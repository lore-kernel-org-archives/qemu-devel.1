Received: from eggs.gnu.org ([2001:4830:134:3::10]:51152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eeiZp-0005Ug-PU
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:32:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eeiZk-0006rT-15
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:32:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eeiZj-0006qV-Sw
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:32:23 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32C2DC0528DC
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 14:32:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 25 Jan 2018 15:32:10 +0100
Message-Id: <20180125143218.29528-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] Ui 20180125 patches
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

The following changes since commit 834a336eb911db8a8ca00e760ee6a85faca194=
14:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2018-01-24 19:24:26 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180125-pull-request

for you to fetch changes up to 04ff1a398a8d6e912eceaca9b62af0a09e927d63:

  sdl: reorganize -no-frame support (2018-01-25 15:22:28 +0100)

----------------------------------------------------------------
ui: convert to keycodedb, fix sign extension
sdl: cleanups, deprecate sdl 1.2

----------------------------------------------------------------

Daniel P. Berrange (6):
  ui: avoid sign extension using client width/height
  ui: convert the SDL2 frontend to keycodemapdb
  ui: convert GTK and SDL1 frontends to keycodemapdb
  ui: add fix for GTK Pause key handling on Win32
  ui: ignore hardware keycode 255 on win32
  ui: deprecate use of SDL 1.2 in favour of 2.0 series

Gerd Hoffmann (2):
  sdl: use ctrl-alt-g as grab hotkey
  sdl: reorganize -no-frame support

 configure               |   6 ++
 Makefile                |   8 ++
 include/sysemu/sysemu.h |   1 +
 include/ui/console.h    |   5 +-
 include/ui/input.h      |  24 +++++
 ui/sdl2-keymap.h        | 267 ------------------------------------------=
------
 ui/vnc.h                |   4 +-
 ui/x_keymap.h           |   8 +-
 ui/gtk.c                | 220 ++++++++++++++++++++++++---------------
 ui/input-keymap.c       |   8 ++
 ui/sdl.c                | 145 +++++++++-----------------
 ui/sdl2-input.c         |  16 ++-
 ui/sdl2.c               |  34 +++---
 ui/vnc.c                |   9 ++
 ui/x_keymap.c           | 250 +++++++++++++++++-------------------------=
---
 vl.c                    |   4 +-
 qemu-doc.texi           |   7 ++
 ui/Makefile.objs        |   5 +-
 ui/trace-events         |   9 +-
 19 files changed, 389 insertions(+), 641 deletions(-)
 delete mode 100644 ui/sdl2-keymap.h

--=20
2.9.3
