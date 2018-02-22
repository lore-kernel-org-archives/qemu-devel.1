Received: from eggs.gnu.org ([2001:4830:134:3::10]:32887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eokwd-00089r-41
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eokwc-00087k-AU
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:05:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eokwc-00087C-1Q
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:05:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96A2E818B131
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 07:05:18 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 22 Feb 2018 08:05:08 +0100
Message-Id: <20180222070513.8740-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/5] keymap: support kbd layouts with
 multiple mappings for the same key.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

The reverse keymap (-k $map) code has problems dealing with keymaps
where multiple key combinations can create the same keysym, because
it can store a single keycode per keysym only.  This series fixes it
and does some cleanups along the way.

v2: rebase, codestyle fixes.
v3: use GINT_TO_POINTER

Gerd Hoffmann (5):
  keymap: make struct kbd_layout_t private to ui/keymaps.c
  keymap: use glib hash for kbd_layout_t
  keymap: numpad keysyms and keycodes are fixed
  keymap: record multiple keysym -> keycode mappings
  keymap: consider modifier state when picking a mapping

 ui/keymaps.h    |  30 +++--------
 ui/curses.c     |   3 +-
 ui/keymaps.c    | 163 +++++++++++++++++++++++++++++---------------------=
------
 ui/sdl.c        |   6 ++-
 ui/vnc.c        |   9 +++-
 ui/trace-events |   2 +-
 6 files changed, 105 insertions(+), 108 deletions(-)

--=20
2.9.3
