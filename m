Received: from eggs.gnu.org ([2001:4830:134:3::10]:51022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9HkA-0000qj-5w
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Hk9-0003gM-Bo
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:09:30 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:41522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Hk9-0003fi-7E
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:09:29 -0400
Received: by mail-qt0-x244.google.com with SMTP id d3-v6so7529458qth.8
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 15:09:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 19 Apr 2018 19:09:14 -0300
Message-Id: <20180419220914.959-3-f4bug@amsat.org>
In-Reply-To: <20180419220914.959-1-f4bug@amsat.org>
References: <20180419220914.959-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] Revert "Revert "mux: fix ctrl-a b again""
 again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This reverts commit 6f660996f1623034344cc37a1d430099067b755b to
reintroduce commit 1b2503fcf7b5932c5a3779ca2ceb92bd403c4ee7.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 chardev/char-mux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 1b925c8dec..6055e76293 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -304,6 +304,7 @@ void mux_set_focus(Chardev *chr, int focus)
     }
 
     d->focus = focus;
+    chr->be = d->backends[focus];
     mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
 
-- 
2.17.0
