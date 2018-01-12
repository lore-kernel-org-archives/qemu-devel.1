Received: from eggs.gnu.org ([2001:4830:134:3::10]:40991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ea0hd-0003lS-AN
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ea0ha-0005e1-Mb
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ea0ha-0005d5-Gp
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:53:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A126312E4E9
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 14:53:01 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 15:52:49 +0100
Message-Id: <20180112145258.10578-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/9] Ui 20180112 patches
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

The following changes since commit 997eba28a3ed5400a80f754bf3a1c8044b75b9ff:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180111' into staging (2018-01-11 14:34:41 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180112-pull-request

for you to fetch changes up to 849bbe60356caf3d320202d45f1ddffeefae06c7:

  sdl2: Ignore UI hotkeys after a focus change when GUI modifier is held (2018-01-12 15:51:18 +0100)

----------------------------------------------------------------
sdl2: bugfixes.
spice: cleanups.
input: mem leak fix.
gtk: deprecate 2.x support.

----------------------------------------------------------------

Daniel P. Berrange (1):
  ui: deprecate use of GTK 2.x in favour of 3.x series

Frediano Ziglio (4):
  spice: remove QXLWorker interface field
  spice: remove unused watch list
  spice: remove only written event_mask field
  spice: remove unused timer list

Jindrich Makovicka (3):
  sdl2: Do not hide the cursor on auxilliary windows
  sdl2 uses surface relative coordinates
  sdl2: Ignore UI hotkeys after a focus change when GUI modifier is held

linzhecheng (1):
  input: fix memory leak

 configure                  |  6 ++++
 include/ui/sdl2.h          |  1 +
 include/ui/spice-display.h |  1 -
 hw/display/qxl.c           |  1 -
 ui/gtk.c                   |  5 +++
 ui/input.c                 |  2 ++
 ui/sdl2.c                  | 79 ++++++++++++++++++++++++++--------------------
 ui/spice-core.c            | 14 ++------
 ui/spice-display.c         |  2 --
 qemu-doc.texi              |  9 ++++++
 10 files changed, 70 insertions(+), 50 deletions(-)

-- 
2.9.3
