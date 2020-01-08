Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1F5C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10B6206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei82SjFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10B6206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAwa-0000wc-D8
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:00:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWt-0004Yr-0e
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWp-0004eK-JW
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:42 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:38067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWp-0004du-6d
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:39 -0500
Received: by mail-wm1-x32d.google.com with SMTP id u2so2318517wmc.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cH7ct5X68dV4J5xr190rAMFwpjfS5nv2os2fFYotpQs=;
 b=Ei82SjFZ9zP7yR9oEcuTd4EjEWhJICe4y6vN0ixLGePtR4Gu1knYL2KfFbieHN5SRT
 xXxQkL6+MYb8EH94pTGnjs0M2R6sE22uhrS6SJhv74bqZHj49KhnCj+JakynD/djwWD7
 ikg4CU5+GyFW4qwkrck9KLyoyvY5A7IGLxKhO1/Q1XQjnuf4oLFiHAhrFM7wDGu4BHNB
 epriJHqqth7uKZAr9Pyu3XvJTQzszqhyLTmBMVe+yDCrdTSwGjLyjLEmeshrSzpKMzz4
 qX2R2WyqUlXqB28suAdJxDZgYWK2S6fpWhhr+TMuozKLwn2XOl1uDa3p8+RMolqSDgT5
 0rlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cH7ct5X68dV4J5xr190rAMFwpjfS5nv2os2fFYotpQs=;
 b=uRKIGMalfcDrchDCURhn3CfOA/INl/aeKRBiq1zU9aeed9sN2ud17oRZivwgBBTBbS
 66V0I833tG138la8dlc1vT1hovJLD5xfm655YDyBUpyGZ79XwBca+rB+meI9hzZwQD7y
 fOHe/ka5ylvvQ6PkMWL75BuSq9qsdMUk/r87JgSKqPECjctWVa131R6bdN1TDgw9OIkC
 8xSyiy84hp7xQNuZm3noiMeR18peoC4lGiUZJFzkeA2Pz9hW5opj/d5L8mCZCSku6mlf
 KD6jBnIZyiCwx+8irkrIjxkewGL1S5ykdJ7sUM2HSAkCka2UE8dqshbmhkB4AyR7bNkL
 BNXw==
X-Gm-Message-State: APjAAAXVvv2M5Uu0Iu+Kmzdd6LDBizfEllSHp9U0qK30IvM9o6SfQsrb
 udKRqvWl3HobiR57DVtXqBlXKDBf
X-Google-Smtp-Source: APXvYqyExXy/iWaTjEA8EaVCZoUflLl5eoO9R6Ndk8akGQas80KaaGzGf2LSN+xhdkirT3nR3wOi5A==
X-Received: by 2002:a7b:c4c5:: with SMTP id g5mr3728446wmk.85.1578486817826;
 Wed, 08 Jan 2020 04:33:37 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/38] chardev: Use QEMUChrEvent enum in IOEventHandler typedef
Date: Wed,  8 Jan 2020 13:32:55 +0100
Message-Id: <1578486775-52247-39-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The Chardev events are listed in the QEMUChrEvent enum.

By using the enum in the IOEventHandler typedef we:

- make the IOEventHandler type more explicit (this handler
  process out-of-band information, while the IOReadHandler
  is in-band),
- help static code analyzers.

This patch was produced with the following spatch script:

  @match@
  expression backend, opaque, context, set_open;
  identifier fd_can_read, fd_read, fd_event, be_change;
  @@
  qemu_chr_fe_set_handlers(backend, fd_can_read, fd_read, fd_event,
                           be_change, opaque, context, set_open);

  @depends on match@
  identifier opaque, event;
  identifier match.fd_event;
  @@
   static
  -void fd_event(void *opaque, int event)
  +void fd_event(void *opaque, QEMUChrEvent event)
   {
   ...
   }

Then the typedef was modified manually in
include/chardev/char-fe.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20191218172009.8868-15-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/cryptodev-vhost-user.c | 2 +-
 chardev/char-mux.c              | 2 +-
 gdbstub.c                       | 2 +-
 hw/arm/pxa2xx.c                 | 2 +-
 hw/arm/strongarm.c              | 2 +-
 hw/block/vhost-user-blk.c       | 2 +-
 hw/char/cadence_uart.c          | 2 +-
 hw/char/digic-uart.c            | 2 +-
 hw/char/escc.c                  | 2 +-
 hw/char/etraxfs_ser.c           | 2 +-
 hw/char/exynos4210_uart.c       | 2 +-
 hw/char/grlib_apbuart.c         | 2 +-
 hw/char/imx_serial.c            | 2 +-
 hw/char/ipoctal232.c            | 2 +-
 hw/char/lm32_juart.c            | 2 +-
 hw/char/lm32_uart.c             | 2 +-
 hw/char/mcf_uart.c              | 2 +-
 hw/char/milkymist-uart.c        | 2 +-
 hw/char/nrf51_uart.c            | 2 +-
 hw/char/pl011.c                 | 2 +-
 hw/char/serial.c                | 2 +-
 hw/char/sh_serial.c             | 2 +-
 hw/char/terminal3270.c          | 2 +-
 hw/char/virtio-console.c        | 2 +-
 hw/char/xilinx_uartlite.c       | 2 +-
 hw/ipmi/ipmi_bmc_extern.c       | 2 +-
 hw/mips/boston.c                | 2 +-
 hw/mips/mips_malta.c            | 2 +-
 hw/riscv/riscv_htif.c           | 2 +-
 hw/riscv/sifive_uart.c          | 2 +-
 hw/usb/ccid-card-passthru.c     | 2 +-
 hw/usb/dev-serial.c             | 2 +-
 hw/usb/redirect.c               | 2 +-
 include/chardev/char-fe.h       | 2 +-
 monitor/hmp.c                   | 2 +-
 monitor/qmp.c                   | 2 +-
 net/filter-mirror.c             | 2 +-
 net/vhost-user.c                | 4 ++--
 qtest.c                         | 2 +-
 tests/test-char.c               | 6 +++---
 tests/vhost-user-test.c         | 2 +-
 41 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index f1b4079..6edada8 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -152,7 +152,7 @@ cryptodev_vhost_claim_chardev(CryptoDevBackendVhostUser *s,
     return chr;
 }
 
-static void cryptodev_vhost_user_event(void *opaque, int event)
+static void cryptodev_vhost_user_event(void *opaque, QEMUChrEvent event)
 {
     CryptoDevBackendVhostUser *s = opaque;
     CryptoDevBackend *b = CRYPTODEV_BACKEND(s);
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 2675ae0..46c44af 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -247,7 +247,7 @@ void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
     }
 }
 
-static void mux_chr_event(void *opaque, int event)
+static void mux_chr_event(void *opaque, QEMUChrEvent event)
 {
     mux_chr_send_all_event(CHARDEV(opaque), event);
 }
diff --git a/gdbstub.c b/gdbstub.c
index 4cf8af3..ce304ff 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -3171,7 +3171,7 @@ static void gdb_chr_receive(void *opaque, const uint8_t *buf, int size)
     }
 }
 
-static void gdb_chr_event(void *opaque, int event)
+static void gdb_chr_event(void *opaque, QEMUChrEvent event)
 {
     int i;
     GDBState *s = (GDBState *) opaque;
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index cdafde2..950ff42 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1955,7 +1955,7 @@ static void pxa2xx_fir_rx(void *opaque, const uint8_t *buf, int size)
     pxa2xx_fir_update(s);
 }
 
-static void pxa2xx_fir_event(void *opaque, int event)
+static void pxa2xx_fir_event(void *opaque, QEMUChrEvent event)
 {
 }
 
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 6bee034..c6776e8 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1093,7 +1093,7 @@ static void strongarm_uart_receive(void *opaque, const uint8_t *buf, int size)
     strongarm_uart_update_int_status(s);
 }
 
-static void strongarm_uart_event(void *opaque, int event)
+static void strongarm_uart_event(void *opaque, QEMUChrEvent event)
 {
     StrongARMUARTState *s = opaque;
     if (event == CHR_EVENT_BREAK) {
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index ccaf2ad..98b383f 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -361,7 +361,7 @@ static gboolean vhost_user_blk_watch(GIOChannel *chan, GIOCondition cond,
     return true;
 }
 
-static void vhost_user_blk_event(void *opaque, int event)
+static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
 {
     DeviceState *dev = opaque;
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 0e315b2..51791bd 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -348,7 +348,7 @@ static void uart_receive(void *opaque, const uint8_t *buf, int size)
     }
 }
 
-static void uart_event(void *opaque, int event)
+static void uart_event(void *opaque, QEMUChrEvent event)
 {
     CadenceUARTState *s = opaque;
     uint8_t buf = '\0';
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index 974a261..033eba0 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -131,7 +131,7 @@ static void uart_rx(void *opaque, const uint8_t *buf, int size)
     s->reg_rx = *buf;
 }
 
-static void uart_event(void *opaque, int event)
+static void uart_event(void *opaque, QEMUChrEvent event)
 {
 }
 
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 8f7bf32..c40c1d2 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -634,7 +634,7 @@ static void serial_receive1(void *opaque, const uint8_t *buf, int size)
     serial_receive_byte(s, buf[0]);
 }
 
-static void serial_event(void *opaque, int event)
+static void serial_event(void *opaque, QEMUChrEvent event)
 {
     ESCCChannelState *s = opaque;
     if (event == CHR_EVENT_BREAK)
diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
index 15ac12e..f34f767 100644
--- a/hw/char/etraxfs_ser.c
+++ b/hw/char/etraxfs_ser.c
@@ -202,7 +202,7 @@ static int serial_can_receive(void *opaque)
     return sizeof(s->rx_fifo) - s->rx_fifo_len;
 }
 
-static void serial_event(void *opaque, int event)
+static void serial_event(void *opaque, QEMUChrEvent event)
 {
 
 }
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index d6b6b62..7e5c5ce 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -528,7 +528,7 @@ static void exynos4210_uart_receive(void *opaque, const uint8_t *buf, int size)
 }
 
 
-static void exynos4210_uart_event(void *opaque, int event)
+static void exynos4210_uart_event(void *opaque, QEMUChrEvent event)
 {
     Exynos4210UartState *s = (Exynos4210UartState *)opaque;
 
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index fe3cbf4..8e59c3b 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -155,7 +155,7 @@ static void grlib_apbuart_receive(void *opaque, const uint8_t *buf, int size)
     }
 }
 
-static void grlib_apbuart_event(void *opaque, int event)
+static void grlib_apbuart_event(void *opaque, QEMUChrEvent event)
 {
     trace_grlib_apbuart_event(event);
 }
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index fddde9b..d09c210 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -323,7 +323,7 @@ static void imx_receive(void *opaque, const uint8_t *buf, int size)
     imx_put_data(opaque, *buf);
 }
 
-static void imx_event(void *opaque, int event)
+static void imx_event(void *opaque, QEMUChrEvent event)
 {
     if (event == CHR_EVENT_BREAK) {
         imx_put_data(opaque, URXD_BRK | URXD_FRMERR | URXD_ERR);
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 66c163b..80e9dff 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -503,7 +503,7 @@ static void hostdev_receive(void *opaque, const uint8_t *buf, int size)
     }
 }
 
-static void hostdev_event(void *opaque, int event)
+static void hostdev_event(void *opaque, QEMUChrEvent event)
 {
     SCC2698Channel *ch = opaque;
     switch (event) {
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index e0b1bd6..da9dd56 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -104,7 +104,7 @@ static int juart_can_rx(void *opaque)
     return !(s->jrx & JRX_FULL);
 }
 
-static void juart_event(void *opaque, int event)
+static void juart_event(void *opaque, QEMUChrEvent event)
 {
 }
 
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index 32f29c4..8d7a475 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -235,7 +235,7 @@ static int uart_can_rx(void *opaque)
     return !(s->regs[R_LSR] & LSR_DR);
 }
 
-static void uart_event(void *opaque, int event)
+static void uart_event(void *opaque, QEMUChrEvent event)
 {
 }
 
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 58323ba..2de3680 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -256,7 +256,7 @@ static void mcf_uart_push_byte(mcf_uart_state *s, uint8_t data)
     mcf_uart_update(s);
 }
 
-static void mcf_uart_event(void *opaque, int event)
+static void mcf_uart_event(void *opaque, QEMUChrEvent event)
 {
     mcf_uart_state *s = (mcf_uart_state *)opaque;
 
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index c358ca0..1c7b614 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -180,7 +180,7 @@ static int uart_can_rx(void *opaque)
     return !(s->regs[R_STAT] & STAT_RX_EVT);
 }
 
-static void uart_event(void *opaque, int event)
+static void uart_event(void *opaque, QEMUChrEvent event)
 {
 }
 
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index 2777afe..b67fd21 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -245,7 +245,7 @@ static int uart_can_receive(void *opaque)
     return s->rx_started ? (UART_FIFO_LENGTH - s->rx_fifo_len) : 0;
 }
 
-static void uart_event(void *opaque, int event)
+static void uart_event(void *opaque, QEMUChrEvent event)
 {
     NRF51UARTState *s = NRF51_UART(opaque);
 
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 84ad8ff..23cd544 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -280,7 +280,7 @@ static void pl011_receive(void *opaque, const uint8_t *buf, int size)
     pl011_put_fifo(opaque, *buf);
 }
 
-static void pl011_event(void *opaque, int event)
+static void pl011_event(void *opaque, QEMUChrEvent event)
 {
     if (event == CHR_EVENT_BREAK)
         pl011_put_fifo(opaque, 0x400);
diff --git a/hw/char/serial.c b/hw/char/serial.c
index b4aa250..992b5ee 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -634,7 +634,7 @@ static void serial_receive1(void *opaque, const uint8_t *buf, int size)
     serial_update_irq(s);
 }
 
-static void serial_event(void *opaque, int event)
+static void serial_event(void *opaque, QEMUChrEvent event)
 {
     SerialState *s = opaque;
     DPRINTF("event %x\n", event);
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 07dc16b..167f4d8 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -358,7 +358,7 @@ static void sh_serial_receive1(void *opaque, const uint8_t *buf, int size)
     }
 }
 
-static void sh_serial_event(void *opaque, int event)
+static void sh_serial_event(void *opaque, QEMUChrEvent event)
 {
     sh_serial_state *s = opaque;
     if (event == CHR_EVENT_BREAK)
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 2aab04f..f7aba12 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -142,7 +142,7 @@ static void terminal_read(void *opaque, const uint8_t *buf, int size)
     }
 }
 
-static void chr_event(void *opaque, int event)
+static void chr_event(void *opaque, QEMUChrEvent event)
 {
     Terminal3270 *t = opaque;
     CcwDevice *ccw_dev = CCW_DEVICE(t);
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index cbb304d..a7d34fe 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -145,7 +145,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     virtio_serial_write(port, buf, size);
 }
 
-static void chr_event(void *opaque, int event)
+static void chr_event(void *opaque, QEMUChrEvent event)
 {
     VirtConsole *vcon = opaque;
     VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(vcon);
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 2c47275..aa6bf02 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -206,7 +206,7 @@ static int uart_can_rx(void *opaque)
     return s->rx_fifo_len < sizeof(s->rx_fifo);
 }
 
-static void uart_event(void *opaque, int event)
+static void uart_event(void *opaque, QEMUChrEvent event)
 {
 
 }
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index adf2afe..16a4117 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -379,7 +379,7 @@ static void receive(void *opaque, const uint8_t *buf, int size)
     handle_hw_op(ibe, hw_op);
 }
 
-static void chr_event(void *opaque, int event)
+static void chr_event(void *opaque, QEMUChrEvent event)
 {
     IPMIBmcExtern *ibe = opaque;
     IPMIInterface *s = ibe->parent.intf;
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index ca7d813..29b476b 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -98,7 +98,7 @@ enum boston_plat_reg {
     PLAT_SYS_CTL        = 0x48,
 };
 
-static void boston_lcd_event(void *opaque, int event)
+static void boston_lcd_event(void *opaque, QEMUChrEvent event)
 {
     BostonState *s = opaque;
     if (event == CHR_EVENT_OPENED && !s->lcd_inited) {
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 783cd99..72c03ba 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -545,7 +545,7 @@ static void malta_fpga_reset(void *opaque)
     snprintf(s->display_text, 9, "        ");
 }
 
-static void malta_fgpa_display_event(void *opaque, int event)
+static void malta_fgpa_display_event(void *opaque, QEMUChrEvent event)
 {
     MaltaFPGAState *s = opaque;
 
diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
index 4f7b11d..ca87a5c 100644
--- a/hw/riscv/riscv_htif.c
+++ b/hw/riscv/riscv_htif.c
@@ -96,7 +96,7 @@ static void htif_recv(void *opaque, const uint8_t *buf, int size)
  * Called by the char dev to supply special events to the HTIF console.
  * Not used for HTIF.
  */
-static void htif_event(void *opaque, int event)
+static void htif_event(void *opaque, QEMUChrEvent event)
 {
 
 }
diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
index a403ae9..9350482 100644
--- a/hw/riscv/sifive_uart.c
+++ b/hw/riscv/sifive_uart.c
@@ -162,7 +162,7 @@ static int uart_can_rx(void *opaque)
     return s->rx_fifo_len < sizeof(s->rx_fifo);
 }
 
-static void uart_event(void *opaque, int event)
+static void uart_event(void *opaque, QEMUChrEvent event)
 {
 }
 
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index e53696c..3d40b70 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -307,7 +307,7 @@ static void ccid_card_vscard_read(void *opaque, const uint8_t *buf, int size)
     }
 }
 
-static void ccid_card_vscard_event(void *opaque, int event)
+static void ccid_card_vscard_event(void *opaque, QEMUChrEvent event)
 {
     PassthruState *card = opaque;
 
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 2ba6870..9646fe7 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -461,7 +461,7 @@ static void usb_serial_read(void *opaque, const uint8_t *buf, int size)
     s->recv_used += size;
 }
 
-static void usb_serial_event(void *opaque, int event)
+static void usb_serial_event(void *opaque, QEMUChrEvent event)
 {
     USBSerialState *s = opaque;
 
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index ddc1a59..0068aa8 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1354,7 +1354,7 @@ static void usbredir_chardev_read(void *opaque, const uint8_t *buf, int size)
     usbredirparser_do_write(dev->parser);
 }
 
-static void usbredir_chardev_event(void *opaque, int event)
+static void usbredir_chardev_event(void *opaque, QEMUChrEvent event)
 {
     USBRedirDevice *dev = opaque;
 
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 67601dc..a553843 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -4,7 +4,7 @@
 #include "chardev/char.h"
 #include "qemu/main-loop.h"
 
-typedef void IOEventHandler(void *opaque, int event);
+typedef void IOEventHandler(void *opaque, QEMUChrEvent event);
 typedef int BackendChangeHandler(void *opaque);
 
 /* This is the backend as seen by frontend, the actual backend is
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 706ebe7..944fa96 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1322,7 +1322,7 @@ static void monitor_read(void *opaque, const uint8_t *buf, int size)
     cur_mon = old_mon;
 }
 
-static void monitor_event(void *opaque, int event)
+static void monitor_event(void *opaque, QEMUChrEvent event)
 {
     Monitor *mon = opaque;
     MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 6c46be4..54c06ba 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -337,7 +337,7 @@ static QDict *qmp_greeting(MonitorQMP *mon)
         ver, cap_list);
 }
 
-static void monitor_qmp_event(void *opaque, int event)
+static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
 {
     QDict *data;
     MonitorQMP *mon = opaque;
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 8d36009..d83e815 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -132,7 +132,7 @@ static void redirector_chr_read(void *opaque, const uint8_t *buf, int size)
     }
 }
 
-static void redirector_chr_event(void *opaque, int event)
+static void redirector_chr_event(void *opaque, QEMUChrEvent event)
 {
     NetFilterState *nf = opaque;
     MirrorState *s = FILTER_REDIRECTOR(nf);
diff --git a/net/vhost-user.c b/net/vhost-user.c
index c54c9c7..17532da 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -218,7 +218,7 @@ static gboolean net_vhost_user_watch(GIOChannel *chan, GIOCondition cond,
     return TRUE;
 }
 
-static void net_vhost_user_event(void *opaque, int event);
+static void net_vhost_user_event(void *opaque, QEMUChrEvent event);
 
 static void chr_closed_bh(void *opaque)
 {
@@ -249,7 +249,7 @@ static void chr_closed_bh(void *opaque)
     }
 }
 
-static void net_vhost_user_event(void *opaque, int event)
+static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
 {
     const char *name = opaque;
     NetClientState *ncs[MAX_QUEUE_NUM];
diff --git a/qtest.c b/qtest.c
index 8b50e27..12432f9 100644
--- a/qtest.c
+++ b/qtest.c
@@ -722,7 +722,7 @@ static int qtest_can_read(void *opaque)
     return 1024;
 }
 
-static void qtest_event(void *opaque, int event)
+static void qtest_event(void *opaque, QEMUChrEvent event)
 {
     int i;
 
diff --git a/tests/test-char.c b/tests/test-char.c
index 45e42af..3afc9b1 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -54,7 +54,7 @@ static void fe_read(void *opaque, const uint8_t *buf, int size)
     quit = true;
 }
 
-static void fe_event(void *opaque, int event)
+static void fe_event(void *opaque, QEMUChrEvent event)
 {
     FeHandler *h = opaque;
     bool new_open_state;
@@ -633,7 +633,7 @@ typedef struct {
 
 
 static void
-char_socket_event(void *opaque, int event)
+char_socket_event(void *opaque, QEMUChrEvent event)
 {
     CharSocketTestData *data = opaque;
     data->event = event;
@@ -1006,7 +1006,7 @@ static void char_socket_client_test(gconstpointer opaque)
 }
 
 static void
-count_closed_event(void *opaque, int event)
+count_closed_event(void *opaque, QEMUChrEvent event)
 {
     int *count = opaque;
     if (event == CHR_EVENT_CLOSED) {
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 91ea373..2324b96 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -499,7 +499,7 @@ static TestServer *test_server_new(const gchar *name)
     return server;
 }
 
-static void chr_event(void *opaque, int event)
+static void chr_event(void *opaque, QEMUChrEvent event)
 {
     TestServer *s = opaque;
 
-- 
1.8.3.1


