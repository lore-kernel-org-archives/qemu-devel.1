Received: from eggs.gnu.org ([2001:4830:134:3::10]:45139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1ewqXn-0004Jk-HW
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1ewqXj-0007Z0-KE
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:41:19 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:53280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nia.alarie@gmail.com>)
	id 1ewqXj-0007Yp-Dk
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:41:15 -0400
Received: by mail-wm0-x244.google.com with SMTP id e194so3457574wmd.3
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 07:41:15 -0700 (PDT)
From: Nia Alarie <nia.alarie@gmail.com>
Date: Fri, 16 Mar 2018 14:40:47 +0000
Message-Id: <20180316144047.30904-1-nia.alarie@gmail.com>
Subject: [Qemu-devel] [PATCH] audio: Convert use of atoi to qemu_strtoi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, kraxel@redhat.com, Nia Alarie <nia.alarie@gmail.com>

If qemu_strtoi indicates an error, return the default value.

Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
---
 audio/audio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 6eccdb17ee..d6e91901aa 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -335,9 +335,8 @@ static int audio_get_conf_int (const char *key, int defval, int *defaultp)
     char *strval;
 
     strval = getenv (key);
-    if (strval) {
+    if (strval && !qemu_strtoi(strval, NULL, 10, &val)) {
         *defaultp = 0;
-        val = atoi (strval);
         return val;
     }
     else {
-- 
2.16.2
