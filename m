Received: from eggs.gnu.org ([2001:4830:134:3::10]:44758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZaf9-0003IT-R1
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZaf2-0000A8-Gw
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gZaf0-00009C-KV
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:09:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F146B83F3D
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 12:09:09 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 19 Dec 2018 13:08:57 +0100
Message-Id: <20181219120904.17643-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 0/7] ui: add generic keyboard state
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



Gerd Hoffmann (7):
  kbd-state: add keyboard state tracker
  kbd-state: use state tracker for sdl2
  sdl2: use only QKeyCode in sdl2_process_key()
  kbd-state: use state tracker for gtk
  kbd-state: use state tracker for vnc
  keymap: pass full keyboard state to keysym2scancode
  keymap: fix keyup mappings

 include/ui/gtk.h       |   2 +
 include/ui/kbd-state.h |  32 +++++++++++++
 include/ui/sdl2.h      |   2 +
 ui/keymaps.h           |   3 +-
 ui/vnc.h               |   5 +-
 ui/curses.c            |   2 +-
 ui/gtk.c               |  38 +++------------
 ui/kbd-state.c         | 125 +++++++++++++++++++++++++++++++++++++++++++++++++
 ui/keymaps.c           |  55 +++++++++++++---------
 ui/sdl2-input.c        |  47 +++----------------
 ui/sdl2.c              |  12 ++---
 ui/vnc.c               | 119 ++++++++++++----------------------------------
 ui/Makefile.objs       |   2 +-
 13 files changed, 247 insertions(+), 197 deletions(-)
 create mode 100644 include/ui/kbd-state.h
 create mode 100644 ui/kbd-state.c

-- 
2.9.3
