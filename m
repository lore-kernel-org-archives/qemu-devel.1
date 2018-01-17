Received: from eggs.gnu.org ([2001:4830:134:3::10]:52211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebqs9-0002cB-Co
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:47:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebqs5-0002S2-EL
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:47:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebqs5-0002Rd-8G
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:47:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 529152FA0
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 16:47:28 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 17 Jan 2018 16:47:13 +0000
Message-Id: <20180117164717.15855-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v7 0/4] Convert frontends to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is a followup to

  v1: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02047.html
  v2: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02471.html
  v3: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02517.html
  v4: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02708.html
  v5: https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg02950.html
  v6: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg01988.html

This new series contains just the patches for converting the ui frontends
for SDL1, SDL2, and GTK to use keycodemapdb.

The particularly notable benefit is that this includes fixes such that SDL1
and GTK2/3 can actually work when using a non-Linux host Xorg/X11 server.
Previously it would display but key handling was complete garbage, making it
unusable in practice.

Changed in v7:

 - Fix syntax error in win32 hack

Daniel P. Berrange (4):
  ui: convert the SDL2 frontend to keycodemapdb
  ui: convert GTK and SDL1 frontends to keycodemapdb
  ui: add fix for GTK Pause key handling on Win32
  ui: ignore hardware keycode 255 on win32

 Makefile           |   8 ++
 include/ui/input.h |  24 +++++
 ui/Makefile.objs   |   5 +-
 ui/gtk.c           | 220 ++++++++++++++++++++++++++-----------------
 ui/input-keymap.c  |   8 ++
 ui/sdl.c           | 105 +++++++--------------
 ui/sdl2-input.c    |  16 +++-
 ui/sdl2-keymap.h   | 267 -----------------------------------------------------
 ui/trace-events    |   9 +-
 ui/x_keymap.c      | 250 +++++++++++++++++++------------------------------
 ui/x_keymap.h      |   8 +-
 11 files changed, 330 insertions(+), 590 deletions(-)
 delete mode 100644 ui/sdl2-keymap.h

-- 
2.14.3
