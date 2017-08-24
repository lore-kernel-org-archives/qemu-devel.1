Received: from eggs.gnu.org ([2001:4830:134:3::10]:58023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dknGL-0004Sz-V6
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dknGK-0002is-6O
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:13:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dknGK-0002iZ-0H
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:13:12 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Aug 2017 10:13:03 +0200
Message-Id: <20170824081305.8445-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qxl: add support for chunked cursors.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.com>, Gerd Hoffmann <kraxel@redhat.com>

This series adds support for unpacking qxl chunks, and uses it to
support chunked cursor images.  Windows guest drivers seem to use
that when in HiDPI mode.

Also drop (broken) support for mono cursors.

Gerd Hoffmann (2):
  qxl: drop mono cursor support
  qxl: add support for chunked cursors.

 hw/display/qxl-render.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

-- 
2.9.3
