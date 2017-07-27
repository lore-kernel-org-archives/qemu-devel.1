Received: from eggs.gnu.org ([2001:4830:134:3::10]:33569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dajLI-0003I5-Fm
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dajLE-0001s6-B5
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:00:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dajLE-0001rO-4M
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:00:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AA78C0D804E
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 14:00:38 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 27 Jul 2017 16:00:18 +0200
Message-Id: <20170727140025.392-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] Ui 20170727 patches
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

The following changes since commit 522fd24ca030c27c591dafedd65c1dfd51e404=
50:

  Update version for v2.10.0-rc0 release (2017-07-25 17:13:09 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20170727-pull-request

for you to fetch changes up to 7c388dbd0b2c54b3d836c23ea43e2cee38de66a4:

  ps2: fix sending of PAUSE/BREAK scancodes (2017-07-27 14:24:05 +0200)

----------------------------------------------------------------
ui: keymap fixes for 2.10

----------------------------------------------------------------

Daniel P. Berrange (1):
  ps2: fix sending of PAUSE/BREAK scancodes

Gerd Hoffmann (6):
  ui: add next and prior keysyms
  ui: move qemu_input_linux_to_qcode()
  ui: update keymaps
  ui: add multimedia keys
  ps2: enable multimedia keys
  ui: drop altgr and altgr_r QKeyCodes

 include/ui/input.h |   1 +
 ui/curses_keys.h   |   2 +
 ui/keymaps.h       |   1 +
 ui/vnc_keysym.h    |   2 +
 hw/char/escc.c     |   1 -
 hw/input/adb.c     |   1 -
 hw/input/ps2.c     |   6 --
 ui/input-keymap.c  | 169 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 ui/input-linux.c   | 113 -----------------------------------
 ui/spice-input.c   |  20 +++++++
 qapi-schema.json   |  31 +++++++++-
 11 files changed, 222 insertions(+), 125 deletions(-)

--=20
2.9.3
