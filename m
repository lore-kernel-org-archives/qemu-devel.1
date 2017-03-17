Received: from eggs.gnu.org ([2001:4830:134:3::10]:37181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1copOW-0000tq-1P
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1copOU-0000MU-PS
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:46:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 17 Mar 2017 18:45:40 +0800
Message-Id: <20170317104541.28979-3-stefanha@redhat.com>
In-Reply-To: <20170317104541.28979-1-stefanha@redhat.com>
References: <20170317104541.28979-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] qemu-img: fix switch indentation in
 img_amend()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

QEMU coding style indents 'case' to the same level as the 'switch'
statement:

  switch (foo) {
  case 1:

Fix this coding style violation so checkpatch.pl doesn't complain about
the next patch.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-img.c | 82 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index ce293a4..c7ffabb 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3500,47 +3500,47 @@ static int img_amend(int argc, char **argv)
         }
 
         switch (c) {
-            case 'h':
-            case '?':
-                help();
-                break;
-            case 'o':
-                if (!is_valid_option_list(optarg)) {
-                    error_report("Invalid option list: %s", optarg);
-                    ret = -1;
-                    goto out_no_progress;
-                }
-                if (!options) {
-                    options = g_strdup(optarg);
-                } else {
-                    char *old_options = options;
-                    options = g_strdup_printf("%s,%s", options, optarg);
-                    g_free(old_options);
-                }
-                break;
-            case 'f':
-                fmt = optarg;
-                break;
-            case 't':
-                cache = optarg;
-                break;
-            case 'p':
-                progress = true;
-                break;
-            case 'q':
-                quiet = true;
-                break;
-            case OPTION_OBJECT:
-                opts = qemu_opts_parse_noisily(&qemu_object_opts,
-                                               optarg, true);
-                if (!opts) {
-                    ret = -1;
-                    goto out_no_progress;
-                }
-                break;
-            case OPTION_IMAGE_OPTS:
-                image_opts = true;
-                break;
+        case 'h':
+        case '?':
+            help();
+            break;
+        case 'o':
+            if (!is_valid_option_list(optarg)) {
+                error_report("Invalid option list: %s", optarg);
+                ret = -1;
+                goto out_no_progress;
+            }
+            if (!options) {
+                options = g_strdup(optarg);
+            } else {
+                char *old_options = options;
+                options = g_strdup_printf("%s,%s", options, optarg);
+                g_free(old_options);
+            }
+            break;
+        case 'f':
+            fmt = optarg;
+            break;
+        case 't':
+            cache = optarg;
+            break;
+        case 'p':
+            progress = true;
+            break;
+        case 'q':
+            quiet = true;
+            break;
+        case OPTION_OBJECT:
+            opts = qemu_opts_parse_noisily(&qemu_object_opts,
+                                           optarg, true);
+            if (!opts) {
+                ret = -1;
+                goto out_no_progress;
+            }
+            break;
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
+            break;
         }
     }
 
-- 
2.9.3
