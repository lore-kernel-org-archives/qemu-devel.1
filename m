Received: from eggs.gnu.org ([2001:4830:134:3::10]:34155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXRIh-0008QV-Pq
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXRIf-0001bA-Oy
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:12:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40014 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fXRIf-0001aw-KC
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:12:57 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 25 Jun 2018 15:12:53 +0200
Message-Id: <20180625131253.11218-7-kraxel@redhat.com>
In-Reply-To: <20180625131253.11218-1-kraxel@redhat.com>
References: <20180625131253.11218-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 6/6] audio: Convert use of atoi to qemu_strtoi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Nia Alarie <nia.alarie@gmail.com>

From: Nia Alarie <nia.alarie@gmail.com>

If qemu_strtoi indicates an error, return the default value.

Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
Message-Id: <20180316144047.30904-1-nia.alarie@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
2.9.3
