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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F413AC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11862070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSjQsqDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11862070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUC7B-0006ea-Tr
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUC06-0004zA-6t
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUBzY-0002Ns-F6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:25:25 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:34228)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jUBzY-0002NX-23; Thu, 30 Apr 2020 12:24:52 -0400
Received: by mail-lj1-x244.google.com with SMTP id f11so2499ljp.1;
 Thu, 30 Apr 2020 09:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SupxvvkaQXyN9EdBNwThK6ET+TCX07xPKPS0LjTpIqo=;
 b=cSjQsqDpB6yIB6FBDFvmrnAXqeDXnQBJiXV0AmrF5QhMR3FNX3GGJ7pxvTEYHv2xHt
 6n05oLZXF49cb0SncqnVKglVsOhbPiLuwzfFYT97jFFjPVqWg2Av/qvpbn69bLJ3JEmV
 vbO81l79xndJxP0LuV4DyWV/ybKOb++R5Oq/RUVEZfmsiVX8xJ9d0dJz9IVkNdyZ8vjS
 AZnVNdT3gAXtNiGAFDEz90zU1rR5CAQCPFMlr+miJWELLGpd2/SNN30baKqq4Z5HzI/3
 No2NPVdf9Ze8P1UdLN1CR0wvVbfs9FD5b1x1rfTTWz+DJdEa3i6Li+chbsFKXL2hioUE
 MTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SupxvvkaQXyN9EdBNwThK6ET+TCX07xPKPS0LjTpIqo=;
 b=gWSnJK7l15NJIteEl+o0B85I1OrNzCgbXs8orzTMfliD4FvEnkHlUE0W6MDnnmbMta
 G4rKzIv34o6Sg7HRK8QDiAQqlROhtJlbGqfJoIyc8JwQ1yKCI5LaFzpj7vtiCm742vvi
 DgSbmwJJt5DtACqXNSrA5ApqyTc27cKvYq0uI8U5ppJZ5eaXuQO9dJe0D9Dls/oVXUyy
 zoMKHazvRKSbzpNGwqsO6mV7C7aqRP0LEBi6juqEIAJnt1rm+0YhUyaEPxeTOQLhjKyg
 mKjrks/FHWX5UbJlte+L6S+wh0zppFyFbWpoudESLGshm6hHFcaZiFzEGocp0609RVeX
 mDOg==
X-Gm-Message-State: AGi0PuaLlKJSB89luDzVgOujtVQ4oEt3sic4AKt1yP+mcBsF2Z+gOj80
 IiEBk0XBcKXr0T4/mAC9k4MHykq8ikQ=
X-Google-Smtp-Source: APiQypIyGX0nWAhPB/9dbJregXrN/bpsPhTQ7Nz9vk8T3+oO/6p7Old+vTXcfk0gcjdnOpqjtNZ2Bw==
X-Received: by 2002:a2e:994a:: with SMTP id r10mr52814ljj.105.1588263889890;
 Thu, 30 Apr 2020 09:24:49 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id t16sm150172ljg.41.2020.04.30.09.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:24:49 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 7/9] hw/dma/xilinx_axidma: mm2s: Stream descriptor by
 descriptor
Date: Thu, 30 Apr 2020 18:24:37 +0200
Message-Id: <20200430162439.2659-8-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162439.2659-1-edgar.iglesias@gmail.com>
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::244
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


