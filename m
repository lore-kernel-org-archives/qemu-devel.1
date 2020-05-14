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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10E3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A692220671
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQJ5cl99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A692220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEg0-0004ID-O3
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcp-0007UA-1O
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:15 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:42354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEco-0003mK-6m
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:14 -0400
Received: by mail-lf1-x141.google.com with SMTP id r17so2755054lff.9
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sp83rpbpKuac9eJJl865F4UVUA5uZfXjhS96fufoN2M=;
 b=mQJ5cl99YfUAZiaWT3ZjLdrxI4KVmFmYTmxD+nkV7u+mhdh5YWV/yhUl7uaHI+NKKK
 A3mP9RF2KNOThGz4aAqt2zuF7UMNUu976AWQvG+FtJw9Rkw+qfi5UhGOLxhmt/o2EjiF
 x8yN8BLSRW6wYpuiJLF5pCHimBONCRMpNSbUlkRU5pFwYL26OvidgrcetjFyTDFBA3S2
 xbO7yNCUNdtLsqzqd4dHl6F33H+mmfcHNUyCc4pWzuAMxzKuUHF8mqsmheJ2l8sDD8tM
 qjipDlFZx0NepA2GROUiRr8ueQ4S0np27hvAkkxuyIYB5jq+BMFc9UgBMMsaGaJ+rXGn
 n1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sp83rpbpKuac9eJJl865F4UVUA5uZfXjhS96fufoN2M=;
 b=OcX4ELINj5xDE+LFuXjIn3LCNjs14onm9QQCrmhYJorjkZm71Vf95Ns7m7+VWrQ8XO
 itcqeX0My3YXrX2c65rfEJWmKVWPimepgomGNcgUp8jcglO8FeYKVSY2RmZfW4SpgpAE
 eBd4MDdISm6Qfyi2jMjJYO6HdhMTP6Jx3oifLmh0OxSnGHKng+Khp3+cnDg/G+7ikRWk
 0FLTWLVOIScVxshJhCx4pfFjr4Q1CCiYqtSiCdlxpH03JpUKikGCqHGh0wNSetFVAZ0B
 wZYZ1KoqukIOSqFzNQRN7KQq3EmWazoerINu283eLoLIWDYW4Xk3Jhbvafmo57YIaYPO
 n+NQ==
X-Gm-Message-State: AOAM5336OFd6YFrwGOzno6jTMbg+C5yef6du4Qj6yDELT/NXPdpiqUoS
 ew6MtT5wFakYBsCjAusjl6NvinGcu3M=
X-Google-Smtp-Source: ABdhPJz/ZHo+a/9RH9HvuWlH3gXiDcAgxScGqmlxPbzxabjshYHHNIS1ExN2jXB0ftRyw6Wu14pQrA==
X-Received: by 2002:a19:490d:: with SMTP id w13mr3456339lfa.96.1589465652110; 
 Thu, 14 May 2020 07:14:12 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id f27sm1896658lfe.93.2020.05.14.07.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:14:11 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 06/14] hw/net/xilinx_axienet: Handle fragmented packets from
 DMA
Date: Thu, 14 May 2020 16:13:54 +0200
Message-Id: <20200514141402.12498-7-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514141402.12498-1-edgar.iglesias@gmail.com>
References: <20200514141402.12498-1-edgar.iglesias@gmail.com>
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add support for fragmented packets from the DMA.

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-Id: <20200506082513.18751-7-edgar.iglesias@gmail.com>
---
 hw/net/xilinx_axienet.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index bd48305577..498afe2f54 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -402,6 +402,9 @@ struct XilinxAXIEnet {
 
     uint32_t hdr[CONTROL_PAYLOAD_WORDS];
 
+    uint8_t *txmem;
+    uint32_t txpos;
+
     uint8_t *rxmem;
     uint32_t rxsize;
     uint32_t rxpos;
@@ -421,6 +424,7 @@ static void axienet_rx_reset(XilinxAXIEnet *s)
 static void axienet_tx_reset(XilinxAXIEnet *s)
 {
     s->tc = TC_JUM | TC_TX | TC_VLAN;
+    s->txpos = 0;
 }
 
 static inline int axienet_rx_resetting(XilinxAXIEnet *s)
@@ -902,17 +906,35 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size,
     XilinxAXIEnetStreamSlave *ds = XILINX_AXI_ENET_DATA_STREAM(obj);
     XilinxAXIEnet *s = ds->enet;
 
-    /* We don't support fragmented packets yet.  */
-    assert(eop);
-
     /* TX enable ?  */
     if (!(s->tc & TC_TX)) {
         return size;
     }
 
+    if (s->txpos + size > s->c_txmem) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Packet larger than txmem\n",
+                      TYPE_XILINX_AXI_ENET);
+        s->txpos = 0;
+        return size;
+    }
+
+    if (s->txpos == 0 && eop) {
+        /* Fast path single fragment.  */
+        s->txpos = size;
+    } else {
+        memcpy(s->txmem + s->txpos, buf, size);
+        buf = s->txmem;
+        s->txpos += size;
+
+        if (!eop) {
+            return size;
+        }
+    }
+
     /* Jumbo or vlan sizes ?  */
     if (!(s->tc & TC_JUM)) {
-        if (size > 1518 && size <= 1522 && !(s->tc & TC_VLAN)) {
+        if (s->txpos > 1518 && s->txpos <= 1522 && !(s->tc & TC_VLAN)) {
+            s->txpos = 0;
             return size;
         }
     }
@@ -923,7 +945,7 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size,
         uint32_t tmp_csum;
         uint16_t csum;
 
-        tmp_csum = net_checksum_add(size - start_off,
+        tmp_csum = net_checksum_add(s->txpos - start_off,
                                     buf + start_off);
         /* Accumulate the seed.  */
         tmp_csum += s->hdr[2] & 0xffff;
@@ -936,12 +958,13 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size,
         buf[write_off + 1] = csum & 0xff;
     }
 
-    qemu_send_packet(qemu_get_queue(s->nic), buf, size);
+    qemu_send_packet(qemu_get_queue(s->nic), buf, s->txpos);
 
-    s->stats.tx_bytes += size;
+    s->stats.tx_bytes += s->txpos;
     s->regs[R_IS] |= IS_TX_COMPLETE;
     enet_update_irq(s);
 
+    s->txpos = 0;
     return size;
 }
 
@@ -989,6 +1012,7 @@ static void xilinx_enet_realize(DeviceState *dev, Error **errp)
     s->TEMAC.parent = s;
 
     s->rxmem = g_malloc(s->c_rxmem);
+    s->txmem = g_malloc(s->c_txmem);
     return;
 
 xilinx_enet_realize_fail:
-- 
2.20.1


