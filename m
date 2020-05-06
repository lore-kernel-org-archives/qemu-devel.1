Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817C9C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D8920714
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSjuDweL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D8920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFVT-0008Cs-D4
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWFMt-0004xg-OK; Wed, 06 May 2020 04:25:27 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:46348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWFMs-0006zU-Si; Wed, 06 May 2020 04:25:27 -0400
Received: by mail-lj1-x241.google.com with SMTP id f18so1362634lja.13;
 Wed, 06 May 2020 01:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QKPD+PEm9dvoXTAm72d6swQ9QwndyPxLhyXD0xSWwbg=;
 b=MSjuDweLIhM5o8WcrJ6XyXS9mxGvEHkfebLQ9Jzh6hWsuRx7AqTtRVKxW/RdpfzuDS
 ZiFg+JgnUvY2ulUcjXmOf/XnaKdWGxzszabr2nEPVdGOa+IfpI0b6xJd15W1lgsekCUZ
 4ObwtZ3eEX4uJROWYeI2w6+GgVSTxAoxa5ycnXKpkRkY1wdia52UQLjMB/n2wln7L+XM
 KHPbD98h1BFOE60ypeb6MGShm1PQsw2miUTEAiXsdeuQNJwfUyZAs5d/qquXa6mJkfwV
 UPgNuvPN511X5JuoIVedMXTf/gExWAfBPxaXCf6TVVEM72nS4py1GeBw1II4DKkTc6PL
 pjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QKPD+PEm9dvoXTAm72d6swQ9QwndyPxLhyXD0xSWwbg=;
 b=Txxw0sEHiFI8EuZPpezPRnqr/Z8kUDy/YdQNxixlIkbfss32pR4PcSn8vvZ6ShC9S5
 IdEPC/kcDQcmT5M2RQ2oAQdfO/dUB7qdWq/eQLjcqMIkK5CRMx8E+jt9wI04NLzBoBZD
 dj6ytqovmsCRLR5WFpedXlMwE09WvMFRYeUR25SvvZkjrzcWW2D/XRnoycvAYlpcgTlx
 JykuFZ43iESglU1jEDQRC3BagK76jLtF3W+fKb3DwG9jnjImXXevE4jy2SKztbhW+JSi
 7KG+kR+vuEQBeMqZC8ByWtNZYfAmFHZ8bwRW+qwnT/TT1T3AXrtJTn/4sAlhivd1C7DR
 Jpcw==
X-Gm-Message-State: AGi0PuYsTnvBm7qoXwKF5ZjjY0pFA9v/UAAaa7V6c+7X40GZAUxqbUrS
 Bo1vPfVDE8dgPE20kN2Tw728q94VV+g=
X-Google-Smtp-Source: APiQypIdGiNh7nvmC/yDz8zf9YCSdeSefLFqNzEwREEqCuqQHzrTz2IWjxY8rcGebHJUauZgN7TOPw==
X-Received: by 2002:a2e:8807:: with SMTP id x7mr4267786ljh.173.1588753524603; 
 Wed, 06 May 2020 01:25:24 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id f5sm1025097lfh.84.2020.05.06.01.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 01:25:23 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/9] hw/dma/xilinx_axidma: mm2s: Stream descriptor by
 descriptor
Date: Wed,  6 May 2020 10:25:11 +0200
Message-Id: <20200506082513.18751-8-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506082513.18751-1-edgar.iglesias@gmail.com>
References: <20200506082513.18751-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
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

Stream descriptor by descriptor from memory instead of
buffering entire packets before pushing. This enables
non-packet streaming clients to work and also lifts the
limitation that our internal DMA buffer needs to be able
to hold entire packets.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/dma/xilinx_axidma.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index a770e12c96..101d32a965 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -111,7 +111,6 @@ struct Stream {
     int nr;
 
     struct SDesc desc;
-    int pos;
     unsigned int complete_cnt;
     uint32_t regs[R_MAX];
     uint8_t app[20];
@@ -267,7 +266,9 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
                                  StreamSlave *tx_control_dev)
 {
     uint32_t prev_d;
-    unsigned int txlen;
+    uint32_t txlen;
+    uint64_t addr;
+    bool eop;
 
     if (!stream_running(s) || stream_idle(s)) {
         return;
@@ -282,24 +283,26 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
         }
 
         if (stream_desc_sof(&s->desc)) {
-            s->pos = 0;
             stream_push(tx_control_dev, s->desc.app, sizeof(s->desc.app), true);
         }
 
         txlen = s->desc.control & SDESC_CTRL_LEN_MASK;
-        if ((txlen + s->pos) > sizeof s->txbuf) {
-            hw_error("%s: too small internal txbuf! %d\n", __func__,
-                     txlen + s->pos);
-        }
 
-        address_space_read(&s->dma->as, s->desc.buffer_address,
-                           MEMTXATTRS_UNSPECIFIED,
-                           s->txbuf + s->pos, txlen);
-        s->pos += txlen;
+        eop = stream_desc_eof(&s->desc);
+        addr = s->desc.buffer_address;
+        while (txlen) {
+            unsigned int len;
+
+            len = txlen > sizeof s->txbuf ? sizeof s->txbuf : txlen;
+            address_space_read(&s->dma->as, addr,
+                               MEMTXATTRS_UNSPECIFIED,
+                               s->txbuf, len);
+            stream_push(tx_data_dev, s->txbuf, len, eop && len == txlen);
+            txlen -= len;
+            addr += len;
+        }
 
-        if (stream_desc_eof(&s->desc)) {
-            stream_push(tx_data_dev, s->txbuf, s->pos, true);
-            s->pos = 0;
+        if (eop) {
             stream_complete(s);
         }
 
-- 
2.20.1


