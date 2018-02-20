Received: from eggs.gnu.org ([2001:4830:134:3::10]:47856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Gj-0005HC-Lg
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Gi-00072I-JK
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33826 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo8Gi-00071s-De
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C543FEB6F0
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:47:28 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 14:47:11 +0100
Message-Id: <20180220134723.11776-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 00/12] Ui 20180220 patches
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

The following changes since commit afd3397a8149d8b645004e459bf2002d78f5e267:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2018-02-19 16:44:12 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180220-pull-request

for you to fetch changes up to 63ad932567df012ff4bf820a9ed0e2affd9dc5af:

  ui: Reorder vte terminal packing to avoid gtk3 warnings (2018-02-20 12:16:11 +0100)

----------------------------------------------------------------
ui: reorganize and cleanup display command line parsing.
gtk: fix gtk3 warnings.

----------------------------------------------------------------

Gerd Hoffmann (11):
  vl: deprecate -no-frame
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

Jan Kiszka (1):
  ui: Reorder vte terminal packing to avoid gtk3 warnings

 include/ui/console.h |  27 ++++++------
 ui/curses.c          |   2 +-
 ui/egl-headless.c    |   2 +-
 ui/gtk.c             |  36 +++++++++-------
 ui/sdl.c             |  19 +++++---
 ui/sdl2.c            |  33 ++++++++------
 vl.c                 | 119 ++++++++++++++++++++++++---------------------------
 qapi/ui.json         |  64 +++++++++++++++++++++++++++
 qemu-doc.texi        |   7 +++
 ui/cocoa.m           |   4 +-
 10 files changed, 196 insertions(+), 117 deletions(-)

-- 
2.9.3
