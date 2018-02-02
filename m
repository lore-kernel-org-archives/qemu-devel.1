Received: from eggs.gnu.org ([2001:4830:134:3::10]:43402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehce1-0004va-Rf
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:48:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehcdw-0005Za-T4
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:48:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ehcdw-0005Yu-Nt
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:48:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E26C47EA83
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 11:10:27 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  2 Feb 2018 12:10:10 +0100
Message-Id: <20180202111022.19269-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/12] rework display initialization,
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
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

  Hi,

This series is the first part of my the qemu display initialization
update.  Changes:

  * Create a QAPI DisplayOptions type for display configuration.
  * Switch all display initialization calls to accept DisplayOptions
    instead of a bunch of bools.

v2: add 'default' in the patch shich actually uses it (markus).

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
  vl: drop request_opengl variable
  vl: drop display_type variable

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
