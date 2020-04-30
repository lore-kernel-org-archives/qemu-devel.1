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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10547C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12D220873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6m73nrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12D220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUC1z-0007Yg-W7
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUC05-0004y3-58
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUBzW-0002NP-3t
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:25:24 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:43045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jUBzV-0002Ml-MX; Thu, 30 Apr 2020 12:24:49 -0400
Received: by mail-lf1-x144.google.com with SMTP id 188so1729674lfa.10;
 Thu, 30 Apr 2020 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bTw+r1KAM6tk84YCEJAq2mxv/RvU4bjcOMBHb9/aNAY=;
 b=o6m73nrX2brIizR12/UF04s1YID7nUjrhwY4h7hbsAx5+8BPgmXj3f8h17rLNeWhMg
 fItL/iVNSR1Vz9GYdvA6mHsEi7fTYMib9LMFoLJgfwHFrxjB0296KS3piloKu/F2ml0z
 lhAQcb9Dm14m27UCHGY51YCQ9+w7k0b6h3FUDh1GKyQEp/AMcwzABkXK132sZRtlCPt3
 pQty+aOVYkC4RCru5C2S2ZINnacHmznnZcrhifSPUZc/nvcUYIolN1oa6o7+y1ZSwsHu
 wZOo52BraTloNGEss0SXTjXNahQu/4SdS8jnFh/DNWYT6AYRpisIm8d5R78J4Tq0OoKO
 h+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bTw+r1KAM6tk84YCEJAq2mxv/RvU4bjcOMBHb9/aNAY=;
 b=W6eQtAJbzVA9/zvcEpFriy9z/pFQogJ120YF6W5CxfGP6AlPf61xohGyGlWKim1M1z
 hNrRfVVE/E5njRrSEiXxvWpd99mTn8s2htkw/yjc7eHjT/C0mpofhQD0XHgOJmhaNI76
 WSkJWGn9NULGSCR3YrLpp2eV79pIAKPMUju5FW/A1elJsiSE+mh3D/TdCBzwYhp81QDi
 NbxkItjZYV+t9hinZh7GvhELyhMYZ/c40FGxFvcvafWq2oGWfHzzVeu486KhFM38K3Oo
 Y6PJnN1El2marXvkmES5H/Uz6sWysYqy0j54xbXNq/0WFbqKV+fiil1J0xD92PukP3Nf
 bZIg==
X-Gm-Message-State: AGi0Pua1qZGWuxWtlAtHwNnrN1+rhmfXY09FY6E5CFiFwTky/rxyIDkN
 JZBnzi2LQIyDxS527q3+2VpujYYZ2Jw=
X-Google-Smtp-Source: APiQypKmiijYOnx0t3iktKUFsw2Cjwyg8/zxOdc7v+O62r9cskr9F5OczlXsTeRkJwyG9ULyXf2bIQ==
X-Received: by 2002:a19:c216:: with SMTP id l22mr2529856lfc.172.1588263887435; 
 Thu, 30 Apr 2020 09:24:47 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id j29sm94670lfp.90.2020.04.30.09.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:24:46 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 5/9] hw/core: stream: Add an end-of-packet flag
Date: Thu, 30 Apr 2020 18:24:35 +0200
Message-Id: <20200430162439.2659-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162439.2659-1-edgar.iglesias@gmail.com>
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::144
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

Some stream clients stream an endless stream of data while
other clients stream data in packets. Stream interfaces
usually have a way to signal the end of a packet or the
last beat of a transfer.

This adds an end-of-packet flag to the push interface.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 include/hw/stream.h     |  5 +++--
 hw/core/stream.c        |  4 ++--
 hw/dma/xilinx_axidma.c  | 10 ++++++----
 hw/net/xilinx_axienet.c | 14 ++++++++++----
 hw/ssi/xilinx_spips.c   |  2 +-
 5 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/hw/stream.h b/include/hw/stream.h
index d02f62ca89..ed09e83683 100644
--- a/include/hw/stream.h
+++ b/include/hw/stream.h
@@ -39,12 +39,13 @@ typedef struct StreamSlaveClass {
      * @obj: Stream slave to push to
      * @buf: Data to write
      * @len: Maximum number of bytes to write
+     * @eop: End of packet flag
      */
-    size_t (*push)(StreamSlave *obj, unsigned char *buf, size_t len);
+    size_t (*push)(StreamSlave *obj, unsigned char *buf, size_t len, bool eop);
 } StreamSlaveClass;
 
 size_t
-stream_push(StreamSlave *sink, uint8_t *buf, size_t len);
+stream_push(StreamSlave *sink, uint8_t *buf, size_t len, bool eop);
 
 bool
 stream_can_push(StreamSlave *sink, StreamCanPushNotifyFn notify,
diff --git a/hw/core/stream.c b/hw/core/stream.c
index 39b1e595cd..a65ad1208d 100644
--- a/hw/core/stream.c
+++ b/hw/core/stream.c
@@ -3,11 +3,11 @@
 #include "qemu/module.h"
 
 size_t
-stream_push(StreamSlave *sink, uint8_t *buf, size_t len)
+stream_push(StreamSlave *sink, uint8_t *buf, size_t len, bool eop)
 {
     StreamSlaveClass *k =  STREAM_SLAVE_GET_CLASS(sink);
 
-    return k->push(sink, buf, len);
+    return k->push(sink, buf, len, eop);
 }
 
 bool
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 4540051448..a770e12c96 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -283,7 +283,7 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
 
         if (stream_desc_sof(&s->desc)) {
             s->pos = 0;
-            stream_push(tx_control_dev, s->desc.app, sizeof(s->desc.app));
+            stream_push(tx_control_dev, s->desc.app, sizeof(s->desc.app), true);
         }
 
         txlen = s->desc.control & SDESC_CTRL_LEN_MASK;
@@ -298,7 +298,7 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
         s->pos += txlen;
 
         if (stream_desc_eof(&s->desc)) {
-            stream_push(tx_data_dev, s->txbuf, s->pos);
+            stream_push(tx_data_dev, s->txbuf, s->pos, true);
             s->pos = 0;
             stream_complete(s);
         }
@@ -384,7 +384,7 @@ static void xilinx_axidma_reset(DeviceState *dev)
 
 static size_t
 xilinx_axidma_control_stream_push(StreamSlave *obj, unsigned char *buf,
-                                  size_t len)
+                                  size_t len, bool eop)
 {
     XilinxAXIDMAStreamSlave *cs = XILINX_AXI_DMA_CONTROL_STREAM(obj);
     struct Stream *s = &cs->dma->streams[1];
@@ -416,12 +416,14 @@ xilinx_axidma_data_stream_can_push(StreamSlave *obj,
 }
 
 static size_t
-xilinx_axidma_data_stream_push(StreamSlave *obj, unsigned char *buf, size_t len)
+xilinx_axidma_data_stream_push(StreamSlave *obj, unsigned char *buf, size_t len,
+                               bool eop)
 {
     XilinxAXIDMAStreamSlave *ds = XILINX_AXI_DMA_DATA_STREAM(obj);
     struct Stream *s = &ds->dma->streams[1];
     size_t ret;
 
+    assert(eop);
     ret = stream_process_s2mem(s, buf, len);
     stream_update_irq(s);
     return ret;
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index c8dfcda3ee..bd48305577 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -697,14 +697,14 @@ static void axienet_eth_rx_notify(void *opaque)
                                            axienet_eth_rx_notify, s)) {
         size_t ret = stream_push(s->tx_control_dev,
                                  (void *)s->rxapp + CONTROL_PAYLOAD_SIZE
-                                 - s->rxappsize, s->rxappsize);
+                                 - s->rxappsize, s->rxappsize, true);
         s->rxappsize -= ret;
     }
 
     while (s->rxsize && stream_can_push(s->tx_data_dev,
                                         axienet_eth_rx_notify, s)) {
         size_t ret = stream_push(s->tx_data_dev, (void *)s->rxmem + s->rxpos,
-                                 s->rxsize);
+                                 s->rxsize, true);
         s->rxsize -= ret;
         s->rxpos += ret;
         if (!s->rxsize) {
@@ -874,12 +874,14 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
 }
 
 static size_t
-xilinx_axienet_control_stream_push(StreamSlave *obj, uint8_t *buf, size_t len)
+xilinx_axienet_control_stream_push(StreamSlave *obj, uint8_t *buf, size_t len,
+                                   bool eop)
 {
     int i;
     XilinxAXIEnetStreamSlave *cs = XILINX_AXI_ENET_CONTROL_STREAM(obj);
     XilinxAXIEnet *s = cs->enet;
 
+    assert(eop);
     if (len != CONTROL_PAYLOAD_SIZE) {
         hw_error("AXI Enet requires %d byte control stream payload\n",
                  (int)CONTROL_PAYLOAD_SIZE);
@@ -894,11 +896,15 @@ xilinx_axienet_control_stream_push(StreamSlave *obj, uint8_t *buf, size_t len)
 }
 
 static size_t
-xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size)
+xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size,
+                                bool eop)
 {
     XilinxAXIEnetStreamSlave *ds = XILINX_AXI_ENET_DATA_STREAM(obj);
     XilinxAXIEnet *s = ds->enet;
 
+    /* We don't support fragmented packets yet.  */
+    assert(eop);
+
     /* TX enable ?  */
     if (!(s->tc & TC_TX)) {
         return size;
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index c57850a505..4cfce882ab 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -868,7 +868,7 @@ static void xlnx_zynqmp_qspips_notify(void *opaque)
 
         memcpy(rq->dma_buf, rxd, num);
 
-        ret = stream_push(rq->dma, rq->dma_buf, num);
+        ret = stream_push(rq->dma, rq->dma_buf, num, false);
         assert(ret == num);
         xlnx_zynqmp_qspips_check_flush(rq);
     }
-- 
2.20.1


