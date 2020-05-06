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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B858C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D660720714
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTfZLalE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D660720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFTL-0006Pr-Vv
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWFMs-0004tb-Ct; Wed, 06 May 2020 04:25:26 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:32811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jWFMr-0006wD-J3; Wed, 06 May 2020 04:25:26 -0400
Received: by mail-lj1-x244.google.com with SMTP id w20so1429597ljj.0;
 Wed, 06 May 2020 01:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5ovNDVIh9aVISB0jk7Tkquu58KTUpurc5GPMWob0/GY=;
 b=JTfZLalEmwARRSgAxfRiBfP+XPFK1zs90KWEcCln40Sda51BB9RqmrIcFMNUz0fXVP
 D40xN5UH2u8HrQr/GH1FoM/5rkWtawUy6mObwk3AzPjir9DPOjOzOJoEGwra8xre2YFC
 32SjEk3zY4hxfCLrupo6LBuf9sunXAblEadMhilhSuvf8yW6lXSRM5b/zuOuipYzjUgl
 EzzwcrPLTbEI+gztnTnpmPCFsnOcLhj5+qjF+GqyOOGunZr6135IAb0O1b2vS0CSpcMS
 YS2mfj+IJ0emzmLqBVhOvace5RXMDVuXl/MEEcnGwUBw0nDxh45K0tAl65znsWPNhDOG
 Tqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5ovNDVIh9aVISB0jk7Tkquu58KTUpurc5GPMWob0/GY=;
 b=LEmQPgyv5nau7HwrykA1hMUtptQ0Krqs62jdpXH0J/0LI3Lvtpr97Us0TcTQsdx8Hb
 Oh8TS7m8EyJJpNPFrwApU6buitk9zXpJJEjq/Me0aCg+h5IHl+41OuQoDbJSoAC1EMFK
 uZmj3toS/6vEJi7JA9hG6C0jjbVbWpJLi4ntpdcQqwdMOscY7IHtBNLX0MDx/+7XhXar
 wq5kfbi/EXvnQVvRreCMEb1ECZfSH1aPc4XcZodjBLzcxDD1wlyAWSkV45GkqqPJnK9p
 UdTx6BRrBHiP5pD8JwouT+PPXPkaYa5UKPYTKWVB8GlNIHk0jAStUIMd4m5xEohlkkAX
 aYLw==
X-Gm-Message-State: AGi0PuZnqZZUWv8nsV+Nqum4/ySHxe7mlHx7A9bLDeV8+gHZYgN5E06N
 wfX8Ua21XjG80RvnRzF5ZWy3Bpy/Wmk=
X-Google-Smtp-Source: APiQypL4lvVrK7VhGmOl/kmzACwSMldCij4lHjvoq77Pr4w0ds6dk5g4KeNPnBQtpWij8GdBqqMCbA==
X-Received: by 2002:a2e:9996:: with SMTP id w22mr4235722lji.59.1588753523368; 
 Wed, 06 May 2020 01:25:23 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id c79sm1058584lfg.29.2020.05.06.01.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 01:25:22 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/9] hw/net/xilinx_axienet: Handle fragmented packets from
 DMA
Date: Wed,  6 May 2020 10:25:10 +0200
Message-Id: <20200506082513.18751-7-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506082513.18751-1-edgar.iglesias@gmail.com>
References: <20200506082513.18751-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
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

Add support for fragmented packets from the DMA.

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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


