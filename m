Received: from eggs.gnu.org ([2001:4830:134:3::10]:49677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et8bt-0002M7-A9
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et8bn-0000Zc-Pd
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:10:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39336 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1et8bn-0000ZJ-KP
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:10:07 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B86D684221
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 09:09:56 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Mar 2018 10:09:45 +0100
Message-Id: <20180306090951.22932-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] gtk: add support for dmabufs
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

v2: rebase, add some makefile cleanups.

Gerd Hoffmann (6):
  ui/gtk: make GtkGlArea usage a runtime option
  ui/gtk: group gtk.mo declarations in Makefile
  ui/opengl: Makefile cleanup
  ui/gtk: use GtkGlArea on wayland only
  ui/gtk-egl: add scanout_dmabuf support
  ui/gtk-egl: add cursor_dmabuf support

 include/ui/gtk.h | 14 ++++++++++++
 ui/gtk-egl.c     | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 ui/gtk.c         | 68 +++++++++++++++++++++++++++++++++-----------------------
 ui/Makefile.objs | 25 +++++++++++----------
 4 files changed, 129 insertions(+), 41 deletions(-)

-- 
2.9.3
