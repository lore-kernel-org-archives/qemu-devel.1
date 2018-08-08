Received: from eggs.gnu.org ([2001:4830:134:3::10]:36163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fnM2A-0005sm-V6
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 06:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fnM26-00026v-RT
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 06:49:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49894 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fnM26-00026i-Mi
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 06:49:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 535B740241C3
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 10:49:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  8 Aug 2018 11:49:27 +0100
Message-Id: <20180808104930.23133-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] ui: remove deprecated UI frontends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

We deprecated GTK2 and SDL1.2 in the 2.12.0 release, so they are able to
be removed entirely in the 3.1.0 release. The min GTK3 version can also
be bumped up based the distros we aim to support.

Daniel P. Berrang=C3=A9 (3):
  ui: remove support for GTK2 in favour of GTK3
  ui: increase min required GTK3 version to 3.14.0
  ui: remove support for SDL1.2 in favour of SDL2

 configure              |  111 +----
 include/ui/gtk.h       |    9 -
 qemu-deprecated.texi   |   16 -
 ui/Makefile.objs       |    5 -
 ui/gtk-egl.c           |   10 +-
 ui/gtk.c               |  202 +-------
 ui/sdl.c               | 1027 ----------------------------------------
 ui/sdl_zoom.c          |   93 ----
 ui/sdl_zoom.h          |   25 -
 ui/sdl_zoom_template.h |  219 ---------
 10 files changed, 33 insertions(+), 1684 deletions(-)
 delete mode 100644 ui/sdl.c
 delete mode 100644 ui/sdl_zoom.c
 delete mode 100644 ui/sdl_zoom.h
 delete mode 100644 ui/sdl_zoom_template.h

--=20
2.17.1
