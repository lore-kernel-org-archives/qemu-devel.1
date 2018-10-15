Received: from eggs.gnu.org ([2001:4830:134:3::10]:47939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC6fX-0005QO-5B
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC6fU-00055b-PE
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:28:39 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 15 Oct 2018 19:28:14 +0200
Message-Id: <20181015172817.19796-3-mreitz@redhat.com>
In-Reply-To: <20181015172817.19796-1-mreitz@redhat.com>
References: <20181015172817.19796-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] chardev: Indent list of chardevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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
