Received: from eggs.gnu.org ([2001:4830:134:3::10]:51040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf38-0000bX-Hb
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf37-00024C-M3
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:02 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf37-00023n-G3
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:01 -0400
Received: by mail-wm0-x242.google.com with SMTP id u23so5456027wma.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:25:01 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:06 +0200
Message-Id: <1499955874-10954-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/41] test-char: destroy chardev-udp after test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

this is only not a problem if the test is last in a suite,
otherwise it makes the following main_loop() calls to fail

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <1499342940-56739-7-git-send-email-anton.nefedov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-char.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index 38aaa27..536536e 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -450,6 +450,7 @@ static void char_udp_test(void)
 
     close(sock);
     g_free(tmp);
+    qemu_chr_fe_deinit(&be, true);
 }
 
 #ifdef HAVE_CHARDEV_SERIAL
-- 
1.8.3.1
