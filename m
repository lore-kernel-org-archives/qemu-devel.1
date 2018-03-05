Received: from eggs.gnu.org ([2001:4830:134:3::10]:37877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eslnp-0003sq-FH
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:49:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eslno-0003dO-Iq
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:49:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34744 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eslno-0003dC-E6
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:49:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9E9A7B4AD
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 08:48:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  5 Mar 2018 09:48:31 +0100
Message-Id: <20180305084844.18222-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 00/13] Ui 20180305 patches
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

The following changes since commit 136c67e07869227b21b3f627316e03679ce7b738:

  Merge remote-tracking branch 'remotes/bkoppelmann/tags/pull-tricore-2018-03-02' into staging (2018-03-02 16:56:20 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180305-pull-request

for you to fetch changes up to 96400a148b3e1337e2c451e95bc3c3c69a05b67c:

  ui/sdl: build as module (2018-03-05 08:44:11 +0100)

----------------------------------------------------------------
ui: build curses, gtk and sdl as modules.

----------------------------------------------------------------

Gerd Hoffmann (13):
  console: add qemu display registry, add gtk
  sdl: switch over to new display registry
  cocoa: switch over to new display registry
  curses: switch over to new display registry
  egl-headless: switch over to new display registry
  console: add and use qemu_display_find_default
  console: add ui module loading support
  configure: add X11 vars to config-host.mak
  configure: opengl doesn't depend on x11
  ui/gtk: build as module
  ui/curses: build as module
  audio: rename CONFIG_* to CONFIG_AUDIO_*
  ui/sdl: build as module

 configure                      | 31 +++++++++--------
 Makefile.objs                  |  1 +
 audio/audio_int.h              |  2 +-
 include/qemu/module.h          |  1 +
 include/ui/console.h           | 75 +++++++-----------------------------------
 ui/console.c                   | 59 +++++++++++++++++++++++++++++++++
 ui/curses.c                    | 14 +++++++-
 ui/egl-headless.c              | 20 ++++++++++-
 ui/gtk.c                       | 17 ++++++++--
 ui/sdl.c                       | 24 +++++++-------
 ui/sdl2.c                      | 17 ++++++++--
 vl.c                           | 74 +++++++----------------------------------
 audio/Makefile.objs            | 12 +++----
 target/unicore32/Makefile.objs |  4 +++
 ui/Makefile.objs               | 31 ++++++++++-------
 ui/cocoa.m                     | 14 +++++++-
 16 files changed, 220 insertions(+), 176 deletions(-)

-- 
2.9.3
