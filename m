Received: from eggs.gnu.org ([2001:4830:134:3::10]:45205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shravan2x@utexas.edu>) id 1eLGQt-0003sC-22
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 17:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shravan2x@utexas.edu>) id 1eLGQq-0001nv-0F
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 17:38:51 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:43048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shravan2x@utexas.edu>)
	id 1eLGQp-0001nd-RV
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 17:38:47 -0500
Received: by mail-ot0-x241.google.com with SMTP id y10so11879298otg.10
	for <qemu-devel@nongnu.org>; Sat, 02 Dec 2017 14:38:47 -0800 (PST)
From: Shravan Rajinikanth <shravan2x@utexas.edu>
Date: Sat,  2 Dec 2017 14:37:53 -0800
Message-Id: <1512254273-7567-1-git-send-email-shravan2x@utexas.edu>
Subject: [Qemu-devel] [PATCH] qemu-img: Fixed grammatical error in
 dump_human_image_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Shravan Rajinikanth <shravan2x@utexas.edu>, qemu-trivial@nongnu.org

Signed-off-by: Shravan Rajinikanth <shravan2x@utexas.edu>
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 68b375f..bea9268 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -580,7 +580,7 @@ static void dump_human_image_check(ImageCheck *check, bool quiet)
         if (check->leaks) {
             qprintf(quiet,
                     "\n%" PRId64 " leaked clusters were found on the image.\n"
-                    "This means waste of disk space, but no harm to data.\n",
+                    "This means disk space is wasted, but data is safe.\n",
                     check->leaks);
         }
 
-- 
2.7.4
