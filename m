Received: from eggs.gnu.org ([2001:4830:134:3::10]:35812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXoSM-0000F2-GG
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXoSJ-0000sF-7M
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:56:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fXoSJ-0000rV-2M
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:56:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 096CE81A4EA5
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 13:56:26 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 26 Jun 2018 15:56:22 +0200
Message-Id: <20180626135625.7078-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Ui 20180626 patches
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

The following changes since commit 595123df1d54ed8fbab9e1a73d5a58c5bb71058f:

  Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2018-06-26 09:45:14 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180626-pull-request

for you to fetch changes up to 49213b721f4620364aa09142b5f4d559fed26b53:

  sdl2: add checking for NULL (2018-06-26 13:48:49 +0200)

----------------------------------------------------------------
ui: sdl2 fixes, gles support.

----------------------------------------------------------------

Gerd Hoffmann (1):
  Add gles support to egl-helpers, wire up in egl-headless and gtk.

Pavel Dovgalyuk (2):
  sdl2: fix copypaste issues
  sdl2: add checking for NULL

 include/ui/egl-helpers.h |  7 +++---
 include/ui/gtk.h         |  2 +-
 ui/egl-context.c         | 11 ++++++++--
 ui/egl-headless.c        |  3 ++-
 ui/egl-helpers.c         | 55 ++++++++++++++++++++++++++++++++++--------------
 ui/gtk-egl.c             |  4 ++--
 ui/gtk.c                 |  7 ++----
 ui/sdl2.c                | 14 ++++++------
 ui/spice-core.c          |  3 ++-
 9 files changed, 68 insertions(+), 38 deletions(-)

-- 
2.9.3
