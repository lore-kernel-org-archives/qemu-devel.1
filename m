Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2960C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A7E20707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJ+jcONY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A7E20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCXA-0001v8-Qm
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTn-0005Fn-OT
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTm-0002qh-Or
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:43 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCTm-0002pv-J1
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:42 -0500
Received: by mail-wr1-x433.google.com with SMTP id c9so4774130wrw.8
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=z+ASr97qRHWdGDkuW0JTlLEKSAPzhK7Fyg2RWeqPj4E=;
 b=UJ+jcONYjiFdetct/5mTdvSIUPUpfHoQ84c1AWZAal4xlRl5SiuhdwV4PnNXJMPiw2
 qdqquTRFpEQOLWp4krtuWKM6fnBIHt4IJQM7ZofohbFC+IwV2bPdC47eY850F3yi4eDG
 AXMmJOK7rwGC611zMlZQ46/AyNWiM7Cid/aK8pqYBi2s85N3Xv3sMCTQ9g0jlF2lHLY8
 vYjko7XXXphg+ne8pVHcjOAG0rRplCgwZsOTwlLVDYa1F/QXzhNKQO6HLcLuCt7n1iY2
 AYMUxyeny1g/ifOQC/HpoRkmxLOAXa6+mfylhSP68m82K1BL0gZ9t65ACoTx84vDmCT7
 FWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z+ASr97qRHWdGDkuW0JTlLEKSAPzhK7Fyg2RWeqPj4E=;
 b=fcTETRVv33wTPfGdg0dylaYAvdKgFYNcqpOFsG5Har1leINhtQn3oUJqZs9aeRpItQ
 PuDJh2vufOOKB5qcOi3YHXAs/Wt8ByCnowxMEk5QbKNtbSAh4bwp9ApPSMnmZtNcO5wX
 Fz8uRQa8xdtsBiYz3J4FwzYzUMg2Iq3S0YoLwCjmspChnOpbS+AhKnx7nfgf+iP4+1FI
 IF4GSZjO4N6JJoB/B87FA7RyTpiPia6abCS0cicMx3FgjoYPNoRIdpNB7PMxRy981fIg
 YOEwxD6IYnsvnUDbvqCDSAdb7WHZm5qUd34Q/tNQ9/Vp2gWbe12Curn9pC4b201b36EW
 Xv8w==
X-Gm-Message-State: APjAAAWkMEr2gTDToMHRfOp7reSP9OKRJfLt9YDPL/qwxUrAaidancOv
 duI4ry/q6iKegIJLKalB37lnK1v4OGYgew==
X-Google-Smtp-Source: APXvYqx9d4NGVezLRdPDGBvrNTPvlTpcHuU1B14LaZPUBPp0OWur0Ueb7CIF7tNntnmgSKnjn/DeGg==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr6543503wrh.121.1580400941313; 
 Thu, 30 Jan 2020 08:15:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/26] ftgmac100: check RX and TX buffer alignment
Date: Thu, 30 Jan 2020 16:15:12 +0000
Message-Id: <20200130161533.8180-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

These buffers should be aligned on 16 bytes.

Ignore invalid RX and TX buffer addresses and log an error. All
incoming and outgoing traffic will be dropped because no valid RX or
TX descriptors will be available.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200114103433.30534-4-clg@kaod.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/ftgmac100.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 4ad2594d3a6..2f92b65d4ef 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -198,6 +198,8 @@ typedef struct {
     uint32_t        des3;
 } FTGMAC100Desc;
 
+#define FTGMAC100_DESC_ALIGNMENT 16
+
 /*
  * Specific RTL8211E MII Registers
  */
@@ -722,6 +724,12 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
         s->itc = value;
         break;
     case FTGMAC100_RXR_BADR: /* Ring buffer address */
+        if (!QEMU_IS_ALIGNED(value, FTGMAC100_DESC_ALIGNMENT)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad RX buffer alignment 0x%"
+                          HWADDR_PRIx "\n", __func__, value);
+            return;
+        }
+
         s->rx_ring = value;
         s->rx_descriptor = s->rx_ring;
         break;
@@ -731,6 +739,11 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
         break;
 
     case FTGMAC100_NPTXR_BADR: /* Transmit buffer address */
+        if (!QEMU_IS_ALIGNED(value, FTGMAC100_DESC_ALIGNMENT)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad TX buffer alignment 0x%"
+                          HWADDR_PRIx "\n", __func__, value);
+            return;
+        }
         s->tx_ring = value;
         s->tx_descriptor = s->tx_ring;
         break;
-- 
2.20.1


