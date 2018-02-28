Received: from eggs.gnu.org ([2001:4830:134:3::10]:60728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1er0ff-0007mH-VS
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1er0fc-0002Ge-Tx
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:17:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1er0fc-0002F8-Me
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:17:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49394402291E
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 12:17:11 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 28 Feb 2018 13:16:52 +0100
Message-Id: <20180228121703.20816-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 00/11] Ui 20180228 patches
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

The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5af8c5c2a6d0:

  maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180228-pull-request

for you to fetch changes up to 6b59af25063d9affb433b4febb8d706a62713680:

  curses: build as ui module (2018-02-28 07:21:44 +0100)

----------------------------------------------------------------
ui: add & use display registry, build some UIs as module.

----------------------------------------------------------------

Gerd Hoffmann (11):
  console: add qemu display registry, add gtk
  sdl: switch over to new display registry
  cocoa: switch over to new display registry
  curses: switch over to new display registry
  egl-headless: switch over to new display registry
  console: add and use qemu_display_find_default
  console: add ui module loading support
  configure: add X11 vars to config-host.mak
  configure: opengl doesn't depend on x11
  gtk: build as ui module
  curses: build as ui module

 configure             | 27 +++++++++++--------
 include/qemu/module.h |  1 +
 include/ui/console.h  | 75 ++++++++-------------------------------------------
 ui/console.c          | 59 ++++++++++++++++++++++++++++++++++++++++
 ui/curses.c           | 14 +++++++++-
 ui/egl-headless.c     | 20 +++++++++++++-
 ui/gtk.c              | 17 ++++++++++--
 ui/sdl.c              | 24 +++++++++--------
 ui/sdl2.c             | 17 ++++++++++--
 vl.c                  | 74 ++++++++------------------------------------------
 ui/Makefile.objs      | 28 ++++++++++++-------
 ui/cocoa.m            | 14 +++++++++-
 12 files changed, 204 insertions(+), 166 deletions(-)

-- 
2.9.3
