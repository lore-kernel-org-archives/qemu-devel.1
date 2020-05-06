Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32F2C4724C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D79520714
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpAmciK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D79520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFRK-0004CP-Hk
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWFMp-0004mN-Rk; Wed, 06 May 2020 04:25:23 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:38443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWFMo-0006vq-Sj; Wed, 06 May 2020 04:25:23 -0400
Received: by mail-lf1-x143.google.com with SMTP id b26so590533lfa.5;
 Wed, 06 May 2020 01:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nByvvZG8cHN8R6JUp+jtcQ1PIb+Y7F7It62qQDF6m9g=;
 b=BpAmciK8RrDxPclA8sLCV78c7Y69nswSwBuWGSB298CxyTeI9W1F6siv4G3jn+nyx7
 EiivHyqxrRtLDQmz43DiAN3OOCOSXynMKswQFr5qzVww9h0l73Y9DzD0E/pYGwwhePDW
 OKLF6EayuXKd+lwvTcBxIYmTYRiphsCS6wg2wxE2k1OQPupJaZ/4r5septyu45ZCJxLm
 hWYRROi78iLwZDCCpERdHBvXeJFsRKCOQL2EB6X346K8b9v1Wn4XVc4R8gy2fs+ZIwvW
 XxlW66GVg1pWKQ4r4EsoxDhZ0SfxWqFF15E7NnSZIClFwNvHayRpnpmWs34BRXM2ab7Z
 kOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nByvvZG8cHN8R6JUp+jtcQ1PIb+Y7F7It62qQDF6m9g=;
 b=A6mEmJHVtlpRnaKbMq/wNjLCZTUt/ghSGwvIhPA+oJAv78wv2w4M7ZM4xMX9JC0R+H
 bA2DrkdhXF7K7ZCJle43IR8h9HUVAV/Rew3TWJ7quIbWqvwAEKoReG3diK0iOCrB0zVE
 wlUbfRsfaOlRDrCkYLnzxUDHiHCtKaGPHfjHb41bBDVhvHyU0dYDoklT5nX5a+u9eyDG
 sE9VhtarfR73XttGiToBs/8OWVqC5WdiHpPqrf5rapev4BtnS9tVe1NgySdr4fkp3/vz
 oITBgaA23VHvtXubYseGpDtUXHUufYj0GKfzKTCdMKR3fgOlcemOZCQhwSWGditFe8hV
 xWaw==
X-Gm-Message-State: AGi0PuZlHk6wEkT1x2Ly9mb0JGYgamu8XqZXXm5jlb16s4VqU6fDMbwg
 4uoS5UdsByvnr4DquRp7GSKi4aQDsd4=
X-Google-Smtp-Source: APiQypJ2EdLWR+B0MVolgvw43UJLV5x3urX2JdkaRVjdMLZNro7MloUHNmlUceUu1L0GlHJ+DZS+2g==
X-Received: by 2002:ac2:442f:: with SMTP id w15mr4183731lfl.73.1588753520670; 
 Wed, 06 May 2020 01:25:20 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id o6sm798829lja.70.2020.05.06.01.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 01:25:19 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/9] hw/dma/xilinx_axidma: Add DMA memory-region property
Date: Wed,  6 May 2020 10:25:08 +0200
Message-Id: <20200506082513.18751-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506082513.18751-1-edgar.iglesias@gmail.com>
References: <20200506082513.18751-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.399, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
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


