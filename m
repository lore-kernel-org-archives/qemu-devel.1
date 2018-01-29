Received: from eggs.gnu.org ([2001:4830:134:3::10]:45815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCEE-0007yE-9s
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCE9-0002OJ-IB
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egCE9-0002Ni-Bw
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A76BA78EC1
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 16:24:12 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Jan 2018 17:23:56 +0100
Message-Id: <20180129162408.415-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/12] rework display initialization,
 part one
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

  Hi,

This series is the first part of my the qemu display initialization
update.  Changes:

  * Create a QAPI DisplayOptions type for display configuration.
  * Switch all display initialization calls to accept DisplayOptions
    instead of a bunch of bools.

Coming soon, building on top of the above:

  * Add a registry for displays, and remove alot of #ifdefs from vl.c
  * Build sdl, gtk and curses as modules.

cheers,
  Gerd

Gerd Hoffmann (12):
  vl: deprecate -no-frame
  vl: deprecate -alt-grab and -ctrl-grab
  vl: rename DisplayType to LegacyDisplayType
  gtk: add and use DisplayOptions + DisplayGTK
  sdl: use DisplayOptions
  vl: drop no_quit variable
  egl-headless: use DisplayOptions
  curses: use DisplayOptions
  cocoa: use DisplayOptions
  vl: drop full_screen variable
  vl: drop display_type variable
  vl: drop request_opengl variable

 include/ui/console.h |  27 ++++++-----
 ui/curses.c          |   2 +-
 ui/egl-headless.c    |   2 +-
 ui/gtk.c             |  32 +++++++------
 ui/sdl.c             |  19 +++++---
 ui/sdl2.c            |  33 +++++++------
 vl.c                 | 127 ++++++++++++++++++++++++++-------------------------
 qapi/ui.json         |  64 ++++++++++++++++++++++++++
 qemu-doc.texi        |  13 ++++++
 ui/cocoa.m           |   4 +-
 10 files changed, 208 insertions(+), 115 deletions(-)

-- 
2.9.3
