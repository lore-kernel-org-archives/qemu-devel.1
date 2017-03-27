Received: from eggs.gnu.org ([2001:4830:134:3::10]:53271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csWx0-0001Zj-DT
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csWwz-0006JN-6R
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:52:58 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 27 Mar 2017 17:52:30 +0200
Message-Id: <20170327155234.10980-3-mreitz@redhat.com>
In-Reply-To: <20170327155234.10980-1-mreitz@redhat.com>
References: <20170327155234.10980-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/6] qemu-img: fix switch indentation in
 img_amend()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

QEMU coding style indents 'case' to the same level as the 'switch'
statement:

  switch (foo) {
  case 1:

Fix this coding style violation so checkpatch.pl doesn't complain about
the next patch.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170317104541.28979-3-stefanha@redhat.com
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 82 +++++++++++++++++++++++++++++++-------------------------=
------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index ce293a4710..c7ffabb268 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3500,47 +3500,47 @@ static int img_amend(int argc, char **argv)
         }
=20
         switch (c) {
-            case 'h':
-            case '?':
-                help();
-                break;
-            case 'o':
-                if (!is_valid_option_list(optarg)) {
-                    error_report("Invalid option list: %s", optarg);
-                    ret =3D -1;
-                    goto out_no_progress;
-                }
-                if (!options) {
-                    options =3D g_strdup(optarg);
-                } else {
-                    char *old_options =3D options;
-                    options =3D g_strdup_printf("%s,%s", options, optarg=
);
-                    g_free(old_options);
-                }
-                break;
-            case 'f':
-                fmt =3D optarg;
-                break;
-            case 't':
-                cache =3D optarg;
-                break;
-            case 'p':
-                progress =3D true;
-                break;
-            case 'q':
-                quiet =3D true;
-                break;
-            case OPTION_OBJECT:
-                opts =3D qemu_opts_parse_noisily(&qemu_object_opts,
-                                               optarg, true);
-                if (!opts) {
-                    ret =3D -1;
-                    goto out_no_progress;
-                }
-                break;
-            case OPTION_IMAGE_OPTS:
-                image_opts =3D true;
-                break;
+        case 'h':
+        case '?':
+            help();
+            break;
+        case 'o':
+            if (!is_valid_option_list(optarg)) {
+                error_report("Invalid option list: %s", optarg);
+                ret =3D -1;
+                goto out_no_progress;
+            }
+            if (!options) {
+                options =3D g_strdup(optarg);
+            } else {
+                char *old_options =3D options;
+                options =3D g_strdup_printf("%s,%s", options, optarg);
+                g_free(old_options);
+            }
+            break;
+        case 'f':
+            fmt =3D optarg;
+            break;
+        case 't':
+            cache =3D optarg;
+            break;
+        case 'p':
+            progress =3D true;
+            break;
+        case 'q':
+            quiet =3D true;
+            break;
+        case OPTION_OBJECT:
+            opts =3D qemu_opts_parse_noisily(&qemu_object_opts,
+                                           optarg, true);
+            if (!opts) {
+                ret =3D -1;
+                goto out_no_progress;
+            }
+            break;
+        case OPTION_IMAGE_OPTS:
+            image_opts =3D true;
+            break;
         }
     }
=20
--=20
2.12.1
