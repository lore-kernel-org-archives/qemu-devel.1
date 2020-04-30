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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70BFC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B802082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7Qa15wI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B802082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUC4L-0002xT-MC
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUC05-0004yX-MG
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUBzX-0002Nd-7H
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:25:25 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:34862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jUBzW-0002NE-Qa; Thu, 30 Apr 2020 12:24:50 -0400
Received: by mail-lf1-x143.google.com with SMTP id b20so1461331lff.2;
 Thu, 30 Apr 2020 09:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wvXL5mLVIBBifFNgTFevsT1UgUPVMwQaWjtBSTMHn+U=;
 b=S7Qa15wIOG6p7A3F6cUy+ruXNFvVZ5qCti526dN2ejbSDtFukUD6pZ6dwbgw+L0AjV
 2YxtrN152sf4KsiTjRPWoqEWInMDtconAF/MApr3R7e56Au9sbsyrP5PQTmBuHK72Pr/
 Tt6Z8sg+a8X8FYHqNSqvN02UbrjGcRtoGvIqwBeepkQySn4ZkXK1S95AAH3N4zd3g+3U
 LwxqUf/XRX7jIIeNlGPE7o7Zu8bCO9T2tP/pbQdblJOX8MTnWujOe5Mxox6HdpVmQopL
 d+YAhLyn1Bzuu95CpD5TsnGDdp0KQhlqQ8zjAYchzb3jEslC51vEwub5LqOf7sH++eMC
 lsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wvXL5mLVIBBifFNgTFevsT1UgUPVMwQaWjtBSTMHn+U=;
 b=Rmo7xBf27cO7pGIujiMlWZyfJhLHNMENG5LFVp1dubowid0FYiyDpu+Qt86soGc1pC
 mhSTWL9bUihqDemwpXL4O+hqQJH1SQ9EdMNBWypg51KKMblXWAPGuYe0oM4+4qB/kqvk
 83KNaZt3hJGBLJ4QfkZ9zxHIVdSy7uC15Rfy2ebQwCV2nmcFEV5Dr1Gjs3le9jVc+oll
 m95LyOYajsq1qm03lG69rDYGG7EexwZGpLWbFq4FNPqKAp+CMzZATcC52WbNZA3toUFt
 RFPsLZHP1nglnJja3v5wY9k+vAUw3EoGXr5jMy/6Y0Zznaf8tZU/fyeqtix54a0RyVN8
 iLiQ==
X-Gm-Message-State: AGi0PuZhZCzcO85ry+PRbVZ0+BmHetddqsQF/8smwOnrM00MkCekt79P
 0mjYewJAD9pMoolw5+spd4jprmY5G68=
X-Google-Smtp-Source: APiQypJIQ3c/UNyxN5APBrdErRYW0QsLWtz6KdMaA4b3da4UewBgvJStEt1cZUa8UdEyuKzb64EZ9g==
X-Received: by 2002:a05:6512:695:: with SMTP id
 t21mr2758984lfe.158.1588263888678; 
 Thu, 30 Apr 2020 09:24:48 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id 4sm142773ljf.79.2020.04.30.09.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:24:48 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 6/9] hw/net/xilinx_axienet: Handle fragmented packets from
 DMA
Date: Thu, 30 Apr 2020 18:24:36 +0200
Message-Id: <20200430162439.2659-7-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162439.2659-1-edgar.iglesias@gmail.com>
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::143
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

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/xilinx_axienet.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index bd48305577..e3826cf3fc 100644
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
@@ -902,17 +906,28 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size,
     XilinxAXIEnetStreamSlave *ds = XILINX_AXI_ENET_DATA_STREAM(obj);
     XilinxAXIEnet *s = ds->enet;
 
-    /* We don't support fragmented packets yet.  */
-    assert(eop);
-
     /* TX enable ?  */
     if (!(s->tc & TC_TX)) {
         return size;
     }
 
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
@@ -923,7 +938,7 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size,
         uint32_t tmp_csum;
         uint16_t csum;
 
-        tmp_csum = net_checksum_add(size - start_off,
+        tmp_csum = net_checksum_add(s->txpos - start_off,
                                     buf + start_off);
         /* Accumulate the seed.  */
         tmp_csum += s->hdr[2] & 0xffff;
@@ -936,12 +951,13 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size,
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
 
@@ -989,6 +1005,7 @@ static void xilinx_enet_realize(DeviceState *dev, Error **errp)
     s->TEMAC.parent = s;
 
     s->rxmem = g_malloc(s->c_rxmem);
+    s->txmem = g_malloc(s->c_txmem);
     return;
 
 xilinx_enet_realize_fail:
-- 
2.20.1


