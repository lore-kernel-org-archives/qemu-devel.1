Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0FBC47253
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262532070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDZoj706"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262532070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUC7C-0006gM-7o
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUC07-0004zH-0G
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUBzZ-0002TY-NA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:25:26 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:35984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jUBzZ-0002Nl-8H; Thu, 30 Apr 2020 12:24:53 -0400
Received: by mail-lf1-x142.google.com with SMTP id w14so1754783lfk.3;
 Thu, 30 Apr 2020 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zPUxzOtPNu1fe6DQ31CH/IJkXZJ41diGLg/8g0TM01Q=;
 b=XDZoj706sfilJrlYBVD7FpNCu/SZKuAcP15OGZY7RXiPEVP0pvgwHJLY+CYZ0OlERa
 KBXXcHiUspRR0h2pbuAgtdfxujBjzT/xQw+dA0exo0ErOWosU+6HuK1KAR9Ho2kAYiDX
 fI4gjemU9yiRXKOsjGo5m8Qosmz4ZjzfMWJI09W99G/2/aqzmRrbq7DnexpUbeSB97hF
 75tWsubItWhVgvm9b4kTLiJ7gQVX1q928heJii+DDcKg/R/CUbFGsn4mUkVtGsT09ddQ
 qTqXh0vMcA0JVQ9bGTZKBTi+2xxvhUfMyEdCouq+a3rd8CdKydaNlzkBi2A6SHt/rwTD
 KwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zPUxzOtPNu1fe6DQ31CH/IJkXZJ41diGLg/8g0TM01Q=;
 b=kGTu1k6+1gqN4jZv0x+c8zchdx0wteNA5AQFdAmfvPLuGX81eQvY7hOhUwJeZZk6J9
 TdyoYcK1jGuxntVh2AtKEiaZvrkbqJN5QaVUtD2B3Bu8DIEUfYD91FR2T6K6JHViJGC5
 0/l4ecJk6k2HDboD2q79O71mfmi9+E54arhk+siUa4etVoBzghtabcJ2mS7CSO6/k4h1
 BxcBEwu/Yj0mTzQSvs7huxFy8ARPc74VG9e2azx3q+8LFuWa1p1EJlVS2ppwmb0Mugpa
 ItbEfdMVUroJgthhK/5om5z7G0QkfUJ+2Z6ible6q+FETXdCWbH9sEgSIwKuEGcWj2is
 NiFA==
X-Gm-Message-State: AGi0PuZZbNdQ8AFbVt857ZrBbKm36knNadA0WHoucQ8nJGr54DqHtqgo
 I1LmfF6hBEAM2ayxXORsxcgbEjKJ84A=
X-Google-Smtp-Source: APiQypKa17ljhc6s7yByIeJR1qoEdsq5qsqlHDMWcPsDElLbQYXt/Mt/TZ6CvPv/vQ91iqac3ugx9A==
X-Received: by 2002:a05:6512:3ef:: with SMTP id
 n15mr2456368lfq.2.1588263891061; 
 Thu, 30 Apr 2020 09:24:51 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id y22sm74264lfg.92.2020.04.30.09.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:24:50 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 8/9] hw/dma/xilinx_axidma: s2mm: Support stream fragments
Date: Thu, 30 Apr 2020 18:24:38 +0200
Message-Id: <20200430162439.2659-9-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162439.2659-1-edgar.iglesias@gmail.com>
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::142
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


