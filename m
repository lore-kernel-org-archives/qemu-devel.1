Received: from eggs.gnu.org ([2001:4830:134:3::10]:44522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDXyB-00033g-Iq
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDXyA-0004kO-Mn
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:49:51 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 19 Oct 2018 18:49:26 +0200
Message-Id: <20181019164929.18404-3-mreitz@redhat.com>
In-Reply-To: <20181019164929.18404-1-mreitz@redhat.com>
References: <20181019164929.18404-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/5] chardev: Indent list of chardevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Following the example of qemu_opts_print_help(), indent all entries in
the list of character devices.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 chardev/char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index e115166995..10d44aaefc 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -569,7 +569,7 @@ help_string_append(const char *name, void *opaque)
 {
     GString *str = opaque;
 
-    g_string_append_printf(str, "\n%s", name);
+    g_string_append_printf(str, "\n  %s", name);
 }
 
 static const char *chardev_alias_translate(const char *name)
-- 
2.17.1
