Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D149C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B23D2223C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B23D2223C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpZw-0001Xf-5l
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQy-00069e-Et; Tue, 20 Oct 2020 07:04:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5264 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQt-0006nv-4i; Tue, 20 Oct 2020 07:04:04 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E32CAAC50C1082C41038;
 Tue, 20 Oct 2020 19:03:54 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 20 Oct 2020
 19:03:47 +0800
From: Gan Qixin <ganqixin@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH 08/10] hw/char/:split some lines containing more than 80
 characters
Date: Tue, 20 Oct 2020 04:30:21 +0800
Message-ID: <20201019203023.658555-9-ganqixin@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201019203023.658555-1-ganqixin@huawei.com>
References: <20201019203023.658555-1-ganqixin@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=ganqixin@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:03:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org,
 zhang.zhanghailiang@huawei.com, mst@redhat.com, f4bug@amsat.org,
 alistair.francis@wdc.com, Gan Qixin <ganqixin@huawei.com>,
 kuhn.chenqun@huawei.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using scripts/checkpatch.pl, it is found that many files in hw/char/
contain lines with more than 80 characters.

Signed-off-by: Gan Qixin <ganqixin@huawei.com>
---
 hw/char/ibex_uart.c         | 12 +++++---
 hw/char/omap_uart.c         |  3 +-
 hw/char/parallel.c          | 12 +++++---
 hw/char/serial.c            | 57 ++++++++++++++++++++++++++-----------
 hw/char/virtio-serial-bus.c |  3 +-
 5 files changed, 60 insertions(+), 27 deletions(-)

diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index cc49a35013..9e363d72ee 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -36,25 +36,29 @@
 
 static void ibex_uart_update_irqs(IbexUartState *s)
 {
-    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_TX_WATERMARK_MASK) {
+    if (s->uart_intr_state & s->uart_intr_enable &
+        R_INTR_STATE_TX_WATERMARK_MASK) {
         qemu_set_irq(s->tx_watermark, 1);
     } else {
         qemu_set_irq(s->tx_watermark, 0);
     }
 
-    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_RX_WATERMARK_MASK) {
+    if (s->uart_intr_state & s->uart_intr_enable &
+        R_INTR_STATE_RX_WATERMARK_MASK) {
         qemu_set_irq(s->rx_watermark, 1);
     } else {
         qemu_set_irq(s->rx_watermark, 0);
     }
 
-    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_TX_EMPTY_MASK) {
+    if (s->uart_intr_state & s->uart_intr_enable &
+        R_INTR_STATE_TX_EMPTY_MASK) {
         qemu_set_irq(s->tx_empty, 1);
     } else {
         qemu_set_irq(s->tx_empty, 0);
     }
 
-    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_RX_OVERFLOW_MASK) {
+    if (s->uart_intr_state & s->uart_intr_enable &
+        R_INTR_STATE_RX_OVERFLOW_MASK) {
         qemu_set_irq(s->rx_overflow, 1);
     } else {
         qemu_set_irq(s->rx_overflow, 0);
diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index e8da933378..e45f5bf117 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -168,7 +168,8 @@ struct omap_uart_s *omap2_uart_init(MemoryRegion *sysmem,
     struct omap_uart_s *s = omap_uart_init(base, irq,
                     fclk, iclk, txdma, rxdma, label, chr);
 
-    memory_region_init_io(&s->iomem, NULL, &omap_uart_ops, s, "omap.uart", 0x100);
+    memory_region_init_io(&s->iomem, NULL, &omap_uart_ops, s,
+                          "omap.uart", 0x100);
 
     s->ta = ta;
 
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 8b418abf71..b1f6a0572b 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -73,7 +73,8 @@
 #define PARA_CTR_AUTOLF	0x02	/* Auto linefeed complement */
 #define PARA_CTR_STROBE	0x01	/* Strobe complement */
 
-#define PARA_CTR_SIGNAL (PARA_CTR_SELECT|PARA_CTR_INIT|PARA_CTR_AUTOLF|PARA_CTR_STROBE)
+#define PARA_CTR_SIGNAL (PARA_CTR_SELECT | PARA_CTR_INIT | PARA_CTR_AUTOLF | \
+                         PARA_CTR_STROBE)
 
 typedef struct ParallelState {
     MemoryRegion iomem;
@@ -294,7 +295,8 @@ static uint32_t parallel_ioport_read_sw(void *opaque, uint32_t addr)
     case PARA_REG_STS:
         ret = s->status;
         s->irq_pending = 0;
-        if ((s->status & PARA_STS_BUSY) == 0 && (s->control & PARA_CTR_STROBE) == 0) {
+        if ((s->status & PARA_STS_BUSY) == 0 &&
+            (s->control & PARA_CTR_STROBE) == 0) {
             /* XXX Fixme: wait 5 microseconds */
             if (s->status & PARA_STS_ACK)
                 s->status &= ~PARA_STS_ACK;
@@ -397,7 +399,8 @@ parallel_ioport_eppdata_read_hw2(void *opaque, uint32_t addr)
     struct ParallelIOArg ioarg = {
         .buffer = &eppdata, .count = sizeof(eppdata)
     };
-    if ((s->control & (PARA_CTR_DIR|PARA_CTR_SIGNAL)) != (PARA_CTR_DIR|PARA_CTR_INIT)) {
+    if ((s->control & (PARA_CTR_DIR | PARA_CTR_SIGNAL)) !=
+        (PARA_CTR_DIR | PARA_CTR_INIT)) {
         /* Controls not correct for EPP data cycle, so do nothing */
         pdebug("re%04x s\n", eppdata);
         return eppdata;
@@ -425,7 +428,8 @@ parallel_ioport_eppdata_read_hw4(void *opaque, uint32_t addr)
     struct ParallelIOArg ioarg = {
         .buffer = &eppdata, .count = sizeof(eppdata)
     };
-    if ((s->control & (PARA_CTR_DIR|PARA_CTR_SIGNAL)) != (PARA_CTR_DIR|PARA_CTR_INIT)) {
+    if ((s->control & (PARA_CTR_DIR | PARA_CTR_SIGNAL)) !=
+        (PARA_CTR_DIR | PARA_CTR_INIT)) {
         /* Controls not correct for EPP data cycle, so do nothing */
         pdebug("re%08x s\n", eppdata);
         return eppdata;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 97f71879ff..cbc662e077 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -86,7 +86,10 @@
 #define UART_LSR_DR	0x01	/* Receiver data ready */
 #define UART_LSR_INT_ANY 0x1E	/* Any of the lsr-interrupt-triggering status bits */
 
-/* Interrupt trigger levels. The byte-counts are for 16550A - in newer UARTs the byte-count for each ITL is higher. */
+/*
+ * Interrupt trigger levels. The byte-counts are for 16550A - in newer UARTs the
+ * byte-count for each ITL is higher.
+ */
 
 #define UART_FCR_ITL_1      0x00 /* 1 byte ITL */
 #define UART_FCR_ITL_2      0x40 /* 4 bytes ITL */
@@ -195,10 +198,14 @@ static void serial_update_msl(SerialState *s)
 
     omsr = s->msr;
 
-    s->msr = (flags & CHR_TIOCM_CTS) ? s->msr | UART_MSR_CTS : s->msr & ~UART_MSR_CTS;
-    s->msr = (flags & CHR_TIOCM_DSR) ? s->msr | UART_MSR_DSR : s->msr & ~UART_MSR_DSR;
-    s->msr = (flags & CHR_TIOCM_CAR) ? s->msr | UART_MSR_DCD : s->msr & ~UART_MSR_DCD;
-    s->msr = (flags & CHR_TIOCM_RI) ? s->msr | UART_MSR_RI : s->msr & ~UART_MSR_RI;
+    s->msr = (flags & CHR_TIOCM_CTS) ? s->msr | UART_MSR_CTS :
+              s->msr & ~UART_MSR_CTS;
+    s->msr = (flags & CHR_TIOCM_DSR) ? s->msr | UART_MSR_DSR :
+              s->msr & ~UART_MSR_DSR;
+    s->msr = (flags & CHR_TIOCM_CAR) ? s->msr | UART_MSR_DCD :
+              s->msr & ~UART_MSR_DCD;
+    s->msr = (flags & CHR_TIOCM_RI) ? s->msr | UART_MSR_RI :
+              s->msr & ~UART_MSR_RI;
 
     if (s->msr != omsr) {
          /* Set delta bits */
@@ -209,8 +216,11 @@ static void serial_update_msl(SerialState *s)
          serial_update_irq(s);
     }
 
-    /* The real 16550A apparently has a 250ns response latency to line status changes.
-       We'll be lazy and poll only every 10ms, and only poll it at all if MSI interrupts are turned on */
+    /*
+     * The real 16550A apparently has a 250ns response latency to line status
+     * changes. We'll be lazy and poll only every 10ms, and only poll it at all
+     * if MSI interrupts are turned on
+     */
 
     if (s->poll_msl) {
         timer_mod(s->modem_status_poll, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
@@ -369,8 +379,10 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
         } else {
             uint8_t changed = (s->ier ^ val) & 0x0f;
             s->ier = val & 0x0f;
-            /* If the backend device is a real serial port, turn polling of the modem
-             * status lines on physical port on or off depending on UART_IER_MSI state.
+            /*
+             * If the backend device is a real serial port, turn polling of the
+             * modem status lines on physical port on or off depending on
+             * UART_IER_MSI state.
              */
             if ((changed & UART_IER_MSI) && s->poll_msl >= 0) {
                 if (s->ier & UART_IER_MSI) {
@@ -386,9 +398,9 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
              * if LSR.THRE=1, even if it had been masked before by reading IIR.
              * This is not in the datasheet, but Windows relies on it.  It is
              * unclear if THRE has to be resampled every time THRI becomes
-             * 1, or only on the rising edge.  Bochs does the latter, and Windows
-             * always toggles IER to all zeroes and back to all ones, so do the
-             * same.
+             * 1, or only on the rising edge.  Bochs does the latter, and
+             * Windows always toggles IER to all zeroes and back to all ones,
+             * so do the same.
              *
              * If IER.THRI is zero, thr_ipending is not used.  Set it to zero
              * so that the thr_ipending subsection is not migrated.
@@ -407,7 +419,10 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
         }
         break;
     case 2:
-        /* Did the enable/disable flag change? If so, make sure FIFOs get flushed */
+        /*
+         * Did the enable/disable flag change? If so, make sure FIFOs get
+         * flushed
+         */
         if ((val ^ s->fcr) & UART_FCR_FE) {
             val |= UART_FCR_XFR | UART_FCR_RFR;
         }
@@ -452,9 +467,14 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
 
             if (s->poll_msl >= 0 && old_mcr != s->mcr) {
                 serial_update_tiocm(s);
-                /* Update the modem status after a one-character-send wait-time, since there may be a response
-                   from the device/computer at the other end of the serial line */
-                timer_mod(s->modem_status_poll, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->char_transmit_time);
+                /*
+                 * Update the modem status after a one-character-send wait-time,
+                 * since there may be a response from the device/computer at the
+                 * other end of the serial line
+                 */
+                timer_mod(s->modem_status_poll,
+                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                          s->char_transmit_time);
             }
         }
         break;
@@ -584,7 +604,10 @@ static void serial_receive_break(SerialState *s)
     serial_update_irq(s);
 }
 
-/* There's data in recv_fifo and s->rbr has not been read for 4 char transmit times */
+/*
+ * There's data in recv_fifo and s->rbr has not been read for 4 char transmit
+ * times
+ */
 static void fifo_timeout_int (void *opaque) {
     SerialState *s = opaque;
     if (s->recv_fifo.num) {
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index cf08ef9728..5921377c51 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1085,7 +1085,8 @@ static void virtio_serial_device_realize(DeviceState *dev, Error **errp)
         vser->ovqs[i] = virtio_add_queue(vdev, 128, handle_output);
     }
 
-    vser->ports_map = g_malloc0((DIV_ROUND_UP(vser->serial.max_virtserial_ports, 32))
+    vser->ports_map = g_malloc0((DIV_ROUND_UP(vser->serial.max_virtserial_ports,
+                                              32))
         * sizeof(vser->ports_map[0]));
     /*
      * Reserve location 0 for a console port for backward compat
-- 
2.23.0


