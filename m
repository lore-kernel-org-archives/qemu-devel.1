Received: from eggs.gnu.org ([2001:4830:134:3::10]:39806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqdbZ-0005eH-5T
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:39:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqdbY-0001aj-HQ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:39:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqdbY-0001aL-Cm
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:39:32 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0142DEAEAB
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 11:39:32 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Feb 2018 12:39:25 +0100
Message-Id: <20180227113929.17170-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] gtk: add support for dmabufs
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



Gerd Hoffmann (4):
  gtk: make GtkGlArea usage a runtime option
  gtk: use GtkGlArea on wayland only
  gtk-egl: add scanout_dmabuf support
  gtk-egl: add cursor_dmabuf support

 include/ui/gtk.h | 14 ++++++++++++
 ui/gtk-egl.c     | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 ui/gtk.c         | 68 +++++++++++++++++++++++++++++++++-----------------------
 ui/Makefile.objs |  3 +--
 4 files changed, 117 insertions(+), 31 deletions(-)

-- 
2.9.3
