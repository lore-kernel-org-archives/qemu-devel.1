Received: from eggs.gnu.org ([2001:4830:134:3::10]:60933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMm-0002Aw-81
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORMl-0008N5-FM
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:28 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:59 +0200
Message-Id: <1498234919-27316-62-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 61/61] qemu-img: don't shadow opts variable in
 img_dd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Stefan Hajnoczi <stefanha@redhat.com>

It's confusing when two different variables have the same name in one
function.

Cc: Reda Sallahi <fullmanet@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170619150002.3033-1-stefanha@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index e70d515..91ad6be 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4255,15 +4255,12 @@ static int img_dd(int argc, char **argv)
         case 'U':
             force_share = true;
             break;
-        case OPTION_OBJECT: {
-            QemuOpts *opts;
-            opts = qemu_opts_parse_noisily(&qemu_object_opts,
-                                           optarg, true);
-            if (!opts) {
+        case OPTION_OBJECT:
+            if (!qemu_opts_parse_noisily(&qemu_object_opts, optarg, true)) {
                 ret = -1;
                 goto out;
             }
-        }   break;
+            break;
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
-- 
1.8.3.1
