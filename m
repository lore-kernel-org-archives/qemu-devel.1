Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA30BC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7E72070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8nacF2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7E72070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUC4F-0002lj-L8
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUC03-0004wV-Hh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUBzU-0002My-W1
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:25:23 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:33096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jUBzU-0002MJ-JQ; Thu, 30 Apr 2020 12:24:48 -0400
Received: by mail-lf1-x141.google.com with SMTP id z22so1573187lfd.0;
 Thu, 30 Apr 2020 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y824xx04jqsW2/AQvQDYfFCgSj2PQmEZMtd7inCiHEs=;
 b=Y8nacF2NbJui13SZUwmaH2z/LlT18kYFPRao/B7eU341F8J4ifO9b6su5hr29sMsmc
 dzL8/IIUim7Uu9ovQBazv87xI4abqwCLP/I+kXpJKF4hSDRHON8r44yiZOEs1hj7KWOo
 KhJJlWDpa/wcGs50nJbor2+/o02CsZUGS64FYs6S6a0VfuIrDxg0Poz5kv/AYTcvL5eI
 5aXM/jUuCbFmwmiAg+i3iphhUKdWn3ExjtkoRnQ6lhW417PC/W6efMhHOwQe9nP+fGlO
 GKxNTsBLxBgpsi0WSE2k3pb6X8jcm3tzaUUmETX4O79ACP/gOvda4BL6si7b0W5ww+O2
 URKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y824xx04jqsW2/AQvQDYfFCgSj2PQmEZMtd7inCiHEs=;
 b=UgKCEmghpO3GRQXMs+qeEX7mSAR4S8A0tpq+HzG38aAUpN3vAHj9CHt9/aXUt/3Y8z
 KQRF5uAQ1aW3QiW3X4TT8vPS3BBfhxQzSALGhKxrCxrDcZ5IAAcMKAUw6Z1LQns2ltY6
 nQ4BerB96CCZ4v2LhOAH8H1r+f58iIvJQl29Ge3EYSpWHvvQSyHKmKKgXSWn8im5o88P
 VzWHBjprWFUZ6JUlhCY7jC3KHpI3LMWkvTQSx6EmiwH0i0Q4zfez1d4z4MCevDhkyX8U
 OPHFtUIao6LH61jxRW8s3BDkP57eijltxXYJh9g6dXYBR5Tbf7iehNzeJMhpm2tPp3Wa
 NYNA==
X-Gm-Message-State: AGi0PuacvUHimst93ma5zV0av04BFJ1e4BlWJHFGk+wMwqIkN5WMFQfx
 e/L/wtjz/gbIhkatX+nd+QxujliYKJA=
X-Google-Smtp-Source: APiQypKrd1bRnauUUn4fJwtskihbcfJsmDVGqJrca6466C60k+Z8LojX5Nm7dK0a1JemwlkUiU+c1A==
X-Received: by 2002:ac2:5338:: with SMTP id f24mr2572731lfh.197.1588263886182; 
 Thu, 30 Apr 2020 09:24:46 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id j29sm94633lfp.90.2020.04.30.09.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:24:45 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/9] hw/dma/xilinx_axidma: Add DMA memory-region property
Date: Thu, 30 Apr 2020 18:24:34 +0200
Message-Id: <20200430162439.2659-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162439.2659-1-edgar.iglesias@gmail.com>
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::141
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, jasowang@redhat.com, alistair@alistair23.me,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add DMA memory-region property to externally control what
address-space this DMA operates on.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/dma/xilinx_axidma.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 018f36991b..4540051448 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -33,6 +33,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 
+#include "sysemu/dma.h"
 #include "hw/stream.h"
 
 #define D(x)
@@ -103,6 +104,7 @@ enum {
 };
 
 struct Stream {
+    struct XilinxAXIDMA *dma;
     ptimer_state *ptimer;
     qemu_irq irq;
 
@@ -125,6 +127,9 @@ struct XilinxAXIDMAStreamSlave {
 struct XilinxAXIDMA {
     SysBusDevice busdev;
     MemoryRegion iomem;
+    MemoryRegion *dma_mr;
+    AddressSpace as;
+
     uint32_t freqhz;
     StreamSlave *tx_data_dev;
     StreamSlave *tx_control_dev;
@@ -186,7 +191,7 @@ static void stream_desc_load(struct Stream *s, hwaddr addr)
 {
     struct SDesc *d = &s->desc;
 
-    cpu_physical_memory_read(addr, d, sizeof *d);
+    address_space_read(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED, d, sizeof *d);
 
     /* Convert from LE into host endianness.  */
     d->buffer_address = le64_to_cpu(d->buffer_address);
@@ -204,7 +209,8 @@ static void stream_desc_store(struct Stream *s, hwaddr addr)
     d->nxtdesc = cpu_to_le64(d->nxtdesc);
     d->control = cpu_to_le32(d->control);
     d->status = cpu_to_le32(d->status);
-    cpu_physical_memory_write(addr, d, sizeof *d);
+    address_space_write(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED,
+                        d, sizeof *d);
 }
 
 static void stream_update_irq(struct Stream *s)
@@ -286,8 +292,9 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
                      txlen + s->pos);
         }
 
-        cpu_physical_memory_read(s->desc.buffer_address,
-                                 s->txbuf + s->pos, txlen);
+        address_space_read(&s->dma->as, s->desc.buffer_address,
+                           MEMTXATTRS_UNSPECIFIED,
+                           s->txbuf + s->pos, txlen);
         s->pos += txlen;
 
         if (stream_desc_eof(&s->desc)) {
@@ -336,7 +343,8 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
             rxlen = len;
         }
 
-        cpu_physical_memory_write(s->desc.buffer_address, buf + pos, rxlen);
+        address_space_write(&s->dma->as, s->desc.buffer_address,
+                            MEMTXATTRS_UNSPECIFIED, buf + pos, rxlen);
         len -= rxlen;
         pos += rxlen;
 
@@ -525,6 +533,7 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
     XilinxAXIDMAStreamSlave *cs = XILINX_AXI_DMA_CONTROL_STREAM(
                                                             &s->rx_control_dev);
     Error *local_err = NULL;
+    int i;
 
     object_property_add_link(OBJECT(ds), "dma", TYPE_XILINX_AXI_DMA,
                              (Object **)&ds->dma,
@@ -545,17 +554,19 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
         goto xilinx_axidma_realize_fail;
     }
 
-    int i;
-
     for (i = 0; i < 2; i++) {
         struct Stream *st = &s->streams[i];
 
+        st->dma = s;
         st->nr = i;
         st->ptimer = ptimer_init(timer_hit, st, PTIMER_POLICY_DEFAULT);
         ptimer_transaction_begin(st->ptimer);
         ptimer_set_freq(st->ptimer, s->freqhz);
         ptimer_transaction_commit(st->ptimer);
     }
+
+    address_space_init(&s->as,
+                       s->dma_mr ? s->dma_mr : get_system_memory(), "dma");
     return;
 
 xilinx_axidma_realize_fail:
@@ -575,6 +586,11 @@ static void xilinx_axidma_init(Object *obj)
                             &s->rx_control_dev, sizeof(s->rx_control_dev),
                             TYPE_XILINX_AXI_DMA_CONTROL_STREAM, &error_abort,
                             NULL);
+    object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
+                             (Object **)&s->dma_mr,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG,
+                             &error_abort);
 
     sysbus_init_irq(sbd, &s->streams[0].irq);
     sysbus_init_irq(sbd, &s->streams[1].irq);
-- 
2.20.1


