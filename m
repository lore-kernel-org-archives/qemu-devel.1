Received: from eggs.gnu.org ([2001:4830:134:3::10]:41098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC05R-0007Nh-Ik
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC05Q-0001eN-K9
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fC05Q-0001e5-Fo
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05701401DEB3
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 09:54:40 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 27 Apr 2018 11:54:28 +0200
Message-Id: <20180427095434.14013-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] Ui 20180427 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit b8846a4d6352b2a1d2012f8b3b9115640524ae=
da:

  vl.c: new function serial_max_hds() (2018-04-26 13:58:29 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180427-pull-request

for you to fetch changes up to 8983e3e35033ecb9234725c2bba65f020824969b:

  ui: introduce vfio_display_reset (2018-04-27 11:36:34 +0200)

----------------------------------------------------------------
vnc: fix use-after-free.
sdl2: gles support.
vfio-display: add reset support.

----------------------------------------------------------------

Elie Tournier (3):
  qapi: Parameter gl of DisplayType now accept an enum
  sdl: Move DisplayOptions global to sdl2_console
  sdl: Allow OpenGL ES context creation

Gerd Hoffmann (1):
  vnc: fix use-after-free

Tina Zhang (2):
  console: introduce dpy_gfx_update_full
  ui: introduce vfio_display_reset

 hw/vfio/pci.h        |  1 +
 include/ui/console.h |  1 +
 include/ui/sdl2.h    |  1 +
 hw/vfio/display.c    | 11 +++++++++++
 hw/vfio/pci.c        |  4 ++++
 ui/console.c         | 10 ++++++++++
 ui/sdl2-gl.c         | 19 +++++++++++++++++--
 ui/sdl2.c            | 10 +++++-----
 ui/vnc.c             |  5 +++--
 vl.c                 | 14 +++++++++-----
 qapi/ui.json         | 20 +++++++++++++++++++-
 qemu-options.hx      |  2 +-
 12 files changed, 82 insertions(+), 16 deletions(-)

--=20
2.9.3
