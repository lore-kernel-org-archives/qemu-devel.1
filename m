Received: from eggs.gnu.org ([2001:4830:134:3::10]:33514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsSzZ-0003GN-7v
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 09:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsSzV-0003Ko-5G
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 09:16:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48386 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fsSzT-0003JN-De
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 09:16:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E0F8DFEE
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 13:16:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 22 Aug 2018 14:15:51 +0100
Message-Id: <20180822131554.3398-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] ui: remove deprecated UI frontends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <famz@redhat.com>, libvir-list@redhat.com, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

We deprecated GTK2 and SDL1.2 in the 2.12.0 release, so they are able to
be removed entirely in the 3.1.0 release. The min GTK3 version can also
be bumped up based the distros we aim to support.

Note that before this can merge, the openbsd VM test image needs to be
updated to have SDL2, as openbsd build mandates SDL availability.

The freebsd & netbsd images should also be updated, but they are not
build blockers as they automatically disable SDL

Changed in v2:

 - Rebased to resolve conflicts

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
