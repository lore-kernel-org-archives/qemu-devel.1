Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E2DCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 19:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CD020873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 19:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CD020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPAfS-0002We-Iz
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 15:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iP9Zj-0002a8-6k
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iP9Zg-0003xJ-Mg
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:17:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:59775)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iP9Zg-0003wr-CI; Mon, 28 Oct 2019 14:17:04 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MrxfX-1hbTLk22Nh-00nwVm; Mon, 28 Oct 2019 19:16:53 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/11] esp: add pseudo-DMA as used by Macintosh
Date: Mon, 28 Oct 2019 19:16:35 +0100
Message-Id: <20191028181643.5143-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028181643.5143-1-laurent@vivier.eu>
References: <20191028181643.5143-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AFOtUh6PpkpWFbg8mN1uNFzv/C1O9bAc9E5FGVIdwZXRe+g3Gom
 iLnTOiR3aFarDOkWbjI6Ure835PEVSNOb3jCxuxHs/qJthYvpEUhGhdIeRo6W+K2bmq7B+J
 M6ZVCkdf191fU7jr5jZb1qrI5SUxXki8CyifzERXGT3dhMHgI4IBtDWuHcFdhPFeFNi17Lc
 Gr+5hZOtEPxixn7YKBkfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CugUPy9Zr+Q=:MWOnvLISG49V0AeS4axXSL
 mpgc+rCcW1PpWM6y8iTsh96f07/nLpiGgKxBell7a42DLjVbHjv35JDCczIde/ZenfBWUdvSt
 JK7UXM68+d9O4qPHFUyyyB9Od1d2KgBxMOP0zG8VhUOrbBBUl049RP58B5C4CwLIaZx+Rt64i
 Xw29bp85Bf/7lsWNUUGDfsCm/pz+lETihvLIUdmOKVU1hx9yi5jC2volM6ZzMmdHbNzYktvf6
 lHTpCMxCXam2hFzVvxkkuwGSfkgFkqOLS48XWD0fhB6EOBh3JWAZAK3XVMKW6vYPXLriHqoWF
 l4nhKYGG1iUVv1Wc1FZxluyyaD3AKFm5x8Aje1MBW8TwuIUOhLeYuRzJh7uiQ36hnKak07FGu
 MIrobLgIo2YLWuX9VR8DXjXLEtSrlhjMFl2z4wD+xOWjAmoJAo6EgK562V9QffI5AzUiiRPDU
 ClF7pi5SVkw+3p63DRV0oAN49O3nWJZizfuslaxUzmUJhTIulRa17I/Bfo/YyRQVT0k9xeKaV
 ZHxIb6w1w6mYjqVqgDCsr4FpLGBspD4dM0z82zexpoHve8+vnBClG9WUIzXJ3d433Wcd5cwY0
 oewM7oDH2Ll4jSDimlkI15m+JnFte6Fiuq0CBkS6nsYkJtiKXGX7y21AuJaLq9zjM6SKSLEdE
 uclS2ffurxt4DNAtt5nr0GCFKF3I99su3rbQ8lb/LuF0LPeVo0SwWPjZ8heb88pNc1PqOVL0e
 X390cXQF1fYQAwsmwukS+woI5BHc0nN1jpuwGEk8fV00uOcVnxf0QN7kixtpp6nEwzdIFYmIZ
 nwUmBK648JHzYdDO9W+bfiRkZs8sozSk/MqjaKIjLMbCaG8MQ7l7J+tbiM5ZCjlW6FJg+y0Yn
 I48M8SAQjN9FmxpFlJuA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.13
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
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
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

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20191026164546.30020-4-laurent@vivier.eu>
---
 include/hw/scsi/esp.h |  15 +++
 hw/scsi/esp.c         | 278 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 284 insertions(+), 9 deletions(-)

diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index adab63d1c9..6ba47dac41 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -14,10 +14,18 @@ typedef void (*ESPDMAMemoryReadWriteFunc)(void *opaque, uint8_t *buf, int len);
 
 typedef struct ESPState ESPState;
 
+enum pdma_origin_id {
+    PDMA,
+    TI,
+    CMD,
+    ASYNC,
+};
+
 struct ESPState {
     uint8_t rregs[ESP_REGS];
     uint8_t wregs[ESP_REGS];
     qemu_irq irq;
+    qemu_irq irq_data;
     uint8_t chip_id;
     bool tchi_written;
     int32_t ti_size;
@@ -48,6 +56,12 @@ struct ESPState {
     ESPDMAMemoryReadWriteFunc dma_memory_write;
     void *dma_opaque;
     void (*dma_cb)(ESPState *s);
+    uint8_t pdma_buf[32];
+    int pdma_origin;
+    uint32_t pdma_len;
+    uint32_t pdma_start;
+    uint32_t pdma_cur;
+    void (*pdma_cb)(ESPState *s);
 };
 
 #define TYPE_ESP "esp"
@@ -59,6 +73,7 @@ typedef struct {
     /*< public >*/
 
     MemoryRegion iomem;
+    MemoryRegion pdma;
     uint32_t it_shift;
     ESPState esp;
 } SysBusESPState;
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 0230ede21d..f8fc30cccb 100644
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
@@ -84,6 +96,30 @@ void esp_request_cancelled(SCSIRequest *req)
     }
 }
 
+static void set_pdma(ESPState *s, enum pdma_origin_id origin,
+                     uint32_t index, uint32_t len)
+{
+    s->pdma_origin = origin;
+    s->pdma_start = index;
+    s->pdma_cur = index;
+    s->pdma_len = len;
+}
+
+static uint8_t *get_pdma_buf(ESPState *s)
+{
+    switch (s->pdma_origin) {
+    case PDMA:
+        return s->pdma_buf;
+    case TI:
+        return s->ti_buf;
+    case CMD:
+        return s->cmdbuf;
+    case ASYNC:
+        return s->async_buf;
+    }
+    return NULL;
+}
+
 static int get_cmd_cb(ESPState *s)
 {
     int target;
@@ -125,7 +161,14 @@ static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
         if (dmalen > buflen) {
             return 0;
         }
-        s->dma_memory_read(s->dma_opaque, buf, dmalen);
+        if (s->dma_memory_read) {
+            s->dma_memory_read(s->dma_opaque, buf, dmalen);
+        } else {
+            memcpy(s->pdma_buf, buf, dmalen);
+            set_pdma(s, PDMA, 0, dmalen);
+            esp_raise_drq(s);
+            return 0;
+        }
     } else {
         dmalen = s->ti_size;
         if (dmalen > TI_BUFSZ) {
@@ -177,6 +220,16 @@ static void do_cmd(ESPState *s, uint8_t *buf)
     do_busid_cmd(s, &buf[1], busid);
 }
 
+static void satn_pdma_cb(ESPState *s)
+{
+    if (get_cmd_cb(s) < 0) {
+        return;
+    }
+    if (s->pdma_cur != s->pdma_start) {
+        do_cmd(s, get_pdma_buf(s) + s->pdma_start);
+    }
+}
+
 static void handle_satn(ESPState *s)
 {
     uint8_t buf[32];
@@ -186,11 +239,22 @@ static void handle_satn(ESPState *s)
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
+        do_busid_cmd(s, get_pdma_buf(s) + s->pdma_start, 0);
+    }
+}
+
 static void handle_s_without_atn(ESPState *s)
 {
     uint8_t buf[32];
@@ -200,18 +264,36 @@ static void handle_s_without_atn(ESPState *s)
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
@@ -223,16 +305,31 @@ static void handle_satn_stop(ESPState *s)
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
+            set_pdma(s, TI, 0, 2);
+            s->pdma_cb = write_response_pdma_cb;
+            esp_raise_drq(s);
+            return;
+        }
     } else {
         s->ti_size = 2;
         s->ti_rptr = 0;
@@ -254,6 +351,41 @@ static void esp_dma_done(ESPState *s)
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
@@ -268,7 +400,14 @@ static void esp_do_dma(ESPState *s)
         trace_esp_do_dma(s->cmdlen, len);
         assert (s->cmdlen <= sizeof(s->cmdbuf) &&
                 len <= sizeof(s->cmdbuf) - s->cmdlen);
-        s->dma_memory_read(s->dma_opaque, &s->cmdbuf[s->cmdlen], len);
+        if (s->dma_memory_read) {
+            s->dma_memory_read(s->dma_opaque, &s->cmdbuf[s->cmdlen], len);
+        } else {
+            set_pdma(s, CMD, s->cmdlen, len);
+            s->pdma_cb = do_dma_pdma_cb;
+            esp_raise_drq(s);
+            return;
+        }
         trace_esp_handle_ti_cmd(s->cmdlen);
         s->ti_size = 0;
         s->cmdlen = 0;
@@ -285,9 +424,23 @@ static void esp_do_dma(ESPState *s)
     }
     to_device = (s->ti_size < 0);
     if (to_device) {
-        s->dma_memory_read(s->dma_opaque, s->async_buf, len);
+        if (s->dma_memory_read) {
+            s->dma_memory_read(s->dma_opaque, s->async_buf, len);
+        } else {
+            set_pdma(s, ASYNC, 0, len);
+            s->pdma_cb = do_dma_pdma_cb;
+            esp_raise_drq(s);
+            return;
+        }
     } else {
-        s->dma_memory_write(s->dma_opaque, s->async_buf, len);
+        if (s->dma_memory_write) {
+            s->dma_memory_write(s->dma_opaque, s->async_buf, len);
+        } else {
+            set_pdma(s, ASYNC, 0, len);
+            s->pdma_cb = do_dma_pdma_cb;
+            esp_raise_drq(s);
+            return;
+        }
     }
     s->dma_left -= len;
     s->async_buf += len;
@@ -421,6 +574,7 @@ void esp_hard_reset(ESPState *s)
 static void esp_soft_reset(ESPState *s)
 {
     qemu_irq_lower(s->irq);
+    qemu_irq_lower(s->irq_data);
     esp_hard_reset(s);
 }
 
@@ -610,6 +764,28 @@ static bool esp_mem_accepts(void *opaque, hwaddr addr,
     return (size == 1) || (is_write && size == 4);
 }
 
+static bool esp_pdma_needed(void *opaque)
+{
+    ESPState *s = opaque;
+    return s->dma_memory_read == NULL && s->dma_memory_write == NULL &&
+           s->dma_enabled;
+}
+
+static const VMStateDescription vmstate_esp_pdma = {
+    .name = "esp/pdma",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = esp_pdma_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_BUFFER(pdma_buf, ESPState),
+        VMSTATE_INT32(pdma_origin, ESPState),
+        VMSTATE_UINT32(pdma_len, ESPState),
+        VMSTATE_UINT32(pdma_start, ESPState),
+        VMSTATE_UINT32(pdma_cur, ESPState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_esp = {
     .name ="esp",
     .version_id = 4,
@@ -631,6 +807,10 @@ const VMStateDescription vmstate_esp = {
         VMSTATE_UINT32(do_cmd, ESPState),
         VMSTATE_UINT32(dma_left, ESPState),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_esp_pdma,
+        NULL
     }
 };
 
@@ -661,6 +841,82 @@ static const MemoryRegionOps sysbus_esp_mem_ops = {
     .valid.accepts = esp_mem_accepts,
 };
 
+static void sysbus_esp_pdma_write(void *opaque, hwaddr addr,
+                                  uint64_t val, unsigned int size)
+{
+    SysBusESPState *sysbus = opaque;
+    ESPState *s = &sysbus->esp;
+    uint32_t dmalen;
+    uint8_t *buf = get_pdma_buf(s);
+
+    dmalen = s->rregs[ESP_TCLO];
+    dmalen |= s->rregs[ESP_TCMID] << 8;
+    dmalen |= s->rregs[ESP_TCHI] << 16;
+    if (dmalen == 0 || s->pdma_len == 0) {
+        return;
+    }
+    switch (size) {
+    case 1:
+        buf[s->pdma_cur++] = val;
+        s->pdma_len--;
+        dmalen--;
+        break;
+    case 2:
+        buf[s->pdma_cur++] = val >> 8;
+        buf[s->pdma_cur++] = val;
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
+    uint8_t *buf = get_pdma_buf(s);
+    uint64_t val = 0;
+
+    if (s->pdma_len == 0) {
+        return 0;
+    }
+    switch (size) {
+    case 1:
+        val = buf[s->pdma_cur++];
+        s->pdma_len--;
+        break;
+    case 2:
+        val = buf[s->pdma_cur++];
+        val = (val << 8) | buf[s->pdma_cur++];
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
@@ -693,12 +949,16 @@ static void sysbus_esp_realize(DeviceState *dev, Error **errp)
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
 
-- 
2.21.0


