Received: from eggs.gnu.org ([209.51.188.92]:59350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glsVw-0006M9-NA
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glsM0-0003OM-Ql
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:28:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glsM0-0003MQ-Jy
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:28:20 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83D5680F91
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 09:28:19 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 22 Jan 2019 10:28:06 +0100
Message-Id: <20190122092814.14919-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v3 0/8] ui: add generic keyboard state
 tracker, fix keymap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

v3:
 - s/kbd/qkbd/ to avoid collisons.
 - add api docs.
 - misc minor fixes.

Gerd Hoffmann (8):
  kbd-state: add keyboard state tracker
  sdl2: remove sdl2_reset_keys() function
  kbd-state: use state tracker for sdl2
  sdl2: use only QKeyCode in sdl2_process_key()
  kbd-state: use state tracker for gtk
  kbd-state: use state tracker for vnc
  keymap: pass full keyboard state to keysym2scancode
  keymap: fix keyup mappings

 include/ui/gtk.h       |   2 +
 include/ui/kbd-state.h |  96 +++++++++++++++++++++++++++++++++++++
 include/ui/sdl2.h      |   3 +-
 ui/keymaps.h           |   3 +-
 ui/vnc.h               |   5 +-
 ui/curses.c            |   2 +-
 ui/gtk.c               |  38 +++------------
 ui/kbd-state.c         | 125 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 ui/keymaps.c           |  55 +++++++++++++---------
 ui/sdl2-input.c        |  50 ++------------------
 ui/sdl2.c              |  12 ++---
 ui/vnc.c               | 119 ++++++++++++-------------------------------=
---
 ui/Makefile.objs       |   2 +-
 13 files changed, 310 insertions(+), 202 deletions(-)
 create mode 100644 include/ui/kbd-state.h
 create mode 100644 ui/kbd-state.c

--=20
2.9.3
