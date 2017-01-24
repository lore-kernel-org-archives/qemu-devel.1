Received: from eggs.gnu.org ([2001:4830:134:3::10]:40602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxZv-0005p8-7r
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxZn-0000jn-TB
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:39:51 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:16 +0300
Message-Id: <2cd3dc3d543fdfc19bf3322b48d22619d5ba5081.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 12/31] qemu-img: remove dead check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Paolo Bonzini <pbonzini@redhat.com>

options must be non-NULL here, because it has been checked before.
Reported by Coverity.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 5df66fe..74e3362 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3455,13 +3455,11 @@ static int img_amend(int argc, char **argv)
 
     create_opts = qemu_opts_append(create_opts, bs->drv->create_opts);
     opts = qemu_opts_create(create_opts, NULL, 0, &error_abort);
-    if (options) {
-        qemu_opts_do_parse(opts, options, NULL, &err);
-        if (err) {
-            error_report_err(err);
-            ret = -1;
-            goto out;
-        }
+    qemu_opts_do_parse(opts, options, NULL, &err);
+    if (err) {
+        error_report_err(err);
+        ret = -1;
+        goto out;
     }
 
     /* In case the driver does not call amend_status_cb() */
-- 
2.1.4
