Received: from eggs.gnu.org ([2001:4830:134:3::10]:41971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6bSV-0006na-DN
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6bSS-0000E9-BC
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:03:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e6bSS-0000Do-5u
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:03:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC6E764DB4
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 12:03:50 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 14:03:13 +0200
Message-Id: <20171023120317.8296-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] gtk: add dmabuf support
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

This series adds dmabuf support to the gtk ui.

Gerd Hoffmann (4):
  opengl: split up dpy_gl_cursor ops
  gtk: make GtkGlArea usage a runtime option
  gtk: use GtkGlArea on wayland only
  gtk-egl: add dmabuf support

 include/ui/console.h | 10 +++++---
 include/ui/gtk.h     | 13 ++++++++++
 ui/console.c         | 15 ++++++++---
 ui/egl-headless.c    | 16 ++++++++----
 ui/gtk-egl.c         | 64 +++++++++++++++++++++++++++++++++++++++++++++--
 ui/gtk.c             | 70 +++++++++++++++++++++++++++++++---------------------
 ui/Makefile.objs     |  3 +--
 7 files changed, 147 insertions(+), 44 deletions(-)

-- 
2.9.3
