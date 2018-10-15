Received: from eggs.gnu.org ([2001:4830:134:3::10]:48106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC6fi-0005Vz-0J
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC6fh-0005EF-6H
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:28:49 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 15 Oct 2018 19:28:15 +0200
Message-Id: <20181015172817.19796-4-mreitz@redhat.com>
In-Reply-To: <20181015172817.19796-1-mreitz@redhat.com>
References: <20181015172817.19796-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] qdev-monitor: Make device options help
 nicer
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

Just like in qemu_opts_print_help(), print the device name as a caption
instead of on every single line, indent all options, and replace the '='
by ': '.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qdev-monitor.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index 802c18a74e..481bb4bbf9 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -285,8 +285,13 @@ int qdev_device_help(QemuOpts *opts)
         goto error;
     }
 
+    if (prop_list) {
+        out_printf("%s options:\n", driver);
+    } else {
+        out_printf("There are no options for %s.\n", driver);
+    }
     for (prop = prop_list; prop; prop = prop->next) {
-        out_printf("%s.%s=%s", driver, prop->value->name, prop->value->type);
+        out_printf("  %s: %s", prop->value->name, prop->value->type);
         if (prop->value->has_description) {
             out_printf(" (%s)\n", prop->value->description);
         } else {
-- 
2.17.1
