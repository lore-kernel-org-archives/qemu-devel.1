Received: from eggs.gnu.org ([2001:4830:134:3::10]:45614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emhFb-0000OG-Ss
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emhFb-0003nz-1c
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:44:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37304 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1emhFa-0003nk-TL
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 09:44:34 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC6A040FB652
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 14:44:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Feb 2018 15:44:13 +0100
Message-Id: <20180216144418.21986-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] keymap: support kbd layouts with multiple
 mappings for the same key.
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

The reverse keymap (-k $map) code has problems dealing with keymaps
where multiple key combinations can create the same keysym, because
it can store a single keycode per keysym only.  This series fixes it
and does some cleanups along the way.

Gerd Hoffmann (5):
  keymap: make struct kbd_layout_t private to ui/keymaps.c
  keymap: use glib hash for kbd_layout_t
  keymap: numpad keysyms and keycodes are fixed
  keymap: record multiple keysym -> keycode mappings
  keymap: consider modifier state when picking a mapping

 ui/keymaps.h    |  29 ++--------
 ui/curses.c     |   3 +-
 ui/keymaps.c    | 167 +++++++++++++++++++++++++++++---------------------------
 ui/sdl.c        |   6 +-
 ui/vnc.c        |   9 ++-
 ui/trace-events |   2 +-
 6 files changed, 108 insertions(+), 108 deletions(-)

-- 
2.9.3
