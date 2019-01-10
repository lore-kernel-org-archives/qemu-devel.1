Received: from eggs.gnu.org ([209.51.188.92]:55133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghW3L-0008SN-6O
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghW0Q-00060f-5Z
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:48:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghW0P-00060E-I2
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:48:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C84A75D605
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 08:48:00 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 10 Jan 2019 09:47:44 +0100
Message-Id: <20190110084752.30510-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] Ui 20190110 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

The following changes since commit e59dbbac0364344a3ad84c3497a98c56003d3f=
b8:

  Merge remote-tracking branch 'remotes/philmd/tags/fw_cfg-20190104-pull-=
request' into staging (2019-01-04 18:23:13 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20190110-pull-request

for you to fetch changes up to 766a0a54faa97b8d4cbc7a6bd47f7ea78e625c19:

  spice: Remove unused include (2019-01-10 08:55:36 +0100)

----------------------------------------------------------------
ui: bugfixes, drop keymap include support, drop dead code.

----------------------------------------------------------------

Frediano Ziglio (1):
  spice: Remove unused include

Gerd Hoffmann (5):
  egl-headless: add egl_create_context
  keymaps: remove modifiers include
  keymaps: drop nl-be map
  keymaps: remove common include
  keymaps: drop support for include files

Marc-Andr=C3=A9 Lureau (1):
  configure: bump spice-server required version to 0.12.5

Peter Maydell (1):
  ui/console: Remove qemu_create_display_surface_guestmem()

 configure                 |   4 +-
 Makefile                  |   4 +-
 include/ui/console.h      |   4 --
 include/ui/qemu-spice.h   |   6 --
 chardev/spice.c           |  10 ---
 hw/display/qxl.c          |   2 -
 ui/console.c              |  36 ----------
 ui/egl-headless.c         |  10 ++-
 ui/keymaps.c              |   7 +-
 ui/spice-core.c           |   9 ---
 pc-bios/keymaps/common    | 157 ----------------------------------------
 pc-bios/keymaps/modifiers |  18 -----
 pc-bios/keymaps/nl-be     |   3 -
 pc-bios/keymaps/sl        | 177 ++++++++++++++++++++++++++++++++++++++++=
+++++-
 pc-bios/keymaps/sv        | 176 ++++++++++++++++++++++++++++++++++++++++=
++++-
 15 files changed, 367 insertions(+), 256 deletions(-)
 delete mode 100644 pc-bios/keymaps/common
 delete mode 100644 pc-bios/keymaps/modifiers
 delete mode 100644 pc-bios/keymaps/nl-be

--=20
2.9.3
