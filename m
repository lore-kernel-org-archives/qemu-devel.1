Received: from eggs.gnu.org ([2001:4830:134:3::10]:50847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5TIP-0005d8-3L
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5TIN-0003ca-UN
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:41:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55166 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5TIN-0003cJ-Pz
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:41:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FFC74023BAD
	for <qemu-devel@nongnu.org>; Mon,  9 Apr 2018 09:41:03 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  9 Apr 2018 11:40:54 +0200
Message-Id: <20180409094100.27650-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/6] Ui 20180409 patches
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

The following changes since commit 094b62cd9cd9f137cf75b4931e41b8953fb4ccd9:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-04-04 11:13:52 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180409-pull-request

for you to fetch changes up to 1458da9131c39ca99699b521436d6ce72d7c7981:

  sdl2: drop dead code (2018-04-09 10:40:47 +0200)

----------------------------------------------------------------
sdl2: fix kbd regression (compared to sdl1), cleanups.

----------------------------------------------------------------

Elie Tournier (1):
  sdl2: Remove unused epoxy include

Gerd Hoffmann (5):
  ui: add ctrl modifier support to kbd_put_qcode_console()
  sdl2: track kbd modifier state unconditionally
  sdl2: enable ctrl modifier keys for text consoles
  sdl2: drop QEMU_KEY_BACKSPACE special case
  sdl2: drop dead code

 include/ui/console.h |  2 +-
 ui/console.c         | 15 +++++++++++++--
 ui/gtk.c             |  4 ++--
 ui/sdl2-gl.c         |  2 --
 ui/sdl2-input.c      | 46 ++++++++++++++++++++--------------------------
 5 files changed, 36 insertions(+), 33 deletions(-)

-- 
2.9.3
