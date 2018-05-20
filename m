Received: from eggs.gnu.org ([2001:4830:134:3::10]:45915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHvG-000634-8v
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHvA-0002tU-3Q
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:34:23 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 20 May 2018 09:14:56 +0300
Message-Id: <4885b0caf607579a0f99c221fa39ca97d9a6ddf4.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 10/22] qemu-img-cmds.hx: add passive-aggressive
 note
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: John Snow <jsnow@redhat.com>

I'm kidding. It's very easy to forget there are per-command sections
in the texi, and insane that we don't autogenerate those, too.

Until then, leave a little post-it note in this .hx file until I
find a way to delete it.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img-cmds.hx | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 84deb858af..3d2f7b26eb 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -6,6 +6,9 @@ HXCOMM DEF(command, callback, arg_string) is used to construct
 HXCOMM command structures and help message.
 HXCOMM HXCOMM can be used for comments, discarded from both texi and C
 
+HXCOMM When amending the TEXI sections, please remember to copy the usage
+HXCOMM over to the per-command sections in qemu-img.texi.
+
 STEXI
 @table @option
 ETEXI
-- 
2.11.0
