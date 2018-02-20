Received: from eggs.gnu.org ([2001:4830:134:3::10]:35404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo5j8-0005pd-3t
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:04:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo5j4-00083s-9W
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:04:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56076 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo5j4-00083g-5Z
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:04:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 36AB84023150
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 11:04:43 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 12:04:30 +0100
Message-Id: <20180220110433.20353-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] opengl: some dmabuf support updates
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

This series updates the UI interface for dmabug cursors.  Splits the
callback into two, so we have a separate call for cursor moves.  Also
adds hotspot information.  Series also includes two small fixes in egl
code.

Gerd Hoffmann (3):
  console/opengl: split up dpy_gl_cursor ops
  egl-headless: cursor_dmabuf: handle NULL cursor
  egl-helpers: add alpha channel to texture format

 include/ui/console.h | 13 ++++++++-----
 ui/console.c         | 18 ++++++++++++++----
 ui/egl-headless.c    | 30 ++++++++++++++++++++----------
 ui/egl-helpers.c     |  2 +-
 4 files changed, 43 insertions(+), 20 deletions(-)

-- 
2.9.3
