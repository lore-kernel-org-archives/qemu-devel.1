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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BE2C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05F3206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlpJrtf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05F3206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFOU-0007Od-2b
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWFMu-00051Q-Ul; Wed, 06 May 2020 04:25:28 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:38442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWFMu-00073Z-42; Wed, 06 May 2020 04:25:28 -0400
Received: by mail-lf1-x141.google.com with SMTP id b26so590738lfa.5;
 Wed, 06 May 2020 01:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NaSEyUeZ9S0dTahKUfWHsZLASINecx9/Ty+xCY+lnUM=;
 b=jlpJrtf1UygfuR3unn7/nIQAbh6KbBdWELtRxn1KR49MTDuEni7FYFCvnkGZ89Gwfx
 j87SsFkCGJAL+T00jPThFEiYtMklBS6hE0VoXQHpHb4pKnLQsMclaDiPFDAY4j6ztL20
 Z1G/zzw6ZDQJFQyPB7WVKJqVS4UABXFLy2uqGfJzkGHjJxnJhnKxuZXuc1qxycpzPbJX
 7sEFMmEEy/xkOJNzRvGa9kvi/Ti+p/Hj5SxJz9Pm55VGW8XSeRjrNvLsUNv+r7BNjiU1
 Gumg3bzSMsp0sKqB9QdTmgGjwrY3DR+a2n5HrXRhuJwqPT5/6JHc3my/jbHTyr6kOWM8
 OhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NaSEyUeZ9S0dTahKUfWHsZLASINecx9/Ty+xCY+lnUM=;
 b=icicGE+9O7VAtr10NMVMYWtVO2X0ZpllOBoHUTaOq+IhbKB4auRt+q1wGnyNfAbxvs
 dcU1Bc1DYs9771RdMgz54OtfNKW1qPC5XQcx6FsEOnKasr08kI7He8Z5iH0h0qrjVq9d
 ZdUadZG0jqFUy8FKRLAj4y49XB4EeVyV+A9La3JYlKx4mmCFhsPHVWT9uuop7wkvBEer
 c/pKjfYDZwE9muKp30KPGHA4Vi1p8hdQLndPvfxT2W22LB/JTOMUtcWMxcZR31bbMhgn
 eyIeLKAcG5SF7zCh7WOvKDbwhPRht1GCXHBQMwYT9sMI2DxvzpHFbu5t6ieuv+C4IgO+
 9Jjg==
X-Gm-Message-State: AGi0PuaNlPJLYqIWpSIKvHfbbmVIMc93Z0msAW/x+aOqemVVjohiBUP6
 XBnBvM7CKtlRXR5vyopipS9lp2p3B1U=
X-Google-Smtp-Source: APiQypKOq3M4E9XPW7W1ExvHD9SwIQA3TJzgbelRFZmq3amCbMWnSmybqmYwNzQzNAwhcg93opyFXg==
X-Received: by 2002:ac2:5091:: with SMTP id f17mr4468696lfm.166.1588753525933; 
 Wed, 06 May 2020 01:25:25 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id a13sm808910ljm.25.2020.05.06.01.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 01:25:25 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 8/9] hw/dma/xilinx_axidma: s2mm: Support stream fragments
Date: Wed,  6 May 2020 10:25:12 +0200
Message-Id: <20200506082513.18751-9-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506082513.18751-1-edgar.iglesias@gmail.com>
References: <20200506082513.18751-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x141.google.com
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

Add support for stream fragments.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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


