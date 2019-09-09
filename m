Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1803EC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45FC2086D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45FC2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7MAv-0005ub-Fh
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 12:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7M4N-0008V4-UM
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7M4J-0001jF-R4
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:59:11 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:45969)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i7M4A-0001dV-UH; Mon, 09 Sep 2019 11:59:00 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MmUcL-1iY8Ee3yuv-00iUVo; Mon, 09 Sep 2019 17:58:22 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Mon,  9 Sep 2019 17:58:05 +0200
Message-Id: <20190909155813.27760-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909155813.27760-1-laurent@vivier.eu>
References: <20190909155813.27760-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6/mzJe7Fl0+WsYlXB2+PgIP5vNZQhmX0CPCBJ+czyviI7OlFZGj
 THH/akNJ2epPnQv3MW4SqN3krldQAX3hWLYcZo/JazR9clkHeTx4kq0Mc2qUDmav29j+cXI
 b1jJ2oF+bgZF/kUGMKP6mAZ5XStNU3Y4bJfFWLZ4tfGY8bVPxin3x2ugaXaqeTaknNoBt4K
 FzDyyUnv6AIU+bMg4W4ZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OvB1iw7gfZQ=:3FrUXUMFVVcT1GI5Pd3gnm
 EjGTuv5SpP73Ulk38a+fM9DH2/vaEtbczeh1TsKzCpRkOytfNgBxm7gdCQcAXffkjGbdTXf9g
 QdjrBt5Vm19hRImgvn3z1W0Du45EYxMU/Iv8XTIfzwCIx6087j+ssVd2ZjoiFC23LBeUTNhv0
 r45qYITgiTEi6WDrhqbNomEGAME7s9KrSaYPc4J4++afFRtsVBfDBIKv6hbkQ5Q/PHkTcuAem
 3r7pytbIwmFKP5VCMMPXQp1SuEAb3X5znKTuDro0xVlMhfnqY5kcC5URaAYYrqOb/VRyYbLoz
 hHQrkP8TcoCmK027ICVMBLpceG/qjLgfrvxtsCRrwgAINGuitH4B3q9rr2mVom8Lhrw8WijB/
 xg+XkJ7H631Q7duLW3jY4myrxVgwGhIEa/wU6RFbwQG+8Vh2QPeUgUMRzUwcg//8myeJOCsxy
 I99yAP86p6PSJ91xK9F3+bKI0DyIDOLJjCtDSfp9WqM3j79AxEQB/7IV2LIX84nf7NvPUSIUQ
 hPazD7NuzfRBz0mRLzkbI+ZQxK1QmmH8LH+M8g8JGGdGyCAMq4CN1gmuhZzt23wQuEGY8IFOd
 q/JI78YKTOSSid58ltYzs3LF0JB+aqe5mfbs5HDU4TOQLKdt8ci1ux/QTxUrV2yHmaxnr/SJ5
 klftny9MPJCjWXbMQ6L4m1xvZmByknxPZwUU7qcFoBbC4xW4RBQCkVRFrk+vxGf6DyGWwgoJD
 r1RfW9FTiQnWZT40MFLsLJ7tdgfbLU82LO/+rIxdVfqCAksqB0poS7skN/Rj7ci9W4vf+UDRt
 T8byKglUfQnHtyLSxVKIELrGKgp4LfuUziNWwzLQtusQMMXhzk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PATCH v9 1/9] esp: add pseudo-DMA as used by Macintosh
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no DMA in Quadra 800, so the CPU reads/writes the data from the
PDMA register (offset 0x100, ESP_PDMA in hw/m68k/q800.c) and copies them
to/from the memory.

There is a nice assembly loop in the kernel to do that, see
linux/drivers/scsi/mac_esp.c:MAC_ESP_PDMA_LOOP().

The start of the transfer is triggered by the DREQ interrupt (see linux
mac_esp_send_pdma_cmd()), the CPU polls on the IRQ flag to start the
transfer after a SCSI command has been sent (in Quadra 800 it goes
through the VIA2, the via2-irq line and the vIFR register)

The Macintosh hardware includes hardware handshaking to prevent the CPU
from reading invalid data or writing data faster than the peripheral
device can accept it.

This is the "blind mode", and from the doc:
"Approximate maximum SCSI transfer rates within a blocks are 1.4 MB per
second for blind transfers in the Macintosh II"

Some references can be found in:
  Apple Macintosh Family Hardware Reference, ISBN 0-201-19255-1
  Guide to the Macintosh Family Hardware, ISBN-0-201-52405-8

Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/scsi/esp.c         | 296 +++++++++++++++++++++++++++++++++++++-----
 include/hw/scsi/esp.h |   7 +
 2 files changed, 274 insertions(+), 29 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 841d79b60e..ffbeee9f3c 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -38,6 +38,8 @@
  * http://www.ibiblio.org/pub/historic-linux/early-ports/Sparc/NCR/NCR89C100.txt
  * and
  * http://www.ibiblio.org/pub/historic-linux/early-ports/Sparc/NCR/NCR53C9X.txt
+ *
+ * On Macintosh Quadra it is a NCR53C96.
  */
 
 static void esp_raise_irq(ESPState *s)
@@ -58,6 +60,16 @@ static void esp_lower_irq(ESPState *s)
     }
 }
 
+static void esp_raise_drq(ESPState *s)
+{
+    qemu_irq_raise(s->irq_data);
+}
+
+static void esp_lower_drq(ESPState *s)
+{
+    qemu_irq_lower(s->irq_data);
+}
+
 void esp_dma_enable(ESPState *s, int irq, int level)
 {
     if (level) {
@@ -84,29 +96,11 @@ void esp_request_cancelled(SCSIRequest *req)
     }
 }
 
-static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
+static int get_cmd_cb(ESPState *s)
 {
-    uint32_t dmalen;
     int target;
 
     target = s->wregs[ESP_WBUSID] & BUSID_DID;
-    if (s->dma) {
-        dmalen = s->rregs[ESP_TCLO];
-        dmalen |= s->rregs[ESP_TCMID] << 8;
-        dmalen |= s->rregs[ESP_TCHI] << 16;
-        if (dmalen > buflen) {
-            return 0;
-        }
-        s->dma_memory_read(s->dma_opaque, buf, dmalen);
-    } else {
-        dmalen = s->ti_size;
-        if (dmalen > TI_BUFSZ) {
-            return 0;
-        }
-        memcpy(buf, s->ti_buf, dmalen);
-        buf[0] = buf[2] >> 5;
-    }
-    trace_esp_get_cmd(dmalen, target);
 
     s->ti_size = 0;
     s->ti_rptr = 0;
@@ -125,8 +119,48 @@ static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
         s->rregs[ESP_RINTR] = INTR_DC;
         s->rregs[ESP_RSEQ] = SEQ_0;
         esp_raise_irq(s);
+        return -1;
+    }
+    return 0;
+}
+
+static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
+{
+    int target;
+    uint32_t dmalen;
+
+    target = s->wregs[ESP_WBUSID] & BUSID_DID;
+    if (s->dma) {
+        dmalen = s->rregs[ESP_TCLO];
+        dmalen |= s->rregs[ESP_TCMID] << 8;
+        dmalen |= s->rregs[ESP_TCHI] << 16;
+        if (dmalen > buflen) {
+            return 0;
+        }
+        if (s->dma_memory_read) {
+            s->dma_memory_read(s->dma_opaque, buf, dmalen);
+        } else {
+            memcpy(s->pdma_buf, buf, dmalen);
+            s->pdma_len = dmalen;
+            s->pdma_start = s->pdma_buf;
+            s->pdma_cur = s->pdma_buf;
+            esp_raise_drq(s);
+            return 0;
+        }
+    } else {
+        dmalen = s->ti_size;
+        if (dmalen > TI_BUFSZ) {
+            return 0;
+        }
+        memcpy(buf, s->ti_buf, dmalen);
+        buf[0] = buf[2] >> 5;
+    }
+    trace_esp_get_cmd(dmalen, target);
+
+    if (get_cmd_cb(s) < 0) {
         return 0;
     }
+
     return dmalen;
 }
 
@@ -165,6 +199,16 @@ static void do_cmd(ESPState *s, uint8_t *buf)
     do_busid_cmd(s, &buf[1], busid);
 }
 
+static void satn_pdma_cb(ESPState *s)
+{
+    if (get_cmd_cb(s) < 0) {
+        return;
+    }
+    if (s->pdma_cur != s->pdma_start) {
+        do_cmd(s, s->pdma_start);
+    }
+}
+
 static void handle_satn(ESPState *s)
 {
     uint8_t buf[32];
@@ -174,11 +218,22 @@ static void handle_satn(ESPState *s)
         s->dma_cb = handle_satn;
         return;
     }
+    s->pdma_cb = satn_pdma_cb;
     len = get_cmd(s, buf, sizeof(buf));
     if (len)
         do_cmd(s, buf);
 }
 
+static void s_without_satn_pdma_cb(ESPState *s)
+{
+    if (get_cmd_cb(s) < 0) {
+        return;
+    }
+    if (s->pdma_cur != s->pdma_start) {
+        do_busid_cmd(s, s->pdma_start, 0);
+    }
+}
+
 static void handle_s_without_atn(ESPState *s)
 {
     uint8_t buf[32];
@@ -188,18 +243,36 @@ static void handle_s_without_atn(ESPState *s)
         s->dma_cb = handle_s_without_atn;
         return;
     }
+    s->pdma_cb = s_without_satn_pdma_cb;
     len = get_cmd(s, buf, sizeof(buf));
     if (len) {
         do_busid_cmd(s, buf, 0);
     }
 }
 
+static void satn_stop_pdma_cb(ESPState *s)
+{
+    if (get_cmd_cb(s) < 0) {
+        return;
+    }
+    s->cmdlen = s->pdma_cur - s->pdma_start;
+    if (s->cmdlen) {
+        trace_esp_handle_satn_stop(s->cmdlen);
+        s->do_cmd = 1;
+        s->rregs[ESP_RSTAT] = STAT_TC | STAT_CD;
+        s->rregs[ESP_RINTR] = INTR_BS | INTR_FC;
+        s->rregs[ESP_RSEQ] = SEQ_CD;
+        esp_raise_irq(s);
+    }
+}
+
 static void handle_satn_stop(ESPState *s)
 {
     if (s->dma && !s->dma_enabled) {
         s->dma_cb = handle_satn_stop;
         return;
     }
+    s->pdma_cb = satn_stop_pdma_cb;;
     s->cmdlen = get_cmd(s, s->cmdbuf, sizeof(s->cmdbuf));
     if (s->cmdlen) {
         trace_esp_handle_satn_stop(s->cmdlen);
@@ -211,16 +284,33 @@ static void handle_satn_stop(ESPState *s)
     }
 }
 
+static void write_response_pdma_cb(ESPState *s)
+{
+    s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
+    s->rregs[ESP_RINTR] = INTR_BS | INTR_FC;
+    s->rregs[ESP_RSEQ] = SEQ_CD;
+    esp_raise_irq(s);
+}
+
 static void write_response(ESPState *s)
 {
     trace_esp_write_response(s->status);
     s->ti_buf[0] = s->status;
     s->ti_buf[1] = 0;
     if (s->dma) {
-        s->dma_memory_write(s->dma_opaque, s->ti_buf, 2);
-        s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
-        s->rregs[ESP_RINTR] = INTR_BS | INTR_FC;
-        s->rregs[ESP_RSEQ] = SEQ_CD;
+        if (s->dma_memory_write) {
+            s->dma_memory_write(s->dma_opaque, s->ti_buf, 2);
+            s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
+            s->rregs[ESP_RINTR] = INTR_BS | INTR_FC;
+            s->rregs[ESP_RSEQ] = SEQ_CD;
+        } else {
+            s->pdma_len = 2;
+            s->pdma_start = s->ti_buf;
+            s->pdma_cur = s->ti_buf;
+            s->pdma_cb = write_response_pdma_cb;
+            esp_raise_drq(s);
+            return;
+        }
     } else {
         s->ti_size = 2;
         s->ti_rptr = 0;
@@ -242,6 +332,41 @@ static void esp_dma_done(ESPState *s)
     esp_raise_irq(s);
 }
 
+static void do_dma_pdma_cb(ESPState *s)
+{
+    int to_device = (s->ti_size < 0);
+    int len = s->pdma_cur - s->pdma_start;
+    if (s->do_cmd) {
+        s->ti_size = 0;
+        s->cmdlen = 0;
+        s->do_cmd = 0;
+        do_cmd(s, s->cmdbuf);
+        return;
+    }
+    s->dma_left -= len;
+    s->async_buf += len;
+    s->async_len -= len;
+    if (to_device) {
+        s->ti_size += len;
+    } else {
+        s->ti_size -= len;
+    }
+    if (s->async_len == 0) {
+        scsi_req_continue(s->current_req);
+        /*
+         * If there is still data to be read from the device then
+         * complete the DMA operation immediately.  Otherwise defer
+         * until the scsi layer has completed.
+         */
+        if (to_device || s->dma_left != 0 || s->ti_size == 0) {
+            return;
+        }
+    }
+
+    /* Partially filled a scsi buffer. Complete immediately.  */
+    esp_dma_done(s);
+}
+
 static void esp_do_dma(ESPState *s)
 {
     uint32_t len;
@@ -252,10 +377,27 @@ static void esp_do_dma(ESPState *s)
         trace_esp_do_dma(s->cmdlen, len);
         assert (s->cmdlen <= sizeof(s->cmdbuf) &&
                 len <= sizeof(s->cmdbuf) - s->cmdlen);
-        s->dma_memory_read(s->dma_opaque, &s->cmdbuf[s->cmdlen], len);
+        if (s->dma_memory_read) {
+            s->dma_memory_read(s->dma_opaque, &s->cmdbuf[s->cmdlen], len);
+        } else {
+            s->pdma_len = len;
+            s->pdma_start = &s->cmdbuf[s->cmdlen];
+            s->pdma_cur = &s->cmdbuf[s->cmdlen];
+            s->pdma_cb = do_dma_pdma_cb;
+            esp_raise_drq(s);
+            return;
+        }
+        trace_esp_handle_ti_cmd(s->cmdlen);
+        s->ti_size = 0;
+        s->cmdlen = 0;
+        s->do_cmd = 0;
+        do_cmd(s, s->cmdbuf);
         return;
     }
     if (s->async_len == 0) {
+        if (s->dma_left == 0) {
+            esp_dma_done(s);
+        }
         /* Defer until data is available.  */
         return;
     }
@@ -264,9 +406,27 @@ static void esp_do_dma(ESPState *s)
     }
     to_device = (s->ti_size < 0);
     if (to_device) {
-        s->dma_memory_read(s->dma_opaque, s->async_buf, len);
+        if (s->dma_memory_read) {
+            s->dma_memory_read(s->dma_opaque, s->async_buf, len);
+        } else {
+            s->pdma_len = len;
+            s->pdma_start = s->async_buf;
+            s->pdma_cur = s->async_buf;
+            s->pdma_cb = do_dma_pdma_cb;
+            esp_raise_drq(s);
+            return;
+        }
     } else {
-        s->dma_memory_write(s->dma_opaque, s->async_buf, len);
+        if (s->dma_memory_write) {
+            s->dma_memory_write(s->dma_opaque, s->async_buf, len);
+        } else {
+            s->pdma_len = len;
+            s->pdma_start = s->async_buf;
+            s->pdma_cur = s->async_buf;
+            s->pdma_cb = do_dma_pdma_cb;
+            esp_raise_drq(s);
+            return;
+        }
     }
     s->dma_left -= len;
     s->async_buf += len;
@@ -373,8 +533,7 @@ static void handle_ti(ESPState *s)
         s->dma_left = minlen;
         s->rregs[ESP_RSTAT] &= ~STAT_TC;
         esp_do_dma(s);
-    }
-    if (s->do_cmd) {
+    } else if (s->do_cmd) {
         trace_esp_handle_ti_cmd(s->cmdlen);
         s->ti_size = 0;
         s->cmdlen = 0;
@@ -401,6 +560,7 @@ void esp_hard_reset(ESPState *s)
 static void esp_soft_reset(ESPState *s)
 {
     qemu_irq_lower(s->irq);
+    qemu_irq_lower(s->irq_data);
     esp_hard_reset(s);
 }
 
@@ -641,6 +801,80 @@ static const MemoryRegionOps sysbus_esp_mem_ops = {
     .valid.accepts = esp_mem_accepts,
 };
 
+static void sysbus_esp_pdma_write(void *opaque, hwaddr addr,
+                                  uint64_t val, unsigned int size)
+{
+    SysBusESPState *sysbus = opaque;
+    ESPState *s = &sysbus->esp;
+    uint32_t dmalen;
+
+    dmalen = s->rregs[ESP_TCLO];
+    dmalen |= s->rregs[ESP_TCMID] << 8;
+    dmalen |= s->rregs[ESP_TCHI] << 16;
+    if (dmalen == 0 || s->pdma_len == 0) {
+        return;
+    }
+    switch (size) {
+    case 1:
+        *s->pdma_cur++ = val;
+        s->pdma_len--;
+        dmalen--;
+        break;
+    case 2:
+        *s->pdma_cur++ = val >> 8;
+        *s->pdma_cur++ = val;
+        s->pdma_len -= 2;
+        dmalen -= 2;
+        break;
+    }
+    s->rregs[ESP_TCLO] = dmalen & 0xff;
+    s->rregs[ESP_TCMID] = dmalen >> 8;
+    s->rregs[ESP_TCHI] = dmalen >> 16;
+    if (s->pdma_len == 0 && s->pdma_cb) {
+        esp_lower_drq(s);
+        s->pdma_cb(s);
+        s->pdma_cb = NULL;
+    }
+}
+
+static uint64_t sysbus_esp_pdma_read(void *opaque, hwaddr addr,
+                                     unsigned int size)
+{
+    SysBusESPState *sysbus = opaque;
+    ESPState *s = &sysbus->esp;
+    uint64_t val = 0;
+
+    if (s->pdma_len == 0) {
+        return 0;
+    }
+    switch (size) {
+    case 1:
+        val = *s->pdma_cur++;
+        s->pdma_len--;
+        break;
+    case 2:
+        val = *s->pdma_cur++;
+        val = (val << 8) | *s->pdma_cur++;
+        s->pdma_len -= 2;
+        break;
+    }
+
+    if (s->pdma_len == 0 && s->pdma_cb) {
+        esp_lower_drq(s);
+        s->pdma_cb(s);
+        s->pdma_cb = NULL;
+    }
+    return val;
+}
+
+static const MemoryRegionOps sysbus_esp_pdma_ops = {
+    .read = sysbus_esp_pdma_read,
+    .write = sysbus_esp_pdma_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 2,
+};
+
 static const struct SCSIBusInfo esp_scsi_info = {
     .tcq = false,
     .max_target = ESP_MAX_DEVS,
@@ -673,12 +907,16 @@ static void sysbus_esp_realize(DeviceState *dev, Error **errp)
     ESPState *s = &sysbus->esp;
 
     sysbus_init_irq(sbd, &s->irq);
+    sysbus_init_irq(sbd, &s->irq_data);
     assert(sysbus->it_shift != -1);
 
     s->chip_id = TCHI_FAS100A;
     memory_region_init_io(&sysbus->iomem, OBJECT(sysbus), &sysbus_esp_mem_ops,
-                          sysbus, "esp", ESP_REGS << sysbus->it_shift);
+                          sysbus, "esp-regs", ESP_REGS << sysbus->it_shift);
     sysbus_init_mmio(sbd, &sysbus->iomem);
+    memory_region_init_io(&sysbus->pdma, OBJECT(sysbus), &sysbus_esp_pdma_ops,
+                          sysbus, "esp-pdma", 2);
+    sysbus_init_mmio(sbd, &sysbus->pdma);
 
     qdev_init_gpio_in(dev, sysbus_esp_gpio_demux, 2);
 
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index adab63d1c9..b19b86b27a 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -18,6 +18,7 @@ struct ESPState {
     uint8_t rregs[ESP_REGS];
     uint8_t wregs[ESP_REGS];
     qemu_irq irq;
+    qemu_irq irq_data;
     uint8_t chip_id;
     bool tchi_written;
     int32_t ti_size;
@@ -48,6 +49,11 @@ struct ESPState {
     ESPDMAMemoryReadWriteFunc dma_memory_write;
     void *dma_opaque;
     void (*dma_cb)(ESPState *s);
+    uint8_t pdma_buf[32];
+    uint32_t pdma_len;
+    uint8_t *pdma_start;
+    uint8_t *pdma_cur;
+    void (*pdma_cb)(ESPState *s);
 };
 
 #define TYPE_ESP "esp"
@@ -59,6 +65,7 @@ typedef struct {
     /*< public >*/
 
     MemoryRegion iomem;
+    MemoryRegion pdma;
     uint32_t it_shift;
     ESPState esp;
 } SysBusESPState;
-- 
2.21.0


