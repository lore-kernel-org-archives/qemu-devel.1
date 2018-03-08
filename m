Received: from eggs.gnu.org ([2001:4830:134:3::10]:37898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etqyl-0000wR-NL
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:32:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etqyi-0008HY-Jg
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:32:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etqyi-0008G9-FF
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:32:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF59C4040073
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 08:32:38 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  8 Mar 2018 09:32:23 +0100
Message-Id: <20180308083231.20180-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] Ui 20180308 patches
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

The following changes since commit f32408f3b472a088467474ab152be3b6285b2d=
7b:

  misc: don't use hwaddr as a type in trace events (2018-03-06 14:24:30 +=
0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui-20180308-pull-request

for you to fetch changes up to 5c71cfd94d46a9c2e09d041dcc82b297efab2b57:

  ui/gtk-egl: add cursor_dmabuf support (2018-03-08 08:59:01 +0100)

----------------------------------------------------------------
gtk: add dmabuf support. cleanups, i18n fix.
sdl: workaround sdl 2.0.8 header bug,

----------------------------------------------------------------

Bruce Rogers (1):
  make: switch language file build to be gtk module aware

Gerd Hoffmann (7):
  sdl: workaround bug in sdl 2.0.8 headers
  ui/gtk: make GtkGlArea usage a runtime option
  ui/gtk: group gtk.mo declarations in Makefile
  ui/opengl: Makefile cleanup
  ui/gtk: use GtkGlArea on wayland only
  ui/gtk-egl: add scanout_dmabuf support
  ui/gtk-egl: add cursor_dmabuf support

 configure        |  1 +
 Makefile         |  2 +-
 include/ui/gtk.h | 14 ++++++++++++
 ui/gtk-egl.c     | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++=
-
 ui/gtk.c         | 68 +++++++++++++++++++++++++++++++++-----------------=
------
 ui/Makefile.objs | 25 +++++++++++----------
 6 files changed, 131 insertions(+), 42 deletions(-)

--=20
2.9.3
