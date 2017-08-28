Received: from eggs.gnu.org ([2001:4830:134:3::10]:44303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dmJKP-0008WK-9U
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dmJKN-0002Zv-4J
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:39:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dmJKM-0002ZI-Tg
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:39:39 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 28 Aug 2017 14:39:31 +0200
Message-Id: <20170828123933.30323-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] qxl: add support for chunked cursors.
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
[ v3: actually squash the codestyle fixes ... ]

Gerd Hoffmann (2):
  qxl: drop mono cursor support
  qxl: add support for chunked cursors.

 hw/display/qxl-render.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

-- 
2.9.3
