Received: from eggs.gnu.org ([2001:4830:134:3::10]:54967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ft6aj-0006qG-IZ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 03:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ft6ag-0000aq-4A
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 03:33:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37350 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ft6ac-0000Xi-1b
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 03:33:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 84CB740216EA
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 07:33:01 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 24 Aug 2018 09:32:53 +0200
Message-Id: <20180824073256.19626-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Ui2 20180824 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit 5ccac548faf041ff5229a8e8342e3be14a34c8=
af:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' int=
o staging (2018-08-23 17:35:48 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/ui2-20180824-pull-request

for you to fetch changes up to eb01505ea6c8330273d189acc053cc60d00bfa1a:

  ui: remove support for SDL1.2 in favour of SDL2 (2018-08-24 09:31:39 +0=
200)

----------------------------------------------------------------
ui: remove deprecated UI frontends

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (3):
  ui: remove support for GTK2 in favour of GTK3
  ui: increase min required GTK3 version to 3.14.0
  ui: remove support for SDL1.2 in favour of SDL2

 configure              |  111 +-----
 include/ui/gtk.h       |    9 -
 ui/sdl_zoom.h          |   25 --
 ui/sdl_zoom_template.h |  219 -----------
 ui/gtk-egl.c           |   10 +-
 ui/gtk.c               |  202 +---------
 ui/sdl.c               | 1027 ------------------------------------------=
------
 ui/sdl_zoom.c          |   93 -----
 qemu-deprecated.texi   |   16 -
 ui/Makefile.objs       |    5 -
 10 files changed, 33 insertions(+), 1684 deletions(-)
 delete mode 100644 ui/sdl_zoom.h
 delete mode 100644 ui/sdl_zoom_template.h
 delete mode 100644 ui/sdl.c
 delete mode 100644 ui/sdl_zoom.c

--=20
2.9.3
