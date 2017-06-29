Received: from eggs.gnu.org ([2001:4830:134:3::10]:59186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQcBi-0002Uw-Fm
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQcBf-0005PM-1A
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:21:02 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 29 Jun 2017 17:20:46 +0100
Message-Id: <20170629162046.4135-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] backends: remove empty trace-events file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-trivial@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

The content of the backends/trace-events file was entirely
removed in

  commit 6b10e573d15ef82dbc5c5b3726028e6642e134f6
  Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
  Date:   Mon May 29 12:39:42 2017 +0400

    char: move char devices to chardev/

Leaving the empty file around, causes tracetool to generate
an empty .dtrace file which makes the dtrace compiler throw
a syntax error.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs         | 1 -
 backends/trace-events | 0
 2 files changed, 1 deletion(-)
 delete mode 100644 backends/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index b2e6322..8004d6d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -122,7 +122,6 @@ trace-events-subdirs +=3D crypto
 trace-events-subdirs +=3D io
 trace-events-subdirs +=3D migration
 trace-events-subdirs +=3D block
-trace-events-subdirs +=3D backends
 trace-events-subdirs +=3D chardev
 trace-events-subdirs +=3D hw/block
 trace-events-subdirs +=3D hw/block/dataplane
diff --git a/backends/trace-events b/backends/trace-events
deleted file mode 100644
index e69de29..0000000
--=20
2.9.4
