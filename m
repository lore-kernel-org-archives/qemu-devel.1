Received: from eggs.gnu.org ([2001:4830:134:3::10]:54734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dnlWB-0001wq-1D
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dnlW6-0007oc-Ar
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37009)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dnlW6-0007oG-45
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:57:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18067769E6
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:57:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  1 Sep 2017 14:57:37 +0200
Message-Id: <20170901125742.4249-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 0/5] Vga 20170901 patches
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

The following changes since commit 223cd0e13f2e46078d7b573f0b8402bfbee339be:

  Merge remote-tracking branch 'remotes/elmarco/tags/tidy-pull-request' into staging (2017-08-31 15:52:43 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20170901-pull-request

for you to fetch changes up to 138bc2df843105edb22978284fc2e16307f16211:

  vga/migration: Update memory map in post_load (2017-09-01 13:52:43 +0200)

----------------------------------------------------------------
qxl: chunked cursor support.
stdvga: bugfixes.

----------------------------------------------------------------

Dr. David Alan Gilbert (1):
  vga/migration: Update memory map in post_load

Gerd Hoffmann (4):
  vga: fix display update region calculation (split screen)
  vga: stop passing pointers to vga_draw_line* functions
  qxl: drop mono cursor support
  qxl: add support for chunked cursors.

 hw/display/vga-helpers.h | 202 ++++++++++++++++++++++++++---------------------
 hw/display/vga_int.h     |   1 +
 hw/display/qxl-render.c  |  45 +++++++----
 hw/display/vga.c         |  16 +++-
 4 files changed, 152 insertions(+), 112 deletions(-)

-- 
2.9.3
