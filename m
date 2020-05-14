Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F758C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9FDD20671
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ibe5ZPsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FDD20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEfu-00046r-RI
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcr-0007Zt-CI
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:17 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:46862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcq-0003mr-NB
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:17 -0400
Received: by mail-lf1-x144.google.com with SMTP id v5so2724845lfp.13
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D7sjpbEKoLtEYjs/TnSi3AkdRZRMvGw4zpygQ0M/4uc=;
 b=Ibe5ZPsODULQP0cOJOLydJd1oWTboFQ6CUtEokDDzAbTow+co1I3kuwGZwwTp+4HR+
 mhPCmzU2NgdNMTnifxF2YkFu+AeqmPLKuznthGr0nXILySb4jLoCG8n1umutjg4nVImk
 mMhG2C9PyBPpoL6CDapFxF/hOnw6lu/LGLnKAlgE2+sqwKnnxddCe9dFYV8DuwRTUL+8
 pbHK4n0ffNTNrUpx/oXl2NlS5SAVWt+UAWlXX1J/KLEbBgyomm78QPj9haKFQ4odzQ/G
 8NOp3r2/eNmUmQ/NRDPqBfnO5sjZvFn7Pgjr9kNw3DT/pYx5zCgEtOGdnPk61nGAiuOL
 2HnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D7sjpbEKoLtEYjs/TnSi3AkdRZRMvGw4zpygQ0M/4uc=;
 b=I63PqZULcQYynYm/onzBKnkGdWjMOXDsLXD79D8xexdREyDD2ZW8PLh2gfjcYnvBAx
 L7BNdpAA6bKU3vPQg8qI6OTLeTXPPYGoJgEQd5tZnjwK9xr44Bn72Nyam7dG5xemHKCK
 r4AhJazwyKXlYZ+EMJxHu0iXmtIbDKEhxYEOUUiS/LJOnI1cYcNS4jaseygP5UUIEbUg
 xalbvLHiPysteMvZE6AgJerjjorRbKBLRwNoWdYx93mYRitQx3qFpTFwIqoMTr5hlPFY
 KO927E/T35frUopJW83ICTGDIp2lHSa5DSHiQ3kuiArqXammnw4IZ6K2wdE65qh17ZaT
 wXLg==
X-Gm-Message-State: AOAM531LMNIwB0eyEwURPrfxSSm7Fpok/xblbkyOKQrfRc2u6AbIyB3R
 wdk1beunp2UiK/G2vF0pMMU8tiZi/J4=
X-Google-Smtp-Source: ABdhPJzm0R9iSevxSuM0/0Yl7LeyFkf7UXkmYgLLee1tR6VlQCkDrI2Pem3eQDaXzKQ03+e/bUgODQ==
X-Received: by 2002:ac2:414c:: with SMTP id c12mr3402243lfi.47.1589465654753; 
 Thu, 14 May 2020 07:14:14 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id r23sm1520524lji.32.2020.05.14.07.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:14:14 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 08/14] hw/dma/xilinx_axidma: s2mm: Support stream fragments
Date: Thu, 14 May 2020 16:13:56 +0200
Message-Id: <20200514141402.12498-9-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514141402.12498-1-edgar.iglesias@gmail.com>
References: <20200514141402.12498-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x144.google.com
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add support for stream fragments.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-Id: <20200506082513.18751-9-edgar.iglesias@gmail.com>
---
 hw/dma/xilinx_axidma.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 101d32a965..87be9cade7 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -110,6 +110,7 @@ struct Stream {
 
     int nr;
 
+    bool sof;
     struct SDesc desc;
     unsigned int complete_cnt;
     uint32_t regs[R_MAX];
@@ -174,6 +175,7 @@ static void stream_reset(struct Stream *s)
 {
     s->regs[R_DMASR] = DMASR_HALTED;  /* starts up halted.  */
     s->regs[R_DMACR] = 1 << 16; /* Starts with one in compl threshold.  */
+    s->sof = true;
 }
 
 /* Map an offset addr into a channel index.  */
@@ -321,12 +323,11 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
 }
 
 static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
-                                   size_t len)
+                                   size_t len, bool eop)
 {
     uint32_t prev_d;
     unsigned int rxlen;
     size_t pos = 0;
-    int sof = 1;
 
     if (!stream_running(s) || stream_idle(s)) {
         return 0;
@@ -352,16 +353,16 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
         pos += rxlen;
 
         /* Update the descriptor.  */
-        if (!len) {
+        if (eop) {
             stream_complete(s);
             memcpy(s->desc.app, s->app, sizeof(s->desc.app));
             s->desc.status |= SDESC_STATUS_EOF;
         }
 
-        s->desc.status |= sof << SDESC_STATUS_SOF_BIT;
+        s->desc.status |= s->sof << SDESC_STATUS_SOF_BIT;
         s->desc.status |= SDESC_STATUS_COMPLETE;
         stream_desc_store(s, s->regs[R_CURDESC]);
-        sof = 0;
+        s->sof = eop;
 
         /* Advance.  */
         prev_d = s->regs[R_CURDESC];
@@ -426,8 +427,7 @@ xilinx_axidma_data_stream_push(StreamSlave *obj, unsigned char *buf, size_t len,
     struct Stream *s = &ds->dma->streams[1];
     size_t ret;
 
-    assert(eop);
-    ret = stream_process_s2mem(s, buf, len);
+    ret = stream_process_s2mem(s, buf, len, eop);
     stream_update_irq(s);
     return ret;
 }
-- 
2.20.1


