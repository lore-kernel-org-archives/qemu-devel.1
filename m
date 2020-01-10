Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127FBC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 20:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B842082E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 20:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDYAaFHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B842082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq17F-0003yJ-DS
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 15:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iq14U-0000Yn-FW
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 15:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iq14S-0006zo-8O
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 15:39:54 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iq14O-0006mI-5M; Fri, 10 Jan 2020 15:39:48 -0500
Received: by mail-pf1-x441.google.com with SMTP id i6so1681946pfc.1;
 Fri, 10 Jan 2020 12:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AjYuwcu4CzSnPUYIIJZphHa+VtV0A9D30V28S0+hFPw=;
 b=tDYAaFHo0kdytfDLDLPVCKxCT8oJYGzJMij7oD6x4Ycz0Y7dxn4LhCAibYFr5znXzp
 RubCs/ouy+uCFe9RN9RpfN//Hwp5ItQb6G5ivxcxUkiheur8WeYyavNYH7BAwUi9yYH4
 n6cugmxg7CtI91XhNOM+w443+rDUrD9Srd/sWDwNgH24p6aUHJobB3NTkcZ/eB3sbY8h
 F73JwNifozB8elq0yHE8rtEEaykd/u/ZE5ppNpkOYlnNEH3Z2EzlIuR5Y9MuXUUGSu5B
 K1qn/pz6GFi2kZLnbAitP1hWED5xg+xuRddqgAvFv9d4pH4+BflVcnN4mdaZ0sH+ZfxV
 sLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=AjYuwcu4CzSnPUYIIJZphHa+VtV0A9D30V28S0+hFPw=;
 b=KXsXeyhe+Ncz0/Fa+HpVU3k7/d5DgEQDbQxgdg7iaGg+Wvn/xClnMSVYTEsRFuuum4
 9VtolpNvObYCUPa0MNfH33XPTwnsSxdr2dtjEt/ZkRZd0sWczsJzxOlx9KlbbBNruyYg
 3j6P9wManh7JvkgyV4ZNJB0OEQoCIq3sJ2Jt7IbnUXJIVyLopRghg1rGZ1BeK0nJvS4B
 xh2Q6WXGToYwf7ILY7CYDdaB812N6RVDsuZNpvI4U26qjVrQ3dNDndzH/SGvsVwjLSfE
 +2Le7BEzPc2W+C2k+W1fDHMr/aq8MMH3nBki6orZkfSTTvmPPH1G9k6k9+ieGnPkQnAZ
 Qvjg==
X-Gm-Message-State: APjAAAWjA57fsRhcNKhKyHVR6VymFG52nIiV8aDivaabSQVT3LjmtznW
 yxTaqWVFA70ryGDF2jGrMcQ=
X-Google-Smtp-Source: APXvYqyrHBNHvWxEYFyTdtYoIB2ZPMXJMmScDlY7LKRYjnzhvNkB6T0/6cooAiGQILwzRIXp6Uahdg==
X-Received: by 2002:a63:6787:: with SMTP id b129mr6556573pgc.103.1578688786834; 
 Fri, 10 Jan 2020 12:39:46 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id m6sm3764730pjn.21.2020.01.10.12.39.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 10 Jan 2020 12:39:46 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>
Subject: [PATCH 1/6] dma/pl330: Convert to support tracing
Date: Fri, 10 Jan 2020 12:39:37 -0800
Message-Id: <20200110203942.5745-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110203942.5745-1-linux@roeck-us.net>
References: <20200110203942.5745-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace debug logging code with tracing.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/dma/pl330.c      | 88 +++++++++++++++++++++++----------------------
 hw/dma/trace-events | 24 +++++++++++++
 2 files changed, 70 insertions(+), 42 deletions(-)

diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index f2bb2d9ac1..c64cc4e67a 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -25,19 +25,12 @@
 #include "sysemu/dma.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "trace.h"
 
 #ifndef PL330_ERR_DEBUG
 #define PL330_ERR_DEBUG 0
 #endif
 
-#define DB_PRINT_L(lvl, fmt, args...) do {\
-    if (PL330_ERR_DEBUG >= lvl) {\
-        fprintf(stderr, "PL330: %s:" fmt, __func__, ## args);\
-    } \
-} while (0)
-
-#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
-
 #define PL330_PERIPH_NUM            32
 #define PL330_MAX_BURST_LEN         128
 #define PL330_INSN_MAXSIZE          6
@@ -319,6 +312,26 @@ typedef struct PL330InsnDesc {
     void (*exec)(PL330Chan *, uint8_t opcode, uint8_t *args, int len);
 } PL330InsnDesc;
 
+static void pl330_hexdump(uint8_t *buf, size_t size)
+{
+    unsigned int b, i, len;
+    char tmpbuf[80];
+
+    for (b = 0; b < size; b += 16) {
+        len = size - b;
+        if (len > 16) {
+            len = 16;
+        }
+        tmpbuf[0] = '\0';
+        for (i = 0; i < len; i++) {
+            if ((i % 4) == 0) {
+                strcat(tmpbuf, " ");
+            }
+            sprintf(tmpbuf + strlen(tmpbuf), " %02x", buf[b + i]);
+        }
+        trace_pl330_hexdump(b, tmpbuf);
+    }
+}
 
 /* MFIFO Implementation
  *
@@ -582,7 +595,7 @@ static inline void pl330_queue_remove_tagged(PL330Queue *s, uint8_t tag)
 
 static inline void pl330_fault(PL330Chan *ch, uint32_t flags)
 {
-    DB_PRINT("ch: %p, flags: %" PRIx32 "\n", ch, flags);
+    trace_pl330_fault(ch, flags);
     ch->fault_type |= flags;
     if (ch->state == pl330_chan_fault) {
         return;
@@ -590,7 +603,7 @@ static inline void pl330_fault(PL330Chan *ch, uint32_t flags)
     ch->state = pl330_chan_fault;
     ch->parent->num_faulting++;
     if (ch->parent->num_faulting == 1) {
-        DB_PRINT("abort interrupt raised\n");
+        trace_pl330_fault_abort();
         qemu_irq_raise(ch->parent->irq_abort);
     }
 }
@@ -648,7 +661,7 @@ static void pl330_dmaend(PL330Chan *ch, uint8_t opcode,
             return;
         }
     }
-    DB_PRINT("DMA ending!\n");
+    trace_pl330_dmaend();
     pl330_fifo_tagged_remove(&s->fifo, ch->tag);
     pl330_queue_remove_tagged(&s->read_queue, ch->tag);
     pl330_queue_remove_tagged(&s->write_queue, ch->tag);
@@ -683,7 +696,7 @@ static void pl330_dmago(PL330Chan *ch, uint8_t opcode, uint8_t *args, int len)
     uint32_t pc;
     PL330Chan *s;
 
-    DB_PRINT("\n");
+    trace_pl330_dmago();
 
     if (!ch->is_manager) {
         pl330_fault(ch, PL330_FAULT_UNDEF_INSTR);
@@ -740,9 +753,7 @@ static void pl330_dmald(PL330Chan *ch, uint8_t opcode, uint8_t *args, int len)
     ch->stall = pl330_queue_put_insn(&ch->parent->read_queue, ch->src,
                                     size, num, inc, 0, ch->tag);
     if (!ch->stall) {
-        DB_PRINT("channel:%" PRId8 " address:%08" PRIx32 " size:%" PRIx32
-                 " num:%" PRId32 " %c\n",
-                 ch->tag, ch->src, size, num, inc ? 'Y' : 'N');
+        trace_pl330_dmald(ch->tag, ch->src, size, num, inc ? 'Y' : 'N');
         ch->src += inc ? size * num - (ch->src & (size - 1)) : 0;
     }
 }
@@ -782,7 +793,7 @@ static void pl330_dmakill(PL330Chan *ch, uint8_t opcode, uint8_t *args, int len)
         ch->fault_type = 0;
         ch->parent->num_faulting--;
         if (ch->parent->num_faulting == 0) {
-            DB_PRINT("abort interrupt lowered\n");
+            trace_pl330_dmakill();
             qemu_irq_lower(ch->parent->irq_abort);
         }
     }
@@ -800,6 +811,8 @@ static void pl330_dmalpend(PL330Chan *ch, uint8_t opcode,
     uint8_t bs = opcode & 3;
     uint8_t lc = (opcode & 4) >> 2;
 
+    trace_pl330_dmalpend(nf, bs, lc, ch->lc[lc], ch->request_flag);
+
     if (bs == 2) {
         pl330_fault(ch, PL330_FAULT_OPERAND_INVALID);
         return;
@@ -813,12 +826,12 @@ static void pl330_dmalpend(PL330Chan *ch, uint8_t opcode,
         if (nf) {
             ch->lc[lc]--;
         }
-        DB_PRINT("loop reiteration\n");
+        trace_pl330_dmalpiter();
         ch->pc -= args[0];
         ch->pc -= len + 1;
         /* "ch->pc -= args[0] + len + 1" is incorrect when args[0] == 256 */
     } else {
-        DB_PRINT("loop fallthrough\n");
+        trace_pl330_dmalpfallthrough();
     }
 }
 
@@ -886,10 +899,10 @@ static void pl330_dmasev(PL330Chan *ch, uint8_t opcode, uint8_t *args, int len)
     }
     if (ch->parent->inten & (1 << ev_id)) {
         ch->parent->int_status |= (1 << ev_id);
-        DB_PRINT("event interrupt raised %" PRId8 "\n", ev_id);
+        trace_pl330_dmasev_evirq(ev_id);
         qemu_irq_raise(ch->parent->irq[ev_id]);
     }
-    DB_PRINT("event raised %" PRId8 "\n", ev_id);
+    trace_pl330_dmasev_event(ev_id);
     ch->parent->ev_status |= (1 << ev_id);
 }
 
@@ -914,9 +927,7 @@ static void pl330_dmast(PL330Chan *ch, uint8_t opcode, uint8_t *args, int len)
     ch->stall = pl330_queue_put_insn(&ch->parent->write_queue, ch->dst,
                                     size, num, inc, 0, ch->tag);
     if (!ch->stall) {
-        DB_PRINT("channel:%" PRId8 " address:%08" PRIx32 " size:%" PRIx32
-                 " num:%" PRId32 " %c\n",
-                 ch->tag, ch->dst, size, num, inc ? 'Y' : 'N');
+        trace_pl330_dmast(ch->tag, ch->dst, size, num, inc ? 'Y' : 'N');
         ch->dst += inc ? size * num - (ch->dst & (size - 1)) : 0;
     }
 }
@@ -992,7 +1003,7 @@ static void pl330_dmawfe(PL330Chan *ch, uint8_t opcode,
             }
         }
         ch->parent->ev_status &= ~(1 << ev_id);
-        DB_PRINT("event lowered %" PRIx8 "\n", ev_id);
+        trace_pl330_dmawfe(ev_id);
     } else {
         ch->stall = 1;
     }
@@ -1135,7 +1146,7 @@ static int pl330_chan_exec(PL330Chan *ch)
     ch->stall = 0;
     insn = pl330_fetch_insn(ch);
     if (!insn) {
-        DB_PRINT("pl330 undefined instruction\n");
+        trace_pl330_chan_exec_undef();
         pl330_fault(ch, PL330_FAULT_UNDEF_INSTR);
         return 0;
     }
@@ -1175,11 +1186,8 @@ static int pl330_exec_cycle(PL330Chan *channel)
         int len = q->len - (q->addr & (q->len - 1));
 
         dma_memory_read(&address_space_memory, q->addr, buf, len);
-        if (PL330_ERR_DEBUG > 1) {
-            DB_PRINT("PL330 read from memory @%08" PRIx32 " (size = %08x):\n",
-                      q->addr, len);
-            qemu_hexdump((char *)buf, stderr, "", len);
-        }
+        trace_pl330_exec_cycle(q->addr, len);
+        pl330_hexdump(buf, len);
         fifo_res = pl330_fifo_push(&s->fifo, buf, len, q->tag);
         if (fifo_res == PL330_FIFO_OK) {
             if (q->inc) {
@@ -1207,11 +1215,8 @@ static int pl330_exec_cycle(PL330Chan *channel)
         }
         if (fifo_res == PL330_FIFO_OK || q->z) {
             dma_memory_write(&address_space_memory, q->addr, buf, len);
-            if (PL330_ERR_DEBUG > 1) {
-                DB_PRINT("PL330 read from memory @%08" PRIx32
-                         " (size = %08x):\n", q->addr, len);
-                qemu_hexdump((char *)buf, stderr, "", len);
-            }
+            trace_pl330_exec_cycle(q->addr, len);
+            pl330_hexdump(buf, len);
             if (q->inc) {
                 q->addr += len;
             }
@@ -1252,8 +1257,8 @@ static int pl330_exec_channel(PL330Chan *channel)
 
 static inline void pl330_exec(PL330State *s)
 {
-    DB_PRINT("\n");
     int i, insr_exec;
+    trace_pl330_exec();
     do {
         insr_exec = pl330_exec_channel(&s->manager);
 
@@ -1298,7 +1303,7 @@ static void pl330_debug_exec(PL330State *s)
     args[2] = (s->dbg[1] >>  8) & 0xff;
     args[3] = (s->dbg[1] >> 16) & 0xff;
     args[4] = (s->dbg[1] >> 24) & 0xff;
-    DB_PRINT("chan id: %" PRIx8 "\n", chan_id);
+    trace_pl330_debug_exec(chan_id);
     if (s->dbg[0] & 1) {
         ch = &s->chan[chan_id];
     } else {
@@ -1320,6 +1325,7 @@ static void pl330_debug_exec(PL330State *s)
         ch->fault_type |= PL330_FAULT_DBG_INSTR;
     }
     if (ch->stall) {
+        trace_pl330_debug_exec_stall();
         qemu_log_mask(LOG_UNIMP, "pl330: stall of debug instruction not "
                       "implemented\n");
     }
@@ -1334,7 +1340,7 @@ static void pl330_iomem_write(void *opaque, hwaddr offset,
     PL330State *s = (PL330State *) opaque;
     int i;
 
-    DB_PRINT("addr: %08x data: %08x\n", (unsigned)offset, (unsigned)value);
+    trace_pl330_iomem_write((unsigned)offset, (unsigned)value);
 
     switch (offset) {
     case PL330_REG_INTEN:
@@ -1343,7 +1349,7 @@ static void pl330_iomem_write(void *opaque, hwaddr offset,
     case PL330_REG_INTCLR:
         for (i = 0; i < s->num_events; i++) {
             if (s->int_status & s->inten & value & (1 << i)) {
-                DB_PRINT("event interrupt lowered %d\n", i);
+                trace_pl330_iomem_write_clr(i);
                 qemu_irq_lower(s->irq[i]);
             }
         }
@@ -1361,11 +1367,9 @@ static void pl330_iomem_write(void *opaque, hwaddr offset,
         }
         break;
     case PL330_REG_DBGINST0:
-        DB_PRINT("s->dbg[0] = %08x\n", (unsigned)value);
         s->dbg[0] = value;
         break;
     case PL330_REG_DBGINST1:
-        DB_PRINT("s->dbg[1] = %08x\n", (unsigned)value);
         s->dbg[1] = value;
         break;
     default:
@@ -1489,7 +1493,7 @@ static uint64_t pl330_iomem_read(void *opaque, hwaddr offset,
         unsigned size)
 {
     uint32_t ret = pl330_iomem_read_imp(opaque, offset);
-    DB_PRINT("addr: %08" HWADDR_PRIx " data: %08" PRIx32 "\n", offset, ret);
+    trace_pl330_iomem_read((uint32_t)offset, ret);
     return ret;
 }
 
diff --git a/hw/dma/trace-events b/hw/dma/trace-events
index e4498428c5..5902ac5969 100644
--- a/hw/dma/trace-events
+++ b/hw/dma/trace-events
@@ -20,3 +20,27 @@ sparc32_dma_enable_lower(void) "Lower DMA enable"
 
 # i8257.c
 i8257_unregistered_dma(int nchan, int dma_pos, int dma_len) "unregistered DMA channel used nchan=%d dma_pos=%d dma_len=%d"
+
+# pl330.c
+pl330_fault(void *ptr, uint32_t flags) "ch: %p, flags: 0x%"PRIx32
+pl330_fault_abort(void) "abort interrupt raised"
+pl330_dmaend(void) "DMA ending"
+pl330_dmago(void) "DMA run"
+pl330_dmald(uint32_t chan, uint32_t addr, uint32_t size, uint32_t num, uint32_t ch) "channel:%"PRId8" address:0x%08"PRIx32" size:0x%"PRIx32" num:%"PRId32"%c"
+pl330_dmakill(void) "abort interrupt lowered"
+pl330_dmalpend(uint8_t nf, uint8_t bs, uint8_t lc, uint8_t ch, uint8_t flag) "nf=0x%02x bs=0x%02x lc=0x%02x ch=0x%02x flag=0x%02x"
+pl330_dmalpiter(void) "loop reiteration"
+pl330_dmalpfallthrough(void) "loop fallthrough"
+pl330_dmasev_evirq(uint8_t ev_id) "event interrupt raised %"PRId8
+pl330_dmasev_event(uint8_t ev_id) "event raised %"PRId8
+pl330_dmast(uint32_t chn, uint32_t addr, uint32_t sz, uint32_t num, uint32_t c) "channel:%"PRId8" address:0x%08"PRIx32" size:0x%"PRIx32" num:%"PRId32" %c"
+pl330_dmawfe(uint8_t ev_id) "event lowered 0x%"PRIx8
+pl330_chan_exec_undef(void) "undefined instruction"
+pl330_exec_cycle(uint32_t addr, uint32_t size) "PL330 read from memory @0x%08"PRIx32" (size = 0x%08"PRIx32")"
+pl330_hexdump(uint32_t offset, char *str) " 0x%04"PRIx32":%s"
+pl330_exec(void) "pl330_exec"
+pl330_debug_exec(uint8_t ch) "chan id: 0x%"PRIx8
+pl330_debug_exec_stall(void) "stall of debug instruction not implemented"
+pl330_iomem_write(uint32_t offset, uint32_t value) "addr: 0x%08"PRIx32" data: 0x%08"PRIx32
+pl330_iomem_write_clr(int i) "event interrupt lowered %d"
+pl330_iomem_read(uint32_t addr, uint32_t data) "addr: 0x%08"PRIx32" data: 0x%08"PRIx32
-- 
2.17.1


