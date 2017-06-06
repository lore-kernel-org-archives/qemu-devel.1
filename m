Received: from eggs.gnu.org ([2001:4830:134:3::10]:38226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dICIY-00052v-LV
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dICIO-0002gd-Sd
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:05:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dICIO-0002fD-N6
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:05:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97AAD7D0FB
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 11:05:07 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Jun 2017 13:04:55 +0200
Message-Id: <20170606110459.9771-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] ui/opengl: add and use helper functions to
 handle framebuffers
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

  Hi,

All UIs with opengl support have simliar code to handle opengl
framebuffers.  Create some helpers and put them into use to reduce
code duplication.

Gerd Hoffmann (4):
  egl-helpers: add helpers to handle opengl framebuffers
  egl-headless: use framebuffer helper functions.
  sdl2: use framebuffer helper functions.
  gtk: use framebuffer helper functions.

 include/ui/egl-helpers.h | 14 ++++++++++
 include/ui/gtk.h         |  4 +--
 include/ui/sdl2.h        |  8 ++++--
 ui/egl-headless.c        | 67 ++++++++++++----------------------------------
 ui/egl-helpers.c         | 69 ++++++++++++++++++++++++++++++++++++++++++++++++
 ui/gtk-egl.c             | 38 ++++++--------------------
 ui/gtk-gl-area.c         | 26 +++++-------------
 ui/sdl2-gl.c             | 38 ++++++--------------------
 8 files changed, 131 insertions(+), 133 deletions(-)

-- 
2.9.3
