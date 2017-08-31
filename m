Received: from eggs.gnu.org ([2001:4830:134:3::10]:55530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXh-0000eB-IS
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXg-0006Yr-QU
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:21 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXg-0006Ye-MV
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:20 -0400
Received: by mail-qt0-x244.google.com with SMTP id u11so6733763qtu.2
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 20:53:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 31 Aug 2017 00:53:01 -0300
Message-Id: <20170831035306.29170-3-f4bug@amsat.org>
In-Reply-To: <20170831035306.29170-1-f4bug@amsat.org>
References: <20170831035306.29170-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/7] serial: use serial_chr_nonnull() in
 serial_mm_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index e4c38dc250..57e89468b4 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1050,7 +1050,7 @@ SerialState *serial_mm_init(MemoryRegion *address_space,
     s->it_shift = it_shift;
     s->irq = irq;
     s->baudbase = baudbase;
-    qemu_chr_fe_init(&s->chr, chr, &error_abort);
+    qemu_chr_fe_init(&s->chr, serial_chr_nonnull(chr), &error_abort);
 
     serial_realize_core(s, &error_fatal);
     vmstate_register(NULL, base, &vmstate_serial, s);
-- 
2.14.1
