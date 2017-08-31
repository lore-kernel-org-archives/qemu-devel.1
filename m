Received: from eggs.gnu.org ([2001:4830:134:3::10]:55597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXs-0000lf-2m
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXr-0006bn-7h
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 31 Aug 2017 00:53:05 -0300
Message-Id: <20170831035306.29170-7-f4bug@amsat.org>
In-Reply-To: <20170831035306.29170-1-f4bug@amsat.org>
References: <20170831035306.29170-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 6/7] hw/char/omap_uart: serial_mm_init()
 already check for null chr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/omap_uart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index 6fd1b9cf6b..1f0ac0a053 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -63,8 +63,7 @@ struct omap_uart_s *omap_uart_init(hwaddr base,
     s->irq = irq;
     s->serial = serial_mm_init(get_system_memory(), base, 2, irq,
                                omap_clk_getrate(fclk)/16,
-                               chr ?: qemu_chr_new(label, "null"),
-                               DEVICE_NATIVE_ENDIAN);
+                               chr, DEVICE_NATIVE_ENDIAN);
     return s;
 }
 
@@ -183,6 +182,5 @@ void omap_uart_attach(struct omap_uart_s *s, Chardev *chr)
     /* TODO: Should reuse or destroy current s->serial */
     s->serial = serial_mm_init(get_system_memory(), s->base, 2, s->irq,
                                omap_clk_getrate(s->fclk) / 16,
-                               chr ?: qemu_chr_new("null", "null"),
-                               DEVICE_NATIVE_ENDIAN);
+                               chr, DEVICE_NATIVE_ENDIAN);
 }
-- 
2.14.1
