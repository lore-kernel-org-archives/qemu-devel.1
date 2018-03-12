Received: from eggs.gnu.org ([2001:4830:134:3::10]:49918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evJX9-0007C6-Mq
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evJX5-0004Y6-2p
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evJX4-0004Vw-U1
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 640384023155
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:14:11 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Mar 2018 10:13:51 +0100
Message-Id: <20180312091405.19610-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] Ui 20180312 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit e4ae62b802cec437f877f2cadc4ef059cc0eca=
76:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2018-03-09 17:28:16 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180312-pull-request

for you to fetch changes up to f771c5440e04626f1cf9a6a7d1b1c6cd8168cacd:

  qapi: Add device ID and head parameters to screendump (2018-03-12 09:03=
:15 +0100)

----------------------------------------------------------------
gtk,spice: add dmabuf support.
sdl,vnc,gtk: bugfixes.
ui/qapi: add device ID and head parameters to screendump.
build: try improve handling of clang warnings.

----------------------------------------------------------------

Bruce Rogers (1):
  make: switch language file build to be gtk module aware

Gerd Hoffmann (12):
  build: try improve handling of clang warnings
  sdl: workaround bug in sdl 2.0.8 headers
  ui/gtk: make GtkGlArea usage a runtime option
  ui/gtk: group gtk.mo declarations in Makefile
  ui/opengl: Makefile cleanup
  ui/gtk: use GtkGlArea on wayland only
  ui/gtk-egl: add scanout_dmabuf support
  ui/gtk-egl: add cursor_dmabuf support
  vnc: deal with surface NULL pointers
  spice: drop dprint() debug logging
  spice: add scanout_dmabuf support
  spice: add cursor_dmabuf support

Thomas Huth (1):
  qapi: Add device ID and head parameters to screendump

 configure                  |   3 +-
 Makefile                   |   2 +-
 include/ui/console.h       |   2 +
 include/ui/gtk.h           |  14 ++++
 include/ui/spice-display.h |   9 +++
 hmp.c                      |   4 +-
 ui/console.c               |  34 +++++---
 ui/gtk-egl.c               |  63 ++++++++++++++-
 ui/gtk.c                   |  68 +++++++++-------
 ui/spice-display.c         | 194 ++++++++++++++++++++++++++++++++-------=
------
 ui/vnc.c                   |  10 +++
 util/coroutine-ucontext.c  |   4 +-
 hmp-commands.hx            |   7 +-
 qapi/ui.json               |  10 ++-
 ui/Makefile.objs           |  25 +++---
 ui/trace-events            |  12 +++
 16 files changed, 349 insertions(+), 112 deletions(-)

--=20
2.9.3
