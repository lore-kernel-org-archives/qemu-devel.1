Received: from eggs.gnu.org ([209.51.188.92]:60540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx5eQ-0006yB-8g
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx5eN-0001aZ-Kk
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx5eM-0001Kp-Ls
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8792D70D6D
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 07:53:27 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Feb 2019 08:53:11 +0100
Message-Id: <20190222075326.9850-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/15] Ui 20190222 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit 2e68b8620637a4ee8c79b5724144b726af1e26=
1b:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20190219=
' into staging (2019-02-18 16:20:13 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20190222-pull-request

for you to fetch changes up to d8aec9d9f129e6879ae0669623981892deff86f2:

  display: add -display spice-app launching a Spice client (2019-02-22 07=
:42:59 +0100)

----------------------------------------------------------------
ui: add support for -display spice-app
ui: gtk+sdl bugfixes.

----------------------------------------------------------------

Gerd Hoffmann (2):
  kbd-state: don't block auto-repeat events
  sdl2: drop qemu_input_event_send_key_qcode call

Luk=C3=A1=C5=A1 Hr=C3=A1zk=C3=BD (1):
  spice: set device address and device display ID in QXL interface

Marc-Andr=C3=A9 Lureau (11):
  char/spice: trigger HUP event
  char/spice: discard write() if backend is disconnected
  spice: avoid spice runtime assert
  spice: merge options lists
  spice: do not stop spice if VM is paused
  char: move SpiceChardev and open_spice_port() to spice.h header
  char: register spice ports after spice started
  build-sys: add gio-2.0 check
  qapi: document DisplayType enum
  spice: use a default name for the server
  display: add -display spice-app launching a Spice client

Thomas Huth (1):
  ui/gtk: Fix the license information

 configure                  |  13 +++
 include/chardev/spice.h    |  27 ++++++
 include/ui/spice-display.h |   4 +
 chardev/spice.c            |  60 ++++++++------
 hw/display/qxl.c           |  14 +++-
 ui/gtk.c                   |  30 +++----
 ui/kbd-state.c             |  16 ++--
 ui/sdl2-input.c            |   3 -
 ui/spice-app.c             | 202 +++++++++++++++++++++++++++++++++++++++=
++++++
 ui/spice-core.c            |  64 +++++++++++++-
 ui/spice-display.c         |  11 +++
 chardev/trace-events       |   1 +
 qapi/ui.json               |  32 ++++++-
 qemu-options.hx            |   5 ++
 ui/Makefile.objs           |   5 ++
 15 files changed, 433 insertions(+), 54 deletions(-)
 create mode 100644 include/chardev/spice.h
 create mode 100644 ui/spice-app.c

--=20
2.9.3
