Received: from eggs.gnu.org ([2001:4830:134:3::10]:42570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dmJG5-0005Xa-VM
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dmJG2-0007dv-6p
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:35:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dmJG2-0007dN-0F
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:35:10 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 28 Aug 2017 14:34:58 +0200
Message-Id: <20170828123501.22317-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] qxl: add support for chunked cursors.
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

[ v2: codestyle fixes ]

Gerd Hoffmann (3):
  qxl: drop mono cursor support
  qxl: add support for chunked cursors.
  qxl_unpack_chunks: codestyle fixups

 hw/display/qxl-render.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

-- 
2.9.3
